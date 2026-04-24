import '../services/encryption/xcore.dart';
import '/core.dart';
import 'injection.config.dart';

final sl = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> initDependencies() => sl.init();

@module
abstract class InjectionModule {
  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  @lazySingleton
  Connectivity get connectivity => Connectivity();

  @lazySingleton
  AnalyticsFactory analyticsFactory() => DefaultAnalyticsFactory();

  @lazySingleton
  AnalyticsFacade analyticsFacade(AnalyticsFactory factory) =>
      AnalyticsFacadeImpl(factory.create(AnalyticsType.firebase));

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
}
