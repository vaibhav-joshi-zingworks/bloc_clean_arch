/// The central export hub for the Core layer.
/// 
/// This barrel file consolidates infrastructure, networking, and common 
/// utilities to provide a single point of import for the rest of the application.

// Standard Dart & Flutter exports
export 'dart:convert';
export 'dart:io';
export 'package:flutter/foundation.dart';
export 'package:flutter/material.dart' hide CarouselController;
export 'package:flutter/services.dart';

// External Package Exports
export 'package:awesome_notifications/awesome_notifications.dart';
export 'package:connectivity_plus/connectivity_plus.dart';
export 'package:dartz/dartz.dart' show Either, Left, Right;
export 'package:device_info_plus/device_info_plus.dart';
export 'package:dio/dio.dart';
export 'package:firebase_analytics/firebase_analytics.dart';
export 'package:firebase_analytics/observer.dart';
export 'package:freezed_annotation/freezed_annotation.dart';
export 'package:gap/gap.dart';
export 'package:get_it/get_it.dart';
export 'package:shared_preferences/shared_preferences.dart';
export 'package:talker/talker.dart';
export 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
export 'package:talker_dio_logger/talker_dio_logger_settings.dart';

// Internal Core Exports
export '../resources/xcore.dart';
export '../utilities/xcore.dart';
export 'core/di/injection.dart';
export 'core/failure/app_exception.dart';
export 'core/failure/failure.dart';
export 'core/models/paginated_result.dart';
export 'core/models/result.dart';
export 'core/models/result_message.dart';
export 'core/network/base_api_service.dart';
export 'core/network/constants/flags.dart';
export 'core/network/constants/network_constants.dart';
export 'core/network/interceptor/api_response_log_interceptor.dart';
export 'core/network/interceptor/auth_interceptor.dart';
export 'core/network/interceptor/network_interceptor.dart';
export 'core/network/interceptor/payload_interceptor.dart';
export 'core/network/network_api_service.dart';
export 'core/network/parser.dart';
export 'core/network/use_case.dart';
export 'core/response/base_response.dart';
export 'core/response/mappers/response_mapper.dart';
export 'core/response/pagination.dart';
export 'core/services/analytics/xcore.dart';
export 'core/services/app_device_info/xcore.dart';
export 'core/services/app_lifecycle_service/app_lifecycle_service.dart';
export 'core/services/local_storage/xcore.dart';
export 'core/services/logger/logger_service.dart';
export 'core/services/messaging/domain/messaging_service.dart';
export 'core/services/network_monitor/xcore.dart';
export 'core/services/notification/xcore.dart';
export 'core/services/permission_handler/xcore.dart';
export 'core/services/security/xcore.dart';
export 'core/services/url_launcher/xcore.dart';
export 'gen/xcore.dart';
