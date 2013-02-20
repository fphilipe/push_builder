require 'multi_json'

module PushBuilder
  class Compiler
    MAX_PAYLOAD_SIZE = 256

    attr_reader :payload, :third_party_data

    def initialize(payload, third_party_data={})
      @payload = payload
      @third_party_data = third_party_data
    end

    def compile
      crop_alert_if_necessary!

      to_json(third_party_data.merge(payload))
    end

    private

    def crop_alert_if_necessary!
      if (alert = payload.fetch(:aps, {})[:alert])
        payload[:aps][:alert] =
          StringCropper
            .new(alert)
            .crop_bytes(size(payload) - MAX_PAYLOAD_SIZE)
      end
    end

    def size(data)
      to_json(data).bytesize
    end

    def to_json(data)
      MultiJson.dump(data)
    end
  end
end
