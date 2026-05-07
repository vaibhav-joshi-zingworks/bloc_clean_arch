
import '../../core.dart';

/// A widget to display error states with an optional retry action.
/// 
/// It standardizes how exceptions are presented to the user across the app.
class AppErrorWidget extends StatelessWidget {
  /// The [AppException] containing the error message and code.
  final AppException exception;

  /// Optional callback to re-attempt the failed operation.
  final VoidCallback? retry;

  const AppErrorWidget({super.key, required this.exception, this.retry});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Placeholder for an error illustration
              // SvgPicture.asset(config.imageAsset, height: 150),
              const Gap(20),
              AppTextWidget(text: exception.message, fontSize: 18, fontWeight: FontWeight.w700, textAlign: TextAlign.center),
              const Gap(8),
              const AppTextWidget(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
              ),
              const Gap(40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(onPressed: retry, child: const Text('Retry')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

