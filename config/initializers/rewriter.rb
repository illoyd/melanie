$rewriter = Detectors::PipelineRewriter.new(
  Detectors::Rewriter.new,
  Detectors::HashtagDetector.new,
  Detectors::CashtagDetector.new
)