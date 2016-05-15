require 'rails_helper'

RSpec.describe AddMentionsForContentJob, :with_database do

  context 'with new hashtags' do
    let(:author)         { Person.create!(full_name: 'Test McTester') }
    let(:content_object) { Note.create!(body: 'Hello, I just love #hashtags. #hashtagsforlife #reallycool', created_by: author) }

    it 'creates three hashtags' do
      expect{ subject.perform(content_object) }.to change{ Hashtag.all.count }.from(0).to(3)
    end

    it 'creates #hashtags' do
      expect{ subject.perform(content_object) }.to change{ Hashtag.find_by(text: 'hashtags') }.from(nil)
    end

    it 'creates #hashtagsforlife' do
      expect{ subject.perform(content_object) }.to change{ Hashtag.find_by(text: 'hashtagsforlife') }.from(nil)
    end

    it 'creates #reallycool' do
      expect{ subject.perform(content_object) }.to change{ Hashtag.find_by(text: 'reallycool') }.from(nil)
    end

    it 'creates new mentions' do
      expect( content_object.mentions ).to be_blank
      subject.perform(content_object)
      content_object.reload!
      expect( content_object.mentions ).not_to be_blank
      expect( content_object.mentions.count ).to eq(3)
    end

    it 'links hashtags via mentions' do
      expect( content_object.mentions ).to be_blank
      subject.perform(content_object)
      content_object.reload!
      expect( content_object.mentions ).not_to be_blank
      expect( content_object.mentions.map { |mention| mention.text } ).to match_array(%w( hashtags hashtagsforlife reallycool ))
    end
  end # with new hashtags

  context 'with new and existing hashtags' do
    let(:author)         { Person.create!(full_name: 'Test McTester') }
    let(:content_object) { Note.create!(body: 'Hello, I just love #hashtags. #hashtagsforlife #reallycool', created_by: author) }
    before { Hashtag.create!(text: 'hashtags') }

    it 'creates two new hashtags' do
      expect{ subject.perform(content_object) }.to change{ Hashtag.all.count }.by(2)
    end

    it 're-uses #hashtags' do
      expect{ subject.perform(content_object) }.not_to change{ Hashtag.find_by(text: 'hashtags').id }
    end

    it 'creates #hashtagsforlife' do
      expect{ subject.perform(content_object) }.to change{ Hashtag.find_by(text: 'hashtagsforlife') }.from(nil)
    end

    it 'creates #reallycool' do
      expect{ subject.perform(content_object) }.to change{ Hashtag.find_by(text: 'reallycool') }.from(nil)
    end
  end # with new and existing hashtags

end
