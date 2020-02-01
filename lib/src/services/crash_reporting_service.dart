import 'package:sentry/sentry.dart';

SentryClient sentryClient;

class CrashReportingService {
  Future<void> reportCrash(Exception exception, StackTrace stackTrace) async {
    if (sentryClient == null) {
      return;
    }

    await sentryClient.captureException(
      exception: exception,
      stackTrace: stackTrace,
    );
  }
}
