require 'rails_helper'

RSpec.describe RejectAttributesConcern do
  class DummyConcerned
    include RejectAttributesConcern
  end

  describe ".all_blank?" do
    context 'with every attribute being blank?' do
      subject { DummyConcerned.all_blank? :name, :surname }
      it 'is expected to be false' do
        expect(subject.call(name: '', surname: '', phone: '12345678')).to eq(true)
      end
    end

    context 'with at least one attribute not being blank?' do
      subject { DummyConcerned.all_blank? :name, :surname }
      it 'is expected to be true' do
        expect(subject.call(name: 'John', surname: '')).to eq(false)
      end
    end
  end
end
