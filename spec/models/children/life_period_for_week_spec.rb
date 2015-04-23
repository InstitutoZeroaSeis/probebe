require 'spec_helper'

RSpec.describe Children::LifePeriodForWeek do
  it 'is :pregnancy if the life period is pregnancy' do
    pregnancy = true

    checker = Children::LifePeriodForWeek.new(nil, nil, pregnancy)

    expect(checker.life_period).to eq(:pregnancy)
  end

  it 'is first_to_fourth if life period is at most 4 months' do
    start_week =  1
    end_week = 14
    pregnancy = false

    checker = Children::LifePeriodForWeek.new(start_week, end_week, pregnancy)

    expect(checker.life_period).to eq(:first_to_fourth)
  end

  it 'is fifth_to_eighth if life period is between 5 to 8 months' do
    start_week =  17
    end_week = 32
    pregnancy = false

    checker = Children::LifePeriodForWeek.new(start_week, end_week, pregnancy)

    expect(checker.life_period).to eq(:fifth_to_eighth)
  end

  it 'is nineth_to_twelfth if life period is between 9 to 12 months' do
    start_week =  33
    end_week = 48
    pregnancy = false

    checker = Children::LifePeriodForWeek.new(start_week, end_week, pregnancy)

    expect(checker.life_period).to eq(:nineth_to_twelfth)
  end

  it 'is thirteenth_to_fifteenth if life period is between 13 to 15 months' do
    start_week =  49
    end_week = 60
    pregnancy = false

    checker = Children::LifePeriodForWeek.new(start_week, end_week, pregnancy)

    expect(checker.life_period).to eq(:thirteenth_to_fifteenth)
  end

  it 'is thirteenth_to_fifteenth if life period is greater than 15 months' do
    start_week =  61
    end_week = 62
    pregnancy = false

    checker = Children::LifePeriodForWeek.new(start_week, end_week, pregnancy)

    expect(checker.life_period).to eq(:thirteenth_to_fifteenth)
  end

  it 'uses start_week if end_week is nil' do
    start_week = 30
    end_week = nil
    pregnancy = false

    checker = Children::LifePeriodForWeek.new(start_week, end_week, pregnancy)

    expect(checker.life_period).to eq(:fifth_to_eighth)
  end

  it 'uses end_week if start_week is nil' do
    start_week = nil
    end_week = 60
    pregnancy = false

    checker = Children::LifePeriodForWeek.new(start_week, end_week, pregnancy)

    expect(checker.life_period).to eq(:thirteenth_to_fifteenth)
  end

  it 'is fifth_to_eigth if the given range is near it' do
    start_week = 10
    end_week = 22
    pregnancy = false

    checker = Children::LifePeriodForWeek.new(start_week, end_week, pregnancy)

    expect(checker.life_period).to eq(:fifth_to_eighth)
  end

  it 'is thirteenth_to_fifteenth if the given range exceeds the limits' do
    start_week = 90
    end_week = 100
    pregnancy = false

    checker = Children::LifePeriodForWeek.new(start_week, end_week, pregnancy)

    expect(checker.life_period).to eq(:thirteenth_to_fifteenth)
  end
end
