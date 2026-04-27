
import '../../core.dart';

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

  final String? text;
  final String? fontFamily;
  final TextStyle? base;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final Color? color;
  final TextAlign? textAlign;
  final double? letterSpacing;
  final double? height;
  final TextOverflow? textOverflow;
  final Color? textDecorationColor;
  final int? maxLines;
  final bool? softWrap;
  final FontStyle? fontStyle;
  final VoidCallback? onTap;
  final bool? isUnderline;

  @override
  Widget build(BuildContext context) {
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

    if (onTap != null) {
      textWidget = InkWell(onTap: onTap, child: textWidget);
    }

    return textWidget;
  }
}
