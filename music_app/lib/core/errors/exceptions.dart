class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({
    required this.message,
    this.statusCode,
  });
}

class GeneralException implements Exception {
  final String message;
  final int? statusCode;

  GeneralException({
    this.message = "Ocorreu um erro. Por favor, tente novamente.",
    this.statusCode,
  });
}

class AudioPlayerException implements Exception {
  final String message;

  AudioPlayerException({required this.message});
}
