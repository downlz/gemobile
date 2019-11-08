
import 'package:graineasy/exception/data_exception.dart';

class BaseRepository {
  DataException getErrorBasedOnStatusCode(int statusCode) {
    switch (statusCode) {
      case 400:
        return new DataException(
            "Bad Request: Missing or invalid parameter.", statusCode);

      case 401:
        return new DataException(
            "Unauthorized: Authorization missing or incorrect.", statusCode);

      case 403:
        return new DataException(
            "Forbidden: Access has been refused.", statusCode);

      case 404:
        return new DataException(
            "Not Found: The requested resource could not be found.",
            statusCode);

      case 422:
        return new DataException(
            "Unprocessable Entity: The request was well-formed but was unable to be followed due to validation errors.",
            statusCode);

      case 429:
        return new DataException("Too Many Requests.", statusCode);

      case 500:
        return new DataException(
            "Internal Server Error: Server encountered an error, try again later.",
            statusCode);

      case 503:
        return new DataException(
            "Service Unavailable: Server is at capacity, try again later.",
            statusCode);

      default:
        return new DataException(
            "Internal Server Error: Server encountered an error, try again later.",
            statusCode);
    }
  }
}
