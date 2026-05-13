import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class CrashService {
  final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;

  void logError(dynamic e, StackTrace stack) {
    _crashlytics.recordError(e, stack);
  }

  void logMessage(String message) {
    _crashlytics.log(message);
  }
}