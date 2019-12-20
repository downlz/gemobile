
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

  DataException getErrorBasedOnAppDataSetup(String dbcode) {
    switch (dbcode) {
      case 'activation':
        return new DataException(
            "User account not activated yet.Contact trade@graineasy.com", 10);

      case 'vendorcode':
        return new DataException(
            "Vendor code not setup.Contact trade@graineasy.com", 11);

      case 'transporter':
        return new DataException(
            "We will be soon rolling out for transporter.Please use graineasy.com for the time being", 12);

        case 'updatereq':
        return new DataException(
            "We have improved the application.Please update the app from playstore", 14);

      default:
        return new DataException(
            "Internal Application error:Contact administrator@graineasy.com",20);
    }
  }
}
