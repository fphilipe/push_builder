require 'spec_helper'

describe PushBuilder do
  describe '.build' do
    it 'returns a Payload' do
      payload = PushBuilder.build(alert: 'Hello', sound: 'default', badge: 5)

      payload.should be_a described_class::Payload
      payload.aps.alert.should eq 'Hello'
      payload.aps.sound.should eq 'default'
      payload.aps.badge.should eq 5
    end
  end
end
