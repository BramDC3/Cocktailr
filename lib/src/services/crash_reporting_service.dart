import 'package:flutter/material.dart';
import 'package:sentry/sentry.dart';

SentryClient sentryClient;

class CrashReportingService {
  Future<void> reportCrash(Exception exception, StackTrace stackTrace) async {
    try {
      if (sentryClient == null) {
        return;
      }

      await sentryClient.captureException(
        exception: exception,
        stackTrace: stackTrace,
      );
    } catch (e) {
      debugPrint("An error occurred while sending a crash log to Sentry: $e");
    }
  }
}
