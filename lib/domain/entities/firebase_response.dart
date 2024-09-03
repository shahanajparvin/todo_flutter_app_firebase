import 'package:cloud_firestore/cloud_firestore.dart';

// Base class for Firebase responses
abstract class Response<T> {
  const Response();
}



class SuccessResponse<T> extends Response<T> {
  const SuccessResponse({required this.data});

  final T data;
}

// Error response for Firebase
class ErrorResponse<T> extends Response<T> {
  const ErrorResponse(
      {required this.errorMessage, this.exception});

  final String errorMessage;
  final Exception? exception;
}