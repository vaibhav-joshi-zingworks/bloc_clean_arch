import 'package:flutter/material.dart';

import 'app_circular_loader.dart';
import 'app_scaffold.dart';

/// A widget used to indicate loading states.
/// 
/// It can either be a standalone full-screen loader (for initial API calls) 
/// or a semi-transparent overlay that blocks user interaction.
class AppLoadingWidget extends StatelessWidget {
  /// If true, returns a full [AppScaffold] with a centered loader.
  /// If false, returns an [AbsorbPointer] overlay with a dimmed background.
  final bool isInitialApi;

  const AppLoadingWidget({super.key, this.isInitialApi = true});

  @override
  Widget build(BuildContext context) {
    if (isInitialApi) {
      return const AppScaffold(isSafe: false, body: Center(child: AppCircularLoader()));
    }

    return AbsorbPointer(
      absorbing: true,
      child: Container(
        color: Colors.black.withValues(alpha: 0.2),
        child: const Center(child: AppCircularLoader()),
      ),
    );
  }
}
