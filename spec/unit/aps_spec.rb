require 'spec_helper'

describe PushBuilder::APS do
  subject(:aps) { described_class.new }

  describe '#badge=' do
    it 'raises for non numeric values' do
      expect { aps.badge = 'test' }.to raise_error(PushBuilder::TypeError)
    end

    it 'accepts numeric strings' do
      aps.badge = '123'
      aps.badge.should be 123
    end

    it 'accepts numbers' do
      aps.badge = 123
      aps.badge.should be 123
    end

    it 'accepts nil' do
      aps.badge = nil
      aps.badge.should be_nil
    end
  end

  describe '#alert=' do
    it 'accepts strings' do
      aps.alert = 'foobar'
      aps.alert.should eq 'foobar'
    end

    it 'accepts values convertable to strings' do
      aps.alert = 123
      aps.alert.should eq '123'
    end

    it 'accepts nil' do
      aps.alert = nil
      aps.alert.should be_nil
    end
  end

  describe '#sound=' do
    it 'accepts strings' do
      aps.sound = 'foobar'
      aps.sound.should eq 'foobar'
    end

    it 'accepts values convertable to strings' do
      aps.sound = 123
      aps.sound.should eq '123'
    end

    it 'accepts nil' do
      aps.sound = nil
      aps.sound.should be_nil
    end
  end

  describe '#to_hash' do
    before do
      aps.badge = 1
      aps.alert = 'foo'
      aps.sound = 'bar'
    end

    let(:expected_hash) do
      { badge: 1, alert: 'foo', sound: 'bar' }
    end

    it 'returns a hash' do
      aps.to_hash.should eq expected_hash
    end

    [:badge, :alert, :sound].each do |key|
      context "when #{key} is nil" do
        it 'does not include it' do
          aps.send("#{key}=", nil)
          expected_hash.delete(key)

          aps.to_hash.should eq expected_hash
        end
      end
    end
  end
end
