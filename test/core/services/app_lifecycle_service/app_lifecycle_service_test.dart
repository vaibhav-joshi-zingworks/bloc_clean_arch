import 'package:bloc_clean_arch/core/services/app_lifecycle_service/app_lifecycle_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AppLifecycleService updates state correctly', () {
    final service = AppLifecycleService();
    
    // Simulate lifecycle change
    service.didChangeAppLifecycleState(AppLifecycleState.paused);
    expect(service.appState, AppLifecycleState.paused);
    
    service.didChangeAppLifecycleState(AppLifecycleState.resumed);
    expect(service.appState, AppLifecycleState.resumed);
  });
}
