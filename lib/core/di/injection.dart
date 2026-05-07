import 'package:bloc_clean_arch/core/services/app_device_info/infrastructure/services/brightness_provider.dart';
import 'package:bloc_clean_arch/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '/core.dart';
import '../../app/providers/global_message_cubit.dart';
import '../../app/providers/locale_cubit.dart';
import '../../app/router/app_router.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repository/auth_repository_impl.dart';
import '../../features/auth/domain/repository/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/settings/xcore.dart';
import '../../features/splash/data/datasource/splash_local_data_source.dart';
import '../../features/splash/data/repositories/splash_repository_impl.dart';
import '../../features/splash/domain/repositories/splash_repository.dart';
import '../../features/splash/domain/usecases/get_app_status_usecase.dart';
import '../services/app_device_info/infrastructure/services/flutter_brightness_provider.dart';
import '../services/encryption/xcore.dart';
import 'injection.config.dart';

/// Service Locator instance (GetIt).
final sl = GetIt.instance;

/// Global initialization for dependency injection.
/// 
/// This function triggers the generated [init] method from injectable.
@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> initDependencies() async => sl.init();

/// Module for registering external dependencies and project-wide services.
@module
abstract class InjectionModule {
  
  // --- Core Services ---
  
  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  @lazySingleton
  Connectivity get connectivity => Connectivity();

  // --- Analytics ---
  
  @lazySingleton
  AnalyticsFactory analyticsFactory() => DefaultAnalyticsFactory();

  @lazySingleton
  AnalyticsFacade analyticsFacade(AnalyticsFactory factory) =>
      AnalyticsFacadeImpl(factory.create(AnalyticsType.firebase));

  // --- Storage Strategies ---
  
  @lazySingleton
  StorageStrategy storageStrategy(FlutterSecureStorage secureStorage) =>
      SecureStorageStrategy(secureStorage);

  @lazySingleton
  SharedPreferencesStorageStrategy sharedPreferencesStorageStrategy(
    SharedPreferences sharedPreferences,
  ) =>
      SharedPreferencesStorageStrategy(sharedPreferences);

  @lazySingleton
  SecureStorageStrategy secureStorageStrategy(
    FlutterSecureStorage secureStorage,
  ) =>
      SecureStorageStrategy(secureStorage);

  @lazySingleton
  StorageFacade storageFacade(StorageStrategy strategy) =>
      StrategyBasedStorageFacade(strategy);

  @Named('sharedPreferences')
  @lazySingleton
  StorageFacade sharedPreferencesStorageFacade(
    SharedPreferencesStorageStrategy strategy,
  ) =>
      StrategyBasedStorageFacade(strategy);

  @Named('secureStorage')
  @lazySingleton
  StorageFacade secureStorageFacade(SecureStorageStrategy strategy) =>
      StrategyBasedStorageFacade(strategy);

  @lazySingleton
  StorageStrategyFactory storageStrategyFactory() =>
      DefaultStorageStrategyFactory();

  // --- Network & Security ---

  @lazySingleton
  EncryptionManager encryptionManager() => EncryptionManager(
        type: EncryptionType.aes,
        key: Env.appEncryptionKey,
      );

  @lazySingleton
  ConnectivityPlusAdapter connectivityPlusAdapter(Connectivity connectivity) =>
      ConnectivityPlusAdapter(connectivity);

  @lazySingleton
  InternetCheckStrategy internetCheckStrategy() =>
      InternetCheckStrategyFactory.createDefault();

  @lazySingleton
  NetworkMonitorRepository networkMonitorRepository(
    ConnectivityPlusAdapter connectivityAdapter,
    InternetCheckStrategy internetCheckStrategy,
  ) =>
      DefaultNetworkMonitorRepository(
        connectivityAdapter: connectivityAdapter,
        internetCheckStrategy: internetCheckStrategy,
      );

  @lazySingleton
  NetworkMonitorService networkMonitorService(
    NetworkMonitorRepository repository,
  ) =>
      NetworkMonitorService(repository);

  @lazySingleton
  ApiResponseLogInterceptor apiResponseLogInterceptor() =>
      ApiResponseLogInterceptor();

  @lazySingleton
  AuthInterceptor authInterceptor(StorageFacade storageFacade) =>
      AuthInterceptor(storageFacade);

  @lazySingleton
  NetworkInterceptor networkInterceptor(
    NetworkMonitorService networkMonitorService,
  ) =>
      NetworkInterceptor(networkMonitorService);

  @lazySingleton
  PayloadInterceptor payloadInterceptor(EncryptionManager encryptionManager) =>
      PayloadInterceptor(encryptionManager);

  /// Configures the Dio instance with all necessary interceptors.
  @lazySingleton
  Dio dio(
    NetworkInterceptor networkInterceptor,
    AuthInterceptor authInterceptor,
    PayloadInterceptor payloadInterceptor,
    ApiResponseLogInterceptor apiResponseLogInterceptor,
  ) {
    final dio = Dio(
      BaseOptions(
        baseUrl: Env.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ),
    );

    dio.interceptors.addAll([
      networkInterceptor,
      authInterceptor,
      payloadInterceptor,
      apiResponseLogInterceptor.create(),
    ]);

    return dio;
  }

  @lazySingleton
  BaseApiService baseApiService(Dio dio) => NetworkApiService(dio);

  // --- Device & System Services ---

  @preResolve
  Future<AppDeviceInfoService> appDeviceInfoService() async {
    final service = AppDeviceInfoService();
    await service.initialise();
    return service;
  }

  @lazySingleton
  DeviceInfoRepository deviceInfoRepository(
    AppDeviceInfoService appDeviceInfoService,
  ) =>
      appDeviceInfoService;

  @lazySingleton
  NotificationRepository notificationRepository() =>
      SharedPrefsNotificationRepository();

  @lazySingleton
  NotificationRateLimitStrategy notificationRateLimitStrategy(
    NotificationRepository repository,
  ) =>
      LocalNotificationRateLimitStrategy(repository: repository);

  @lazySingleton
  NotificationChannelRegistry notificationChannelRegistry() =>
      DefaultNotificationChannelRegistry();

  @lazySingleton
  AwesomeNotificationsAdapter awesomeNotificationsAdapter() =>
      AwesomeNotificationsAdapter();

  @lazySingleton
  NotificationStrategy notificationStrategy(
    NotificationRateLimitStrategy rateLimitStrategy,
    AwesomeNotificationsAdapter adapter,
    NotificationChannelRegistry channelRegistry,
  ) =>
      AwesomeNotificationStrategy(
        rateLimitStrategy: rateLimitStrategy,
        adapter: adapter,
        channelRegistry: channelRegistry,
      );

  @lazySingleton
  PermissionDialogHandler permissionDialogHandler() =>
      PermissionDialogHandler();

  @lazySingleton
  PermissionInvoker permissionInvoker() => PermissionInvoker();

  @lazySingleton
  PermissionStrategyFactory permissionStrategyFactory(
    PermissionDialogHandler permissionDialogHandler,
  ) =>
      PermissionStrategyFactory(permissionDialogHandler);

  @lazySingleton
  PermissionRepository permissionRepository(
    PermissionStrategyFactory permissionStrategyFactory,
    PermissionInvoker permissionInvoker,
  ) =>
      PermissionRepositoryImpl(permissionStrategyFactory, permissionInvoker);

  @lazySingleton
  FlutterUrlLauncherAdapter flutterUrlLauncherAdapter() =>
      const FlutterUrlLauncherAdapter();

  @lazySingleton
  UrlLaunchStrategyFactory urlLaunchStrategyFactory() =>
      UrlLaunchStrategyFactory();

  @lazySingleton
  UrlLauncherService urlLauncherService(
    UrlLaunchStrategyFactory urlLaunchStrategyFactory,
  ) =>
      UrlLauncherServiceImpl(urlLaunchStrategyFactory);

  @lazySingleton
  SafeDeviceAdapter safeDeviceAdapter() => SafeDeviceAdapter();

  @lazySingleton
  DeviceSecurityRepository deviceSecurityRepository(
    SafeDeviceAdapter safeDeviceAdapter,
  ) =>
      SafeDeviceService(safeDeviceAdapter);

  @lazySingleton
  ScreenshotScreenRecordingProtectionService
      screenshotScreenRecordingProtectionService() =>
          ScreenshotScreenRecordingProtectionService();

  @lazySingleton
  AppLifecycleService appLifecycleService() => AppLifecycleService();

  // --- App Providers ---

  @singleton
  GlobalMessageCubit globalMessageCubit() => GlobalMessageCubit();

  @singleton
  LocaleCubit localeCubit() => LocaleCubit();

  @lazySingleton
  GoRouter router() {
    return AppRouter.createRouter(
      observers: [],
    );
  }

  // --- Feature Specific Dependencies ---
  
  // Settings & Theme
  @lazySingleton
  ThemeLocalDataSource themeLocalDataSource(StorageFacade storage) =>
      ThemeLocalDataSource(storage);

  @lazySingleton
  ThemeRepository themeRepository(ThemeLocalDataSource ds) =>
      ThemeRepositoryImpl(ds);

  @lazySingleton
  LoadThemeModeUseCase loadThemeModeUseCase(ThemeRepository repository) =>
      LoadThemeModeUseCase(repository);

  @lazySingleton
  SaveThemeModeUseCase saveThemeModeUseCase(ThemeRepository repository) =>
      SaveThemeModeUseCase(repository);

  @lazySingleton
  BrightnessProvider brightnessProvider() => FlutterBrightnessProvider();

  @singleton
  ThemeCubit themeCubit(
    LoadThemeModeUseCase loadThemeModeUseCase,
    SaveThemeModeUseCase saveThemeModeUseCase,
      BrightnessProvider brightnessProvider,
  ) =>
      ThemeCubit(loadThemeModeUseCase, saveThemeModeUseCase,brightnessProvider);

  // Splash
  @lazySingleton
  SplashLocalDataSource splashLocalDataSource(StorageFacade storage) =>
      SplashLocalDataSource(storage);

  @lazySingleton
  SplashRepository splashRepository(SplashLocalDataSource local) =>
      SplashRepositoryImpl(local);

  @lazySingleton
  GetAppStatusUseCase getAppStatusUseCase(SplashRepository repository) =>
      GetAppStatusUseCase(repository);

  // Authentication
  @injectable
  AuthBloc authBloc(LoginUseCase loginUseCase) =>
      AuthBloc(loginUseCase: loginUseCase);
  
  @lazySingleton
  LoginUseCase loginUseCase(AuthRepository repository) =>
      LoginUseCase(repository: repository);

  @lazySingleton
  AuthRepository authRepository(AuthRemoteDataSource remote) =>
      AuthRepositoryImpl(remoteDataSource: remote);

  @lazySingleton
  AuthRemoteDataSource authRemoteDataSource(BaseApiService api) =>
      AuthRemoteDataSourceImpl();
}
