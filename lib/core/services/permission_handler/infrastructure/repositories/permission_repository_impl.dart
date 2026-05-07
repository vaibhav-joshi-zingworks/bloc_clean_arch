import '../../xcore.dart';

/// Concrete implementation of [PermissionRepository] using a Strategy/Command pattern.
/// 
/// It leverages a [PermissionStrategyFactory] to create specialized logic for 
/// each permission type (e.g. Camera vs Location) and an [PermissionInvoker] 
/// to manage execution flow, especially for batch requests.
class PermissionRepositoryImpl implements PermissionRepository {
  final PermissionStrategyFactory _factory;
  final PermissionInvoker _invoker;

  PermissionRepositoryImpl(this._factory, this._invoker);

  @override
  Future<void> requestPermission(Permission permission, {bool showDialog = true}) async {
    // 1. Get the strategy for this specific permission
    final strategy = _factory.createStrategy(permission);
    if (strategy == null) return;
    
    // 2. Execute the request
    await strategy.requestPermission(showDialog);
  }

  @override
  Future<void> requestMultiplePermissions(List<Permission> permissions) async {
    // 1. Enqueue commands for each permission
    for (var permission in permissions) {
      final strategy = _factory.createStrategy(permission);
      if (strategy != null) {
        _invoker.add(_PermissionCommandWrapper(strategy));
      }
    }
    
    // 2. Execute the queue sequentially or in parallel depending on invoker logic
    await _invoker.executeAll();
  }

  @override
  Future<bool> isPermissionGranted(Permission permission) async {
    final status = await permission.status;
    return status.isGranted;
  }
}

/// Internal wrapper to adapt [PermissionStrategy] to the [PermissionCommand] interface.
class _PermissionCommandWrapper implements PermissionCommand {
  final PermissionStrategy _strategy;

  _PermissionCommandWrapper(this._strategy);

  @override
  Future<void> execute() => _strategy.requestPermission(true);
}
