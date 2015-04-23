require 'rails_helper'

RSpec.describe Children::LifePeriodForWeek do
  it 'is :pregnancy if the life period is pregnancy' do
    pregnancy = true

    checker = Children::LifePeriodForWeek.new(nil, nil, pregnancy)

    expect(checker.life_period).to eq(:pregnancy)
  end

  it 'is first_to_fourth if life period is at most 4 months' do
    min_week =  1
    max_week = 14
    pregnancy = false

    checker = Children::LifePeriodForWeek.new(min_week, max_week, pregnancy)

    expect(checker.life_period).to eq(:first_to_fourth)
  end

  it 'is fifth_to_eighth if life period is between 5 to 8 months' do
    min_week =  17
    max_week = 32
    pregnancy = false

    checker = Children::LifePeriodForWeek.new(min_week, max_week, pregnancy)

    expect(checker.life_period).to eq(:fifth_to_eighth)
  end

  it 'is nineth_to_twelfth if life period is between 9 to 12 months' do
    min_week =  33
    max_week = 48
    pregnancy = false

    checker = Children::LifePeriodForWeek.new(min_week, max_week, pregnancy)

    expect(checker.life_period).to eq(:nineth_to_twelfth)
  end

  it 'is thirteenth_to_fifteenth if life period is between 13 to 15 months' do
    min_week =  49
    max_week = 60
    pregnancy = false

    checker = Children::LifePeriodForWeek.new(min_week, max_week, pregnancy)

    expect(checker.life_period).to eq(:thirteenth_to_fifteenth)
  end

  it 'is thirteenth_to_fifteenth if life period is greater than 15 months' do
    min_week =  61
    max_week = 62
    pregnancy = false

    checker = Children::LifePeriodForWeek.new(min_week, max_week, pregnancy)

    expect(checker.life_period).to eq(:thirteenth_to_fifteenth)
  end

  it 'is thirteenth_to_fifteenth by default' do
    min_week =  nil
    max_week = nil
    pregnancy = false

    checker = Children::LifePeriodForWeek.new(min_week, max_week, pregnancy)

    expect(checker.life_period).to eq(:thirteenth_to_fifteenth)
  end
end
