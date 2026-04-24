import '../../xcore.dart';

abstract class AnalyticsFactory {
  AnalyticsStrategy create(AnalyticsType provider);
}
