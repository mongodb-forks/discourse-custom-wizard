# frozen_string_literal: true

require_relative '../../../plugin_helper'

describe CustomWizard::ProSubscriptionSerializer do
  it 'should return pro subscription attributes' do
    sub = CustomWizard::ProSubscription.new(OpenStruct.new(type: 'community', updated_at: Time.now))
    serialized = described_class.new(sub, root: false).as_json

    expect(serialized[:active]).to eq(true)
    expect(serialized[:type]).to eq('community')
    expect(serialized[:updated_at]).to eq(sub.updated_at)
  end
end
