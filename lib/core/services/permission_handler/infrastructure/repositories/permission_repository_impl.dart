import '../../xcore.dart';

class PermissionRepositoryImpl implements PermissionRepository {
  final PermissionStrategyFactory _factory;
  final PermissionInvoker _invoker;

  PermissionRepositoryImpl(this._factory, this._invoker);

  @override
  Future<void> requestPermission(Permission permission, {bool showDialog = true}) async {
    final strategy = _factory.createStrategy(permission);
    if (strategy == null) return;
    await strategy.requestPermission(showDialog);
  }

  @override
  Future<void> requestMultiplePermissions(List<Permission> permissions) async {
    for (var permission in permissions) {
      final strategy = _factory.createStrategy(permission);
      if (strategy != null) {
        _invoker.add(_PermissionCommandWrapper(strategy));
      }
    }
    await _invoker.executeAll();
  }

  @override
  Future<bool> isPermissionGranted(Permission permission) async {
    final status = await permission.status;
    return status.isGranted;
  }
}

class _PermissionCommandWrapper implements PermissionCommand {
  final PermissionStrategy _strategy;

  _PermissionCommandWrapper(this._strategy);

  @override
  Future<void> execute() => _strategy.requestPermission(true);
}
