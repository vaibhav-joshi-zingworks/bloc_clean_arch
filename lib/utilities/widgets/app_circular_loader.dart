import '/core.dart';

class AppCircularLoader extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final Color? color;

  const AppCircularLoader({
    super.key,
    this.size = 20.0,
    this.strokeWidth = 3.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? Theme.of(context).colorScheme.primary;

    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
        ),
      ),
    );
  }
}
