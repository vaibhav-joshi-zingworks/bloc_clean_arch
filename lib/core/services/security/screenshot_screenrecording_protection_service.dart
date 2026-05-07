import '../../../core.dart';

/// Service responsible for preventing screenshots and screen recordings.
/// 
/// It uses a reference-counting mechanism to ensure that protection is only 
/// disabled when all parts of the app that requested it have released it.
/// Critical for protecting sensitive data like PINs, KYC info, or bank details.
class ScreenshotScreenRecordingProtectionService {
  ScreenshotScreenRecordingProtectionService._internal();

  static final ScreenshotScreenRecordingProtectionService _instance = ScreenshotScreenRecordingProtectionService._internal();

  factory ScreenshotScreenRecordingProtectionService() => _instance;

  /// Tracks how many active components are requesting protection.
  int _protectionRefCount = 0;

  /// Internal state to track if protection is currently active.
  bool _isProtected = false;

  /// Tracks if the Android 'FLAG_SECURE' was successfully set via MethodChannel.
  bool _didSetFlagSecure = false;

  /// Public getter to check protection status.
  bool get isProtected => _isProtected;

  /// Enables protection with various optional UI masking effects.
  /// 
  /// On Android, it attempts to set [FLAG_SECURE] to block system-level screenshots.
  /// On iOS, it uses [ScreenProtector] to mask the app switcher or recording.
  Future<void> enableProtection({
    bool protectDataLeakageWithBlur = false,
    String? placeholderImageAssetName,
    bool protectWithColor = false,
    Color? colorValue,
  }) async {
    if (!(Platform.isAndroid || Platform.isIOS)) return;

    _protectionRefCount++;
    if (_protectionRefCount > 1) {
      debugPrint('Protection refCount increased: $_protectionRefCount (already protected)');
      return;
    }

    try {
      await ScreenProtector.preventScreenshotOn();

      // Configure masking behavior when the app is in background or being recorded
      if (protectDataLeakageWithBlur) {
        try {
          await ScreenProtector.protectDataLeakageWithBlur();
        } catch (e) {
          debugPrint('protectDataLeakageWithBlur failed: $e');
        }
      } else if (protectWithColor && colorValue != null) {
        try {
          await ScreenProtector.protectDataLeakageWithColor(colorValue);
        } catch (e) {
          debugPrint('protectDataLeakageWithColor failed: $e');
        }
      } else if (placeholderImageAssetName != null) {
        try {
          await ScreenProtector.protectDataLeakageWithImage(placeholderImageAssetName);
        } catch (e) {
          debugPrint('protectDataLeakageWithImage failed: $e');
        }
      }

      // Android-specific: Enable secure flag via platform channel
      if (Platform.isAndroid) {
        try {
          final ok = await _PlatformSecure.enableFlagSecure();
          _didSetFlagSecure = ok;
          if (!ok) {
            debugPrint('Native enableFlagSecure returned false');
          }
        } catch (e) {
          debugPrint('Native enableFlagSecure threw: $e');
        }
      }

      _isProtected = true;
      debugPrint('Screenshot protection enabled. refCount=$_protectionRefCount flagSecure=$_didSetFlagSecure');
    } catch (e) {
      debugPrint('enableProtection error: $e');
    }
  }

  /// Decreases the reference count and disables protection if no more components need it.
  Future<void> disableProtection() async {
    if (!(Platform.isAndroid || Platform.isIOS)) return;

    if (_protectionRefCount <= 0) {
      debugPrint('disableProtection called but refCount already 0');
      _protectionRefCount = 0;
      return;
    }

    _protectionRefCount--;
    debugPrint('Protection refCount decreased: $_protectionRefCount');

    // Only disable if this was the last reference
    if (_protectionRefCount > 0) {
      return;
    }

    try {
      await ScreenProtector.preventScreenshotOff();

      // Clear all UI masking effects
      try {
        await ScreenProtector.protectDataLeakageWithColorOff();
      } catch (_) {}
      try {
        await ScreenProtector.protectDataLeakageWithBlurOff();
      } catch (_) {}

      // Android-specific: Disable secure flag
      if (Platform.isAndroid && _didSetFlagSecure) {
        try {
          final ok = await _PlatformSecure.disableFlagSecure();
          if (!ok) debugPrint('Native disableFlagSecure returned false');
        } catch (e) {
          debugPrint('Native disableFlagSecure threw: $e');
        }
        _didSetFlagSecure = false;
      }

      _isProtected = false;
      debugPrint('Screenshot protection disabled.');
    } catch (e) {
      debugPrint('disableProtection error: $e');
    }
  }

  /// Checks if the screen is currently being recorded (iOS only).
  Future<bool> isRecording() async {
    try {
      if (!Platform.isIOS) return false;
      return await ScreenProtector.isRecording();
    } catch (e) {
      debugPrint('isRecording check failed: $e');
      return false;
    }
  }
}

/// Private helper to communicate with native platform for Android Secure Flags.
class _PlatformSecure {
  static const MethodChannel _channel = MethodChannel('com.swipeloan.screen_protect');

  static Future<bool> enableFlagSecure() async {
    if (!Platform.isAndroid) return false;
    try {
      final res = await _channel.invokeMethod<bool>('enableFlagSecure');
      return res == true;
    } catch (e) {
      debugPrint('enableFlagSecure failed: $e');
      return false;
    }
  }

  static Future<bool> disableFlagSecure() async {
    if (!Platform.isAndroid) return false;
    try {
      final res = await _channel.invokeMethod<bool>('disableFlagSecure');
      return res == true;
    } catch (e) {
      debugPrint('disableFlagSecure failed: $e');
      return false;
    }
  }
}
