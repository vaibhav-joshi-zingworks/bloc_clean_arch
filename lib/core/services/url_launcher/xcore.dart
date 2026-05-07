/// Barrel file for the URL Launcher service.
/// 
/// Consolidates all URL launching logic, including domain interfaces, 
/// infrastructure strategies, and factories.
export 'package:url_launcher/url_launcher.dart';

export 'domain/config/launch_mode_config.dart';
export 'domain/enums/url_type.dart';
export 'domain/services/url_launcher_service.dart';
export 'domain/strategies/url_launch_strategy.dart';
export 'factories/url_launch_strategy_factory.dart';
export 'infrastructure/adapters/flutter_url_launcher_adapter.dart';
export 'infrastructure/services/url_launcher_service_impl.dart';
export 'infrastructure/strategies/default_url_launch_strategy.dart';
export 'infrastructure/strategies/email_url_launch_strategy.dart';
export 'infrastructure/strategies/maps_url_launch_strategy.dart';
export 'infrastructure/strategies/phone_url_launch_strategy.dart';
export 'infrastructure/strategies/sms_url_launch_strategy.dart';
export 'infrastructure/strategies/web_url_launch_strategy.dart';
export 'infrastructure/strategies/whatsapp_url_launch_strategy.dart';
