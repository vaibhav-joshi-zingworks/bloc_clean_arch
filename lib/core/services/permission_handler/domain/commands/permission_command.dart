/// Interface for wrapping a permission request into a command object.
/// 
/// Primarily used by the [PermissionInvoker] to manage a queue of requests.
abstract class PermissionCommand {
  /// Triggers the execution of the permission request logic.
  Future<void> execute();
}
