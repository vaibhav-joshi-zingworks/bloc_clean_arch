// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../network/base_api_service.dart' as _i767;
import '../network/interceptor/api_response_log_interceptor.dart' as _i208;
import '../network/interceptor/auth_interceptor.dart' as _i412;
import '../network/interceptor/network_interceptor.dart' as _i281;
import '../network/interceptor/payload_interceptor.dart' as _i136;
import '../services/analytics/xcore.dart' as _i332;
import '../services/app_device_info/xcore.dart' as _i694;
import '../services/app_lifecycle_service/app_lifecycle_service.dart' as _i527;
import '../services/encryption/xcore.dart' as _i0;
import '../services/local_storage/xcore.dart' as _i938;
import '../services/network_monitor/xcore.dart' as _i195;
import '../services/notification/infrastructure/adapters/awesome_notifications_adapter.dart'
    as _i19;
import '../services/notification/xcore.dart' as _i807;
import '../services/permission_handler/xcore.dart' as _i548;
import '../services/security/xcore.dart' as _i318;
import '../services/url_launcher/xcore.dart' as _i881;
import 'injection.dart' as _i464;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectionModule = _$InjectionModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => injectionModule.sharedPreferences,
      preResolve: true,
    );
    await gh.factoryAsync<_i694.AppDeviceInfoService>(
      () => injectionModule.appDeviceInfoService(),
      preResolve: true,
    );
    gh.lazySingleton<_i558.FlutterSecureStorage>(
        () => injectionModule.secureStorage);
    gh.lazySingleton<_i895.Connectivity>(() => injectionModule.connectivity);
    gh.lazySingleton<_i332.AnalyticsFactory>(
        () => injectionModule.analyticsFactory());
    gh.lazySingleton<_i938.StorageStrategyFactory>(
        () => injectionModule.storageStrategyFactory());
    gh.lazySingleton<_i0.EncryptionManager>(
        () => injectionModule.encryptionManager());
    gh.lazySingleton<_i195.InternetCheckStrategy>(
        () => injectionModule.internetCheckStrategy());
    gh.lazySingleton<_i208.ApiResponseLogInterceptor>(
        () => injectionModule.apiResponseLogInterceptor());
    gh.lazySingleton<_i807.NotificationRepository>(
        () => injectionModule.notificationRepository());
    gh.lazySingleton<_i807.NotificationChannelRegistry>(
        () => injectionModule.notificationChannelRegistry());
    gh.lazySingleton<_i19.AwesomeNotificationsAdapter>(
        () => injectionModule.awesomeNotificationsAdapter());
    gh.lazySingleton<_i548.PermissionDialogHandler>(
        () => injectionModule.permissionDialogHandler());
    gh.lazySingleton<_i548.PermissionInvoker>(
        () => injectionModule.permissionInvoker());
    gh.lazySingleton<_i881.FlutterUrlLauncherAdapter>(
        () => injectionModule.flutterUrlLauncherAdapter());
    gh.lazySingleton<_i881.UrlLaunchStrategyFactory>(
        () => injectionModule.urlLaunchStrategyFactory());
    gh.lazySingleton<_i318.SafeDeviceAdapter>(
        () => injectionModule.safeDeviceAdapter());
    gh.lazySingleton<_i318.ScreenshotScreenRecordingProtectionService>(
        () => injectionModule.screenshotScreenRecordingProtectionService());
    gh.lazySingleton<_i527.AppLifecycleService>(
        () => injectionModule.appLifecycleService());
    gh.lazySingleton<_i881.UrlLauncherService>(() => injectionModule
        .urlLauncherService(gh<_i881.UrlLaunchStrategyFactory>()));
    gh.lazySingleton<_i195.ConnectivityPlusAdapter>(() =>
        injectionModule.connectivityPlusAdapter(gh<_i895.Connectivity>()));
    gh.lazySingleton<_i938.StorageStrategy>(() =>
        injectionModule.storageStrategy(gh<_i558.FlutterSecureStorage>()));
    gh.lazySingleton<_i938.SecureStorageStrategy>(() => injectionModule
        .secureStorageStrategy(gh<_i558.FlutterSecureStorage>()));
    gh.lazySingleton<_i938.StorageFacade>(
        () => injectionModule.storageFacade(gh<_i938.StorageStrategy>()));
    gh.lazySingleton<_i938.StorageFacade>(
      () => injectionModule
          .secureStorageFacade(gh<_i938.SecureStorageStrategy>()),
      instanceName: 'secureStorage',
    );
    gh.lazySingleton<_i938.SharedPreferencesStorageStrategy>(() =>
        injectionModule
            .sharedPreferencesStorageStrategy(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i694.DeviceInfoRepository>(() =>
        injectionModule.deviceInfoRepository(gh<_i694.AppDeviceInfoService>()));
    gh.lazySingleton<_i136.PayloadInterceptor>(
        () => injectionModule.payloadInterceptor(gh<_i0.EncryptionManager>()));
    gh.lazySingleton<_i318.DeviceSecurityRepository>(() => injectionModule
        .deviceSecurityRepository(gh<_i318.SafeDeviceAdapter>()));
    gh.lazySingleton<_i807.NotificationRateLimitStrategy>(() => injectionModule
        .notificationRateLimitStrategy(gh<_i807.NotificationRepository>()));
    gh.lazySingleton<_i332.AnalyticsFacade>(
        () => injectionModule.analyticsFacade(gh<_i332.AnalyticsFactory>()));
    gh.lazySingleton<_i412.AuthInterceptor>(
        () => injectionModule.authInterceptor(gh<_i938.StorageFacade>()));
    gh.lazySingleton<_i548.PermissionStrategyFactory>(() => injectionModule
        .permissionStrategyFactory(gh<_i548.PermissionDialogHandler>()));
    gh.lazySingleton<_i195.NetworkMonitorRepository>(
        () => injectionModule.networkMonitorRepository(
              gh<_i195.ConnectivityPlusAdapter>(),
              gh<_i195.InternetCheckStrategy>(),
            ));
    gh.lazySingleton<_i938.StorageFacade>(
      () => injectionModule.sharedPreferencesStorageFacade(
          gh<_i938.SharedPreferencesStorageStrategy>()),
      instanceName: 'sharedPreferences',
    );
    gh.lazySingleton<_i548.PermissionRepository>(
        () => injectionModule.permissionRepository(
              gh<_i548.PermissionStrategyFactory>(),
              gh<_i548.PermissionInvoker>(),
            ));
    gh.lazySingleton<_i807.NotificationStrategy>(
        () => injectionModule.notificationStrategy(
              gh<_i807.NotificationRateLimitStrategy>(),
              gh<_i19.AwesomeNotificationsAdapter>(),
              gh<_i807.NotificationChannelRegistry>(),
            ));
    gh.lazySingleton<_i195.NetworkMonitorService>(() => injectionModule
        .networkMonitorService(gh<_i195.NetworkMonitorRepository>()));
    gh.lazySingleton<_i281.NetworkInterceptor>(() =>
        injectionModule.networkInterceptor(gh<_i195.NetworkMonitorService>()));
    gh.lazySingleton<_i361.Dio>(() => injectionModule.dio(
          gh<_i281.NetworkInterceptor>(),
          gh<_i412.AuthInterceptor>(),
          gh<_i136.PayloadInterceptor>(),
          gh<_i208.ApiResponseLogInterceptor>(),
        ));
    gh.lazySingleton<_i767.BaseApiService>(
        () => injectionModule.baseApiService(gh<_i361.Dio>()));
    return this;
  }
}

class _$InjectionModule extends _i464.InjectionModule {}
