import '../../xcore.dart';

class PermissionInvoker {
  final List<PermissionCommand> _queue = [];

  void add(PermissionCommand command) => _queue.add(command);

  Future<void> executeAll() async {
    for (var command in _queue) {
      await command.execute();
      await Future.delayed(const Duration(milliseconds: 300)); // ANR-safe
    }
    _queue.clear();
  }
}
