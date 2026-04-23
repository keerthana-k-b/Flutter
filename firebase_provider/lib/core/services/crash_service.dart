import 'package:firebase_crashlytics/firebase_crashlytics.dart';


class CrashService {
  void forceCrash() {
    throw Exception("Test Crash");
  }

  void logError(e, stack) {
    FirebaseCrashlytics.instance.recordError(e, stack);
  }

  void log(String message) {
    FirebaseCrashlytics.instance.log(message);
  }

  void setKey(String key, String value){
    FirebaseCrashlytics.instance.setCustomKey(key, value);
  }

}