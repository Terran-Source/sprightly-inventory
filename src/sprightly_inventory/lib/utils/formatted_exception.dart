library marganam.functional_exception;

import 'dart:developer';
import 'dart:io';

import 'package:interpolation/interpolation.dart';

const _defaultExceptionMessage = "Something went wrong. {message}";

final Map<Type, String> exceptionDisplay = {
  Exception: _defaultExceptionMessage,
  FormatException: "Bad formatting!!! {message}",
  IOException: "The system failed getting Input or taking Output. {message}",
  FileSystemException: "Problem with files. {message}",
  HttpException:
      "Could not {method} information from internet. Unreachable {host}.",
  SocketException:
      "The remote connection failed due to my precious Socket. {message}",
  WebSocketException:
      "The remote connection failed due to my precious Socket. {message}",
  SignalException: 'Some signal went wrong.  {message}',
  StdinException:
      "Someone tried to give some input, that I couldn't understand. {message}",
  StdoutException: "Oops, I'm unable to express my output. {message}",
  ProcessException: 'Process went bad. {message}',
  TlsException: "It's the security protocol named TLS to blame. {message}",
};

class FormattedException<T extends Exception> {
  final T _exception;
  final Map<String, dynamic> messageParams;
  final StackTrace? stackTrace;
  final String? moduleName;

  static String appName = 'FormattedException';
  static bool debug = false;
  // TODO: set Logger
  //static ILogger _logger;

  FormattedException(
    this._exception, {
    this.messageParams = const {},
    this.stackTrace,
    this.moduleName = 'Generic',
  }) {
    if (debug) {
      //// TODO: write structured log
      // _logger
      //   ..withContext({
      //     title: displayedMessage,
      //     error: _exception,
      //     source: logSource,
      //     messageParams: messageParams,
      //     stackTrace: stackTrace,
      //   })
      //   ..log(message);
      log(message, name: logSource, error: _exception, stackTrace: stackTrace);
    }
  }

  final _interpolation = Interpolation();

  T get exception => _exception;
  String get message =>
      messageParams['message']?.toString() ?? _exception.toString();
  Type get exceptionType => _exception.runtimeType;

  Type get _displayExceptionType =>
      exceptionDisplay.containsKey(exceptionType) ? exceptionType : Exception;

  String get _exceptionDisplayMessage =>
      exceptionDisplay[_displayExceptionType] ?? _defaultExceptionMessage;

  String get logSource => '$appName:$moduleName';
  String get displayedMessage =>
      _interpolation.eval(_exceptionDisplayMessage, messageParams).trim();
}
