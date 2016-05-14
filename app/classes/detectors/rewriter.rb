module Detectors

  class Rewriter

    def rewrite(text, entities)
      chars = text.to_s.to_char_a

      # sort by start index
      entities = entities.sort_by do |entity|
        indices = entity.respond_to?(:indices) ? entity.indices : entity[:indices]
        indices.first
      end

      result = []
      last_index = entities.inject(0) do |index, entity|
        indices = entity.respond_to?(:indices) ? entity.indices : entity[:indices]
        result << chars[index...indices.first]
        result << entity.prepared_text #yield(entity, chars)
        indices.last
      end
      result << chars[last_index..-1]

      result.flatten.join
    end

  end

end