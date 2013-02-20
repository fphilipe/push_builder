module PushBuilder
  class APS
    attr_reader :alert, :badge, :sound

    def badge=(badge)
      @badge = badge.nil? ? nil : Integer(badge)
    rescue ArgumentError
      fail TypeError, 'Invalid number for badge'
    end

    def alert=(alert)
      @alert = alert.nil? ? nil : String(alert)
    end

    def sound=(sound)
      @sound = sound.nil? ? nil : String(sound)
    end

    def to_hash(opts={})
      { badge: badge, alert: alert, sound: sound }.reject do |_,v|
        v.nil?
      end
    end
  end
end
