import '../../../core.dart';

class ScreenshotScreenRecordingProtectionService {
  ScreenshotScreenRecordingProtectionService._internal();

  static final ScreenshotScreenRecordingProtectionService _instance = ScreenshotScreenRecordingProtectionService._internal();

  factory ScreenshotScreenRecordingProtectionService() => _instance;

  int _protectionRefCount = 0;

  bool _isProtected = false;

  bool _didSetFlagSecure = false;

  bool get isProtected => _isProtected;

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
      } else {
        try {
          ///Todo: add fallback image
          // await ScreenProtector.protectDataLeakageWithImage(Assets.images.logoWebp.path);
        } catch (e) {
          debugPrint('protectDataLeakageWithImage (fallback) failed: $e');
        }
      }

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

  Future<void> disableProtection() async {
    if (!(Platform.isAndroid || Platform.isIOS)) return;

    if (_protectionRefCount <= 0) {
      debugPrint('disableProtection called but refCount already 0');
      _protectionRefCount = 0;
      return;
    }

    _protectionRefCount--;
    debugPrint('Protection refCount decreased: $_protectionRefCount');

    if (_protectionRefCount > 0) {
      return;
    }

    try {
      await ScreenProtector.preventScreenshotOff();

      try {
        await ScreenProtector.protectDataLeakageWithColorOff();
      } catch (_) {}
      try {
        await ScreenProtector.protectDataLeakageWithBlurOff();
      } catch (_) {}

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
