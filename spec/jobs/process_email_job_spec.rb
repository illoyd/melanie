require 'rails_helper'

RSpec.describe ProcessEmailJob, :with_database do
  let(:message) { Mail.read("./spec/examples/html_email.eml") }

  it 'does not raise errors' do
    expect{ subject.perform(message) }.not_to raise_error
  end

  it 'creates the FROM sender' do
    expect{ subject.perform(message) }.to change{ Person.find_by(email: 'ian.w.lloyd@gmail.com') }.from(nil)
  end

  it 'creates the TO recipient' do
    expect{ subject.perform(message) }.to change{ Person.find_by(email: 'ian.w.lloyd+mel@gmail.com') }.from(nil)
  end

end
