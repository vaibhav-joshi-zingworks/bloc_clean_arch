import '../../xcore.dart';

/// Abstract factory for creating [AnalyticsStrategy] instances.
abstract class AnalyticsFactory {
  /// Creates a strategy for the given [provider] type.
  AnalyticsStrategy create(AnalyticsType provider);
}
