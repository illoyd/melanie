require 'rails_helper'

RSpec.xdescribe GetMailJob do

  it 'does not raise errors when connecting' do
    expect{ described_class.new.perform }.not_to raise_error
  end

end
