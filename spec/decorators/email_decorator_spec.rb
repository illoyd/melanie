require 'spec_helper'

RSpec.describe EmailDecorator do

  context 'with html email' do
    let(:message) { Mail.read("./spec/examples/html_email.eml") }
    subject { described_class.new(message) }

    its(:sender_name)  { should eq('Ian Lloyd') }
    its(:sender_email) { should eq('ian.w.lloyd@gmail.com') }

    it 'extracts 1 TO address' do
      expect( subject.to_recipients.size ).to eq(1)
    end

    it 'extracts no CC addresses' do
      expect( subject.cc_recipients.size ).to eq(0)
    end

    it 'extracts no BCC addresses' do
      expect( subject.bcc_recipients.size ).to eq(0)
    end

  end

end
