
import '../../core.dart';

class AppErrorWidget extends StatelessWidget {
  final AppException exception;
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
              // SvgPicture.asset(config.imageAsset, height: 150),
              Gap(20),
              AppTextWidget(text: exception.message,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.center),
              Gap(8),
              AppTextWidget(
                // text: config.description,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
              ),
              Gap(40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(onPressed: retry, child: Text('Retry')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}