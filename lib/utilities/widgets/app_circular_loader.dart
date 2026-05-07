import '/core.dart';

/// A standard circular progress indicator styled according to the app's theme.
class AppCircularLoader extends StatelessWidget {
  /// The diameter of the loader. Defaults to 20.0.
  final double size;

  /// The width of the line used to draw the circle. Defaults to 3.0.
  final double strokeWidth;

  /// The color of the loader. Defaults to the theme's primary color.
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
