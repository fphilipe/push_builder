# coding: UTF-8

require 'spec_helper'

describe PushBuilder::Compiler do
  describe '#compile' do
    it 'crops the alert if necessary' do
      alert = 50.times.map { 'foobar' }.join
      payload = { aps: { alert: alert } }

      json = described_class.new(payload).compile
      json.bytesize.should be 256
      json.should =~ %r{"alert":"[fobar]+…"}
    end

    it 'does not crop the alert if not necessary' do
      payload = { aps: { alert: 'foobar' } }

      json = described_class.new(payload).compile
      json.bytesize.should be < 256
      json.should include '"alert":"foobar"'
    end

    context 'when third party data is large' do
      it 'does not crop the alert if not necessary' do
        payload = { aps: { alert: 'foobar' } }
        third_party_data = { test: 50.times.map { 'foobar' }.join }

        json = described_class.new(payload, third_party_data).compile
        json.bytesize.should be > 256
        json.should include '"alert":"foobar"'
      end
    end

    context 'when no alert present' do
      it 'does not include an alert key' do
        payload = { aps: { badge: 4 } }

        json = described_class.new(payload).compile
        json.should_not include '"alert":'
      end
    end
  end
end
