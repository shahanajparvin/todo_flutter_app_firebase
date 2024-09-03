import 'package:firebase_analytics/firebase_analytics.dart';
import 'analytics_events.dart';

void logSplashOpen() {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.logEvent(name: eventSplashOpen);
}

void logLoginSuccess() {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.logEvent(name: eventLoginSuccess);
}

void logLoginFailed() {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.logEvent(name: eventLoginFailed);
}

void logHome() {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.logEvent(name: eventLoginHomeView);
}
