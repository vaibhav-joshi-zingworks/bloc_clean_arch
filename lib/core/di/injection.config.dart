// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:go_router/go_router.dart' as _i583;
import 'package:injectable/injectable.dart' as _i526;

import '../../app/bootstrap/app_initializer_bloc.dart' as _i852;
import '../../app/providers/global_message.dart' as _i756;
import '../../app/providers/locale_bloc.dart' as _i939;
import '../../core.dart' as _i943;
import '../../features/auth/data/datasources/auth_local_data_source.dart'
    as _i852;
import '../../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i107;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/get_auth_status_use_case.dart'
    as _i796;
import '../../features/auth/domain/usecases/login_use_case.dart' as _i37;
import '../../features/auth/domain/usecases/logout_use_case.dart' as _i711;
import '../../features/auth/presentation/bloc/auth_bloc.dart' as _i797;
import '../../features/settings/xcore.dart' as _i691;
import '../../features/splash/data/datasource/splash_local_data_source.dart'
    as _i552;
import '../../features/splash/domain/repositories/splash_repository.dart'
    as _i210;
import '../../features/splash/domain/usecases/get_app_status_usecase.dart'
    as _i1043;
import '../../features/splash/presentation/bloc/splash_bloc.dart' as _i442;
import '../services/app_device_info/infrastructure/services/brightness_provider.dart'
    as _i352;
import '../services/encryption/xcore.dart' as _i0;
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
    await gh.factoryAsync<_i943.AppDeviceInfoService>(
      () => injectionModule.appDeviceInfoService(),
      preResolve: true,
    );
    gh.singleton<_i756.GlobalMessageBloc>(
        () => injectionModule.globalMessageBloc());
    gh.singleton<_i939.LocaleBloc>(() => injectionModule.localeBloc());
    gh.lazySingleton<_i943.FlutterSecureStorage>(
        () => injectionModule.secureStorage);
    gh.lazySingleton<_i943.Connectivity>(() => injectionModule.connectivity);
    gh.lazySingleton<_i943.AnalyticsFactory>(
        () => injectionModule.analyticsFactory());
    gh.lazySingleton<_i943.StorageStrategyFactory>(
        () => injectionModule.storageStrategyFactory());
    gh.lazySingleton<_i0.EncryptionManager>(
        () => injectionModule.encryptionManager());
    gh.lazySingleton<_i943.InternetCheckStrategy>(
        () => injectionModule.internetCheckStrategy());
    gh.lazySingleton<_i943.ApiResponseLogInterceptor>(
        () => injectionModule.apiResponseLogInterceptor());
    gh.lazySingleton<_i943.NotificationChannelRegistry>(
        () => injectionModule.notificationChannelRegistry());
    gh.lazySingleton<_i943.AwesomeNotificationsAdapter>(
        () => injectionModule.awesomeNotificationsAdapter());
    gh.lazySingleton<_i943.PermissionDialogHandler>(
        () => injectionModule.permissionDialogHandler());
    gh.lazySingleton<_i943.PermissionInvoker>(
        () => injectionModule.permissionInvoker());
    gh.lazySingleton<_i943.FlutterUrlLauncherAdapter>(
        () => injectionModule.flutterUrlLauncherAdapter());
    gh.lazySingleton<_i943.UrlLaunchStrategyFactory>(
        () => injectionModule.urlLaunchStrategyFactory());
    gh.lazySingleton<_i943.SafeDeviceAdapter>(
        () => injectionModule.safeDeviceAdapter());
    gh.lazySingleton<_i943.ScreenshotScreenRecordingProtectionService>(
        () => injectionModule.screenshotScreenRecordingProtectionService());
    gh.lazySingleton<_i943.AppLifecycleService>(
        () => injectionModule.appLifecycleService());
    gh.lazySingleton<_i583.GoRouter>(() => injectionModule.router());
    gh.lazySingleton<_i352.BrightnessProvider>(
        () => injectionModule.brightnessProvider());
    gh.lazySingleton<_i943.UrlLauncherService>(() => injectionModule
        .urlLauncherService(gh<_i943.UrlLaunchStrategyFactory>()));
    gh.lazySingleton<_i943.ConnectivityPlusAdapter>(() =>
        injectionModule.connectivityPlusAdapter(gh<_i943.Connectivity>()));
    gh.lazySingleton<_i943.StorageStrategy>(() =>
        injectionModule.storageStrategy(gh<_i943.FlutterSecureStorage>()));
    gh.lazySingleton<_i943.SecureStorageStrategy>(() => injectionModule
        .secureStorageStrategy(gh<_i943.FlutterSecureStorage>()));
    gh.lazySingleton<_i943.StorageFacade>(
        () => injectionModule.storageFacade(gh<_i943.StorageStrategy>()));
    gh.lazySingleton<_i691.ThemeLocalDataSource>(
        () => injectionModule.themeLocalDataSource(gh<_i943.StorageFacade>()));
    gh.lazySingleton<_i552.SplashLocalDataSource>(
        () => injectionModule.splashLocalDataSource(gh<_i943.StorageFacade>()));
    gh.lazySingleton<_i852.AuthLocalDataSource>(
        () => injectionModule.authLocalDataSource(gh<_i943.StorageFacade>()));
    gh.lazySingleton<_i943.StorageFacade>(
      () => injectionModule
          .secureStorageFacade(gh<_i943.SecureStorageStrategy>()),
      instanceName: 'secureStorage',
    );
    gh.lazySingleton<_i210.SplashRepository>(() =>
        injectionModule.splashRepository(gh<_i552.SplashLocalDataSource>()));
    gh.lazySingleton<_i943.DeviceInfoRepository>(() =>
        injectionModule.deviceInfoRepository(gh<_i943.AppDeviceInfoService>()));
    gh.lazySingleton<_i943.PayloadInterceptor>(
        () => injectionModule.payloadInterceptor(gh<_i0.EncryptionManager>()));
    gh.lazySingleton<_i943.DeviceSecurityRepository>(() => injectionModule
        .deviceSecurityRepository(gh<_i943.SafeDeviceAdapter>()));
    gh.lazySingleton<_i943.NotificationRateLimitStrategy>(() => injectionModule
        .notificationRateLimitStrategy(gh<_i943.NotificationRepository>()));
    gh.lazySingleton<_i943.AnalyticsFacade>(
        () => injectionModule.analyticsFacade(gh<_i943.AnalyticsFactory>()));
    gh.lazySingleton<_i943.AuthInterceptor>(
        () => injectionModule.authInterceptor(gh<_i943.StorageFacade>()));
    gh.lazySingleton<_i943.PermissionStrategyFactory>(() => injectionModule
        .permissionStrategyFactory(gh<_i943.PermissionDialogHandler>()));
    gh.lazySingleton<_i943.NetworkMonitorRepository>(
        () => injectionModule.networkMonitorRepository(
              gh<_i943.ConnectivityPlusAdapter>(),
              gh<_i943.InternetCheckStrategy>(),
            ));
    gh.lazySingleton<_i691.ThemeRepository>(() =>
        injectionModule.themeRepository(gh<_i691.ThemeLocalDataSource>()));
    gh.lazySingleton<_i1043.GetAppStatusUseCase>(() =>
        injectionModule.getAppStatusUseCase(gh<_i210.SplashRepository>()));
    gh.lazySingleton<_i943.PermissionRepository>(
        () => injectionModule.permissionRepository(
              gh<_i943.PermissionStrategyFactory>(),
              gh<_i943.PermissionInvoker>(),
            ));
    gh.lazySingleton<_i943.NotificationStrategy>(
        () => injectionModule.notificationStrategy(
              gh<_i943.NotificationRateLimitStrategy>(),
              gh<_i943.AwesomeNotificationsAdapter>(),
              gh<_i943.NotificationChannelRegistry>(),
            ));
    gh.lazySingleton<_i691.LoadThemeModeUseCase>(() =>
        injectionModule.loadThemeModeUseCase(gh<_i691.ThemeRepository>()));
    gh.lazySingleton<_i691.SaveThemeModeUseCase>(() =>
        injectionModule.saveThemeModeUseCase(gh<_i691.ThemeRepository>()));
    gh.lazySingleton<_i943.NetworkMonitorService>(() => injectionModule
        .networkMonitorService(gh<_i943.NetworkMonitorRepository>()));
    gh.lazySingleton<_i852.AppInitializerBloc>(() => _i852.AppInitializerBloc(
          analytics: gh<_i943.AnalyticsFacade>(),
          notificationStrategy: gh<_i943.NotificationStrategy>(),
        ));
    gh.factory<_i442.SplashBloc>(
        () => _i442.SplashBloc(gh<_i1043.GetAppStatusUseCase>()));
    gh.singleton<_i691.ThemeBloc>(() => injectionModule.themeBloc(
          gh<_i691.LoadThemeModeUseCase>(),
          gh<_i691.SaveThemeModeUseCase>(),
          gh<_i352.BrightnessProvider>(),
        ));
    gh.lazySingleton<_i943.NetworkInterceptor>(() =>
        injectionModule.networkInterceptor(gh<_i943.NetworkMonitorService>()));
    gh.lazySingleton<_i943.Dio>(() => injectionModule.dio(
          gh<_i943.NetworkInterceptor>(),
          gh<_i943.AuthInterceptor>(),
          gh<_i943.PayloadInterceptor>(),
          gh<_i943.ApiResponseLogInterceptor>(),
        ));
    gh.lazySingleton<_i943.BaseApiService>(
        () => injectionModule.baseApiService(gh<_i943.Dio>()));
    gh.lazySingleton<_i107.AuthRemoteDataSource>(
        () => injectionModule.authRemoteDataSource(gh<_i943.BaseApiService>()));
    gh.lazySingleton<_i787.AuthRepository>(() => injectionModule.authRepository(
          gh<_i107.AuthRemoteDataSource>(),
          gh<_i852.AuthLocalDataSource>(),
        ));
    gh.lazySingleton<_i37.LoginUseCase>(
        () => injectionModule.loginUseCase(gh<_i787.AuthRepository>()));
    gh.lazySingleton<_i711.LogoutUseCase>(
        () => injectionModule.logoutUseCase(gh<_i787.AuthRepository>()));
    gh.lazySingleton<_i796.GetAuthStatusUseCase>(
        () => injectionModule.getAuthStatusUseCase(gh<_i787.AuthRepository>()));
    gh.factory<_i797.AuthBloc>(() => _i797.AuthBloc(
          gh<_i37.LoginUseCase>(),
          gh<_i711.LogoutUseCase>(),
        ));
    return this;
  }
}

class _$InjectionModule extends _i464.InjectionModule {}
