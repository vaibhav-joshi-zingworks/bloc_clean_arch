import '../../../../../core.dart';

/// Factory class for creating [AnalyticsStrategy] instances.
class DefaultAnalyticsFactory implements AnalyticsFactory {
  @override
  AnalyticsStrategy create(AnalyticsType provider) {
    // Return the appropriate strategy based on the requested provider type
    switch (provider) {
      case AnalyticsType.firebase:
        return FirebaseAnalyticsStrategy(FirebaseAnalytics.instance);
    }
  }
}
