module Detectors

  class Binder

    delegate :detect, to: :detector

    def bind(obj)

      mentions = []

      # For every detector...
      detectors.each do |detector|
        # For every detected entity...
        detector.detect(obj.body).each do |entity|

          # Bind!
          mentions << case entity
          when Detectors::HashtagEntity
            hashtag(obj, entity)
          when Detectors::CashtagEntity
            cashtag(obj, entity)
          end

        end
      end

      mentions

    end

    def detectors
      @detectors ||= [
        Detectors::HashtagDetector.new,
        Detectors::CashtagDetector.new
      ]
    end

    def hashtag(obj, entity)
      hashtag = Hashtag.find_or_create_by!(text: entity.text)
      mentions(obj, hashtag, entity)
    end

    def cashtag(obj, entity)
      cashtag = Cashtag.find_or_create_by!(text: entity.text)
      mentions(obj, cashtag, entity)
    end

    def mentions(obj, target, entity)
      Mentions.find_or_create_by!(out: obj.id, in: target.id, position_start: entity.position_start, position_end: entity.position_end)
    end

  end

end
