require 'rails_helper'

#require './app/classes/detectors/cashtag_detector'

RSpec.describe Detectors::CashtagDetector do

  it 'finds a simple cashtag' do
    input    = '$APPL'
    expected = [Detectors::CashtagEntity.new('APPL', 0, 5)]
    expect( subject.detect(input) ).to match_array(expected)
  end

  it 'finds a cashtag in a sentence' do
    input = 'You should follow $TWTR.'
    expected = [Detectors::CashtagEntity.new('TWTR', 18, 23)]
    expect( subject.detect(input) ).to match_array(expected)
  end

  it 'returns nothing if no cashtags' do
    input = 'No cashtags in this sentence!'
    expected = []
    expect( subject.detect(input) ).to match_array(expected)
  end

  it 'returns duplicated cashtags' do
    input = 'I just love $IBM, don\'t you love $IBM?'
    expected = [
      Detectors::CashtagEntity.new('IBM', 12, 16),
      Detectors::CashtagEntity.new('IBM', 33, 37)
    ]
    expect( subject.detect(input) ).to match_array(expected)
  end

  it 'returns nothing if no cashtags' do
    pending 'Cannot detect non-$ cashtags yet'
    input = 'You should follow £TWTR.'
    expected = [Detectors::CashtagEntity.new('TWTR', 18, 23)]
    expect( subject.detect(input) ).to match_array(expected)
  end

end
