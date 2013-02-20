require 'push_builder/version'
require 'push_builder/payload'
require 'push_builder/aps'
require 'push_builder/compiler'
require 'push_builder/string_cropper'

module PushBuilder
  TypeError = Class.new(StandardError)

  def self.build(args={})
    Payload.new.tap do |payload|
      args.each { |k, v| payload.aps.send("#{k}=", v) }
    end
  end
end
