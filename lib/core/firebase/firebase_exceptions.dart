import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'firebase_exceptions.freezed.dart';

@freezed
abstract class FirebaseExceptions with _$FirebaseExceptions {


  const factory FirebaseExceptions.formatException() = FormatException;

  const factory FirebaseExceptions.noInternetConnection() =
      NoInternetConnection;

  const factory FirebaseExceptions.unexpectedError() = UnexpectedError;

  static FirebaseExceptions getFirebaseException(error) {
    if (error is Exception) {
      try {
        FirebaseExceptions firebaseExceptions;
        if (error is SocketException) {
          firebaseExceptions = const FirebaseExceptions.noInternetConnection();
        } else {
          firebaseExceptions = const FirebaseExceptions.unexpectedError();
        }
        return firebaseExceptions;
      } on FormatException {
        return const FirebaseExceptions.formatException();
      } catch (_) {
        return const FirebaseExceptions.unexpectedError();
      }
    } else {
      return const FirebaseExceptions.unexpectedError();
    }
  }

  static String getErrorMessage(FirebaseExceptions firebaseExceptions) {
    var errorMessage = "";
    firebaseExceptions.when(
      formatException: () => errorMessage = "Unexpected error occurred",
      noInternetConnection: () => errorMessage = "No internet connection",
      unexpectedError: () => errorMessage = "Unexpected error occurred",
    );
    return errorMessage;
  }
}
