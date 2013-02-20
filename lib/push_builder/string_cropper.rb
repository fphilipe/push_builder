# coding: UTF-8

module PushBuilder
  class StringCropper
    DEFAULT_CROP_INDICATOR = ?…

    attr_reader :string, :indicator

    def initialize(string, indicator=DEFAULT_CROP_INDICATOR)
      @string = string
      @indicator = indicator
    end

    def crop_bytes(bytes_to_crop)
      return string  if bytes_to_crop <= 0

      bytes_to_crop += indicator.bytesize
      remaining_bytes = string.bytesize - bytes_to_crop

      string_with_bytes(remaining_bytes) + indicator
    end

    private

    def string_with_bytes(bytes)
      char_count = char_count_fitting_in_bytes(bytes)

      string[0, char_count]
    end

    def char_count_fitting_in_bytes(bytes)
      string.each_char.with_index.inject(0) do |byte_sum, (char, char_count)|
        byte_sum += char.bytesize
        break char_count if byte_sum > bytes

        byte_sum
      end
    end
  end
end
