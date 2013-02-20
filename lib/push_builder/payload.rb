module PushBuilder
  class Payload
    attr_reader :aps, :custom_data, :third_party_data

    def initialize(args={})
      @aps = APS.new
      @custom_data = {}
      @third_party_data = {}
    end

    def aps=(aps)
      if aps.is_a?(APS)
        @aps = aps
      else
        fail TypeError, 'Trying to set aps to a non APS object.'
      end
    end

    def custom_data=(data)
      if data.is_a?(Hash)
        @custom_data = data
      else
        fail TypeError, 'Trying to set custom_data to something other than Hash.'
      end
    end

    def third_party_data=(data)
      if data.is_a?(Hash)
        @third_party_data = data
      else
        fail TypeError, 'Trying to set third_party_data to something other than Hash.'
      end
    end

    def to_json
      payload = custom_data.merge(aps: aps.to_hash)
      Compiler.new(payload, third_party_data).compile
    end
  end
end
