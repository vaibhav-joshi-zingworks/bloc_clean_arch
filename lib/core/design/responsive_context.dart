import '../../../core.dart';
import 'app_breakpoints.dart';
import 'device_type.dart';

/// Extension on [BuildContext] to provide easy access to responsiveness utilities.
extension ResponsiveContext on BuildContext {
  
  /// Access to the current [MediaQueryData].
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Current screen width in logical pixels.
  double get width => MediaQuery.sizeOf(this).width;

  /// Returns true if the device is categorized as mobile.
  bool get isMobile => width < AppBreakpoints.mobile;

  /// Returns true if the device is categorized as a tablet.
  bool get isTablet => width >= AppBreakpoints.mobile && width < AppBreakpoints.tablet;

  /// Returns true if the device is categorized as desktop.
  bool get isDesktop => width >= AppBreakpoints.tablet;

  /// Returns the current [DeviceType] based on screen width.
  DeviceType get deviceType {
    if (isMobile) return DeviceType.mobile;
    if (isTablet) return DeviceType.tablet;
    return DeviceType.desktop;
  }

  /// Base font scaling multiplier depending on the device category.
  double get fontScaleFactor {
    if (isMobile) return 1.0;
    if (isTablet) return 1.15;
    return 1.3;
  }

  /// Calculates a [MediaQueryData] with adjusted text scaling.
  /// 
  /// Combines the system's text scale with the app's responsive font factor,
  /// ensuring accessibility while maintaining layout integrity.
  MediaQueryData get getTextMediaQueryData {
    final systemScale = mediaQuery.textScaler.scale(1.0);
    final finalScale = (systemScale * fontScaleFactor).clamp(1.0, 1.4);
    return mediaQuery.copyWith(textScaler: TextScaler.linear(finalScale));
  }
}
