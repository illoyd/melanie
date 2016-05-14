require 'rails_helper'

RSpec.describe Detectors::HashtagDetector do

  it 'finds a simple hashtag' do
    input    = '#test'
    expected = [Detectors::HashtagEntity.new('test', 0, 5)]
    expect( subject.detect(input) ).to match_array(expected)
  end

  it 'finds a hashtag in a sentence' do
    input = 'Hi, I\'m a #hashtag!'
    expected = [Detectors::HashtagEntity.new('hashtag', 10, 18)]
    expect( subject.detect(input) ).to match_array(expected)
  end

  it 'returns nothing if no hashtags' do
    input = 'No hashtags in this sentence!'
    expected = []
    expect( subject.detect(input) ).to match_array(expected)
  end

  it 'returns duplicated hashtags' do
    input = 'I just love #hashtags, don\'t you love #hashtags?'
    expected = [
      Detectors::HashtagEntity.new('hashtags', 12, 21),
      Detectors::HashtagEntity.new('hashtags', 38, 47)
    ]
    expect( subject.detect(input) ).to match_array(expected)
  end

end
