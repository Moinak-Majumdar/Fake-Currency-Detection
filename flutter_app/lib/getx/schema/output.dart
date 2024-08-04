class PredictionOutput {
  const PredictionOutput({
    required this.prediction,
    required this.side,
    required this.confidence,
  });

  final String side, prediction;
  final double confidence;
}
