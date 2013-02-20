# coding: UTF-8

require 'spec_helper'

describe PushBuilder::Payload do
  subject(:payload) { described_class.new }

  describe '#aps' do
    it 'is an APS' do
      payload.aps.should be_a(PushBuilder::APS)
    end
  end

  describe '#aps=' do
    it 'accepts an APS object' do
      aps = PushBuilder::APS.new
      payload.aps = aps
      payload.aps.should be aps
    end

    it 'raises when object is not an APS' do
      expect { payload.aps = 'foobar' }.
        to raise_error(PushBuilder::TypeError)
    end
  end

  %w[ custom_data third_party_data ].each do |method|
    describe "##{method}" do
      it 'is an emtpy hash by default' do
        payload.send(method).should == {}
      end
    end

    describe "##{method}=" do
      it 'accepts a Hash' do
        payload.send("#{method}=", { foo: 'bar' })
        payload.send(method)[:foo].should eq 'bar'
      end

      it 'raises when object is not a Hash' do
        expect { payload.send("#{method}=", 123) }.
          to raise_error(PushBuilder::TypeError)
      end
    end
  end

  describe '#to_json' do
    it 'returns a JSON string' do
      payload.aps.stub(to_hash: { foo: 'bar' })
      payload.custom_data[:abc] = 123
      payload.third_party_data[:xyz] = true

      json = payload.to_json
      json.should include '"abc":123'
      json.should include '"aps":{"foo":"bar"}'
      json.should include '"xyz":true'
    end
  end
end
