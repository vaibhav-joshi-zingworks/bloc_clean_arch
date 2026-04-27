import '../../../core.dart';
import 'app_breakpoints.dart';
import 'device_type.dart';

extension ResponsiveContext on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  double get width => MediaQuery.sizeOf(this).width;

  bool get isMobile => width < AppBreakpoints.mobile;

  bool get isTablet => width >= AppBreakpoints.mobile && width < AppBreakpoints.tablet;

  bool get isDesktop => width >= AppBreakpoints.tablet;

  DeviceType get deviceType {
    if (isMobile) return DeviceType.mobile;
    if (isTablet) return DeviceType.tablet;
    return DeviceType.desktop;
  }

  double get fontScaleFactor {
    if (isMobile) return 1.0;
    if (isTablet) return 1.15;
    return 1.3;
  }

  MediaQueryData get getTextMediaQueryData {
    final systemScale = mediaQuery.textScaler.scale(1.0);
    final finalScale = (systemScale * fontScaleFactor).clamp(1.0, 1.4);
    return mediaQuery.copyWith(textScaler: TextScaler.linear(finalScale));
  }
}
