import 'package:flutter/material.dart';

import 'app_circular_loader.dart';
import 'app_scaffold.dart';

class AppLoadingWidget extends StatelessWidget {
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
