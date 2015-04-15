require 'rails_helper'

describe ChildrenController do
  describe 'GET index' do
    let(:user) { create(:user, :with_profile, :site_user, :confirmed) }
    before :each do
      authenticate_through_headers(user.email, user.password)
    end

    it 'returns the list of children' do
      children = user.profile.children
      response = get :index
      expect(response.status).to eq(200)

      parsed_response = JSON.parse(response.body)
      expect(parsed_response.map { |c| c['name'] })
        .to eq([children.first.name, children.last.name])
    end

    it 'returns only children that belongs to the current profile' do
      shouldnt_be_children = create_pair(:child)
      response = get :index
      expect(response.status).to eq(200)

      parsed_response = JSON.parse(response.body)

      expect(parsed_response.map { |c| c['name'] })
        .to_not include(shouldnt_be_children.first.name, shouldnt_be_children.last.name)
    end
  end

  describe 'POST create' do
    let(:user) { create(:user, :with_profile, :site_user, :confirmed) }
    before :each do
      authenticate_through_headers(user.email, user.password)
    end

    it 'returns 200 with a valid result' do
      child = attributes_for(:child)
      response = post :create, child: child
      expect(response.status).to eq(200)
    end

    it 'includes a child in the database' do
      child = attributes_for(:child)
      expect { post :create, child: child }.to change { Child.count }.by(1)
    end

    it 'associates the children with the current profile' do
      profile = user.profile
      child = attributes_for(:child)

      expect { post :create, child: child }.to change { Child.count }.by(1)
      profile.reload

      expect(profile.children.map(&:name)).to include(child[:name])
    end

    it 'returns the list of errors if invalid data is posted' do
      child = attributes_for(:child).merge(birth_date: '')
      response = post :create, child: child

      parsed_response = JSON.parse(response.body)
      expect(parsed_response['errors']['birth_date']).to include('não pode ser vazio')
    end
  end
end
