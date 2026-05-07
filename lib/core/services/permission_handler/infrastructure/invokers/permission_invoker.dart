import '../../xcore.dart';

/// Invoker that manages the execution of a queue of [PermissionCommand]s.
/// 
/// It ensures that system permission dialogs are shown sequentially with a 
/// slight delay to avoid overwhelming the OS or triggering ANRs.
class PermissionInvoker {
  /// Internal queue for permission requests.
  final List<PermissionCommand> _queue = [];

  /// Adds a new command to the request queue.
  void add(PermissionCommand command) => _queue.add(command);

  /// Executes all enqueued permission requests in sequence.
  Future<void> executeAll() async {
    for (var command in _queue) {
      await command.execute();
      
      // Delay to ensure the OS has time to dismiss the previous dialog before showing the next.
      await Future.delayed(const Duration(milliseconds: 300));
    }
    // Clear the queue after successful execution
    _queue.clear();
  }
}
