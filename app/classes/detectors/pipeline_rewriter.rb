module Detectors

  class PipelineRewriter

    attr_reader :detectors, :rewriter

    def initialize(*args)
      @rewriter  = args.first
      @detectors = args.drop(1)
    end

    def rewrite(text)
      entities = detectors.map { |detector| detector.detect(text) }.flatten.sort
      rewriter.rewrite(text, entities)
    end

  end

end