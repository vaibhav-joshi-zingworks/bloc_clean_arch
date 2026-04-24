import '../../xcore.dart';

abstract class PermissionRepository {
  Future<void> requestPermission(Permission permission, {bool showDialog = true});
  Future<void> requestMultiplePermissions(List<Permission> permissions);
  Future<bool> isPermissionGranted(Permission permission);
}
