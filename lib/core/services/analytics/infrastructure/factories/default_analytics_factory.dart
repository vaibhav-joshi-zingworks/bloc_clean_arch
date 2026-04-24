import '../../../../../core.dart';

class DefaultAnalyticsFactory implements AnalyticsFactory {
  @override
  AnalyticsStrategy create(AnalyticsType provider) {
    switch (provider) {
      case AnalyticsType.firebase:
        return FirebaseAnalyticsStrategy(FirebaseAnalytics.instance);
    }
  }
}
