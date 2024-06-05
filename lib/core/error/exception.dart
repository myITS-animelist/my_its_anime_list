class GeneralException implements Exception {
  final String message;

  const GeneralException(this.message);
}

class ServerException implements Exception {
  final String message;

  const ServerException(this.message);
}

class StatusCodeException implements Exception {
  final int statusCode;

  const StatusCodeException(this.statusCode);
}

class EmptyException implements Exception {
  final String message;

  const EmptyException(this.message);
}

class OfflineException implements Exception {}
class WeekPassException implements Exception {}
class ExistedAccountException implements Exception {}
class NoUserException implements Exception {}
class WrongPasswordException implements Exception {}
class TooManyRequestsException implements Exception {}

