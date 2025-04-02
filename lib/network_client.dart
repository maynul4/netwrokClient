import 'dart:convert';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final Map<String, dynamic>? body;
  final String? errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.body,
    this.errorMessage,
  });
}

class NetworkClient {
  static final Logger _logger = Logger(); // Logger instance

  // GET request method
  static Future<NetworkResponse> getRequest({
    required String url,
    Map<String, String>? headers,
  }) async {
    _logger.i('GET Request initiated. URL: $url'); // Log request initiation
    try {
      Uri uri = Uri.parse(url);
      Response response = await get(uri, headers: headers);
      _logger.i(
        'GET Response received. Status Code: ${response.statusCode}',
      ); // Log response status code
      return _handleResponse(response);
    } catch (e) {
      _logger.e('GET Request Error: $e'); // Log any errors that occur
      return _handleError(e);
    }
  }

  // POST request method
  static Future<NetworkResponse> postRequest({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    _logger.i('POST Request initiated. URL: $url'); // Log request initiation
    try {
      Uri uri = Uri.parse(url);
      Response response = await post(
        uri,
        headers: _getDefaultHeaders(headers),
        body: jsonEncode(body),
      );
      _logger.i(
        'POST Response received. Status Code: ${response.statusCode}',
      ); // Log response status code
      return _handleResponse(response);
    } catch (e) {
      _logger.e('POST Request Error: $e'); // Log any errors that occur
      return _handleError(e);
    }
  }

  // PUT request method
  static Future<NetworkResponse> putRequest({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    _logger.i('PUT Request initiated. URL: $url'); // Log request initiation
    try {
      Uri uri = Uri.parse(url);
      Response response = await put(
        uri,
        headers: _getDefaultHeaders(headers),
        body: jsonEncode(body),
      );
      _logger.i(
        'PUT Response received. Status Code: ${response.statusCode}',
      ); // Log response status code
      return _handleResponse(response);
    } catch (e) {
      _logger.e('PUT Request Error: $e'); // Log any errors that occur
      return _handleError(e);
    }
  }

  // PATCH request method
  static Future<NetworkResponse> patchRequest({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    _logger.i('PATCH Request initiated. URL: $url'); // Log request initiation
    try {
      Uri uri = Uri.parse(url);
      Response response = await patch(
        uri,
        headers: _getDefaultHeaders(headers),
        body: jsonEncode(body),
      );
      _logger.i(
        'PATCH Response received. Status Code: ${response.statusCode}',
      ); // Log response status code
      return _handleResponse(response);
    } catch (e) {
      _logger.e('PATCH Request Error: $e'); // Log any errors that occur
      return _handleError(e);
    }
  }

  // DELETE request method
  static Future<NetworkResponse> deleteRequest({
    required String url,
    Map<String, String>? headers,
  }) async {
    _logger.i('DELETE Request initiated. URL: $url'); // Log request initiation
    try {
      Uri uri = Uri.parse(url);
      Response response = await delete(uri, headers: headers);
      _logger.i(
        'DELETE Response received. Status Code: ${response.statusCode}',
      ); // Log response status code
      return _handleResponse(response);
    } catch (e) {
      _logger.e('DELETE Request Error: $e'); // Log any errors that occur
      return _handleError(e);
    }
  }

  // Generic Response Handler
  static NetworkResponse _handleResponse(Response response) {
    try {
      final decodedJson = jsonDecode(response.body);
      if (response.statusCode == 200) {
        _logger.i(
          'Response Body: $decodedJson',
        ); // Log the body of the successful response
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: decodedJson,
        );
      } else {
        _logger.w(
          'Error in Response Body: $decodedJson',
        ); // Log warning if response has error
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decodedJson.toString(),
        );
      }
    } catch (e) {
      _logger.e(
        'Invalid JSON Response: $e',
      ); // Log error if JSON decoding fails
      return NetworkResponse(
        isSuccess: false,
        statusCode: response.statusCode,
        errorMessage: "Invalid JSON response",
      );
    }
  }

  // Generic Error Handler
  static NetworkResponse _handleError(dynamic error) {
    _logger.e('Network Error: $error'); // Log any network error
    return NetworkResponse(
      isSuccess: false,
      statusCode: -1,
      errorMessage: error.toString(),
    );
  }

  // Default Headers for JSON requests
  static Map<String, String> _getDefaultHeaders(Map<String, String>? headers) {
    return {'Content-Type': 'application/json', ...?headers};
  }
}

/// Universal API Call Method
Future<NetworkResponse> callAPIMethod({
  required String method,
  required String url,
  Map<String, String>? headers,
  Map<String, dynamic>? body,
}) async {
  switch (method.toUpperCase()) {
    case 'GET':
      return await NetworkClient.getRequest(url: url, headers: headers);
    case 'POST':
      return await NetworkClient.postRequest(
        url: url,
        headers: headers,
        body: body,
      );
    case 'PUT':
      return await NetworkClient.putRequest(
        url: url,
        headers: headers,
        body: body,
      );
    case 'PATCH':
      return await NetworkClient.patchRequest(
        url: url,
        headers: headers,
        body: body,
      );
    case 'DELETE':
      return await NetworkClient.deleteRequest(url: url, headers: headers);
    default:
      return NetworkResponse(
        isSuccess: false,
        statusCode: 400,
        errorMessage: 'Unsupported HTTP method: $method',
      );
  }
}
