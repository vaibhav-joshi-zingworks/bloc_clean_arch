import '../../xcore.dart';

/// Repository responsible for checking and requesting system permissions.
/// 
/// It abstracts the underlying platform-specific permission logic (Android/iOS).
abstract class PermissionRepository {
  /// Requests a single system [permission]. 
  /// 
  /// Can optionally [showDialog] to explain why the permission is needed.
  Future<void> requestPermission(Permission permission, {bool showDialog = true});
  
  /// Requests a batch of system [permissions] at once.
  Future<void> requestMultiplePermissions(List<Permission> permissions);
  
  /// Synchronously or asynchronously checks if a specific [permission] is already granted.
  Future<bool> isPermissionGranted(Permission permission);
}
