
import '../../core.dart';

/// A wrapper for the [Text] widget that provides a unified way to handle 
/// typography throughout the application.
/// 
/// It allows for easy overrides of common properties while maintaining 
/// a [base] style from the current [TextTheme].
class AppTextWidget extends StatelessWidget {
  const AppTextWidget({
    super.key,
    this.text,
    this.fontSize,
    this.base,
    this.color,
    this.textAlign,
    this.fontWeight,
    this.letterSpacing,
    this.height,
    this.textOverflow,
    this.textDecoration,
    this.textDecorationColor,
    this.maxLines,
    this.softWrap,
    this.fontStyle,
    this.onTap,
    this.fontFamily,
    this.isUnderline,
  });

  /// The text to display.
  final String? text;

  /// Custom font family.
  final String? fontFamily;

  /// The base [TextStyle] from the theme to build upon.
  final TextStyle? base;

  /// Custom font size. Overrides [base].
  final double? fontSize;

  /// Custom font weight. Overrides [base].
  final FontWeight? fontWeight;

  /// Text decoration (e.g., underline, line-through).
  final TextDecoration? textDecoration;

  /// Custom text color. Overrides [base].
  final Color? color;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// Custom letter spacing.
  final double? letterSpacing;

  /// Custom line height.
  final double? height;

  /// How visual overflow should be handled.
  final TextOverflow? textOverflow;

  /// Custom color for the [textDecoration].
  final Color? textDecorationColor;

  /// An optional maximum number of lines for the text to span.
  final int? maxLines;

  /// Whether the text should break at soft line breaks.
  final bool? softWrap;

  /// Custom font style (e.g., italic).
  final FontStyle? fontStyle;

  /// Optional callback for when the text is tapped.
  final VoidCallback? onTap;

  /// Helper flag to quickly apply an underline decoration.
  final bool? isUnderline;

  @override
  Widget build(BuildContext context) {
    // Default to bodyMedium if no base style is provided
    final baseStyle = base ?? context.text.bodyMedium!;

    Widget textWidget = Text(
      textAlign: textAlign,
      text ?? "",
      overflow: textOverflow,
      maxLines: maxLines,

      softWrap: softWrap ?? true,
      style: baseStyle.copyWith(
        decoration: isUnderline == true ? TextDecoration.underline : textDecoration,
        decorationColor: textDecorationColor,
        height: height,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
        fontStyle: fontStyle,
        fontFamily: fontFamily,
      ),
    );

    // If onTap is provided, wrap the text in an InkWell for interactivity
    if (onTap != null) {
      textWidget = InkWell(onTap: onTap, child: textWidget);
    }

    return textWidget;
  }
}
