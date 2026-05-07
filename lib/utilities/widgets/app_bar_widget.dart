import 'package:bloc_clean_arch/core.dart';

/// A customizable [AppBar] wrapper used throughout the application.
/// 
/// It provides common styling, back button handling, and support for 
/// background images (asset or network).
class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  /// The text displayed in the center of the app bar.
  final String title;

  /// Whether to show the default back button. Defaults to true.
  final bool showBackButton;

  /// Custom callback for the back button. If null, it defaults to [Navigator.pop].
  final VoidCallback? onBack;

  /// Custom background color. Defaults to theme's surface color.
  final Color? backgroundColor;

  /// Custom color for the title text.
  final Color? titleColor;

  /// Elevation of the app bar. Defaults to 0.
  final double elevation;

  /// List of widgets to display in the trailing position of the app bar.
  final List<Widget>? actions;

  /// Custom font size for the title.
  final double? titleFontSize;

  /// Custom font weight for the title.
  final FontWeight? titleFontWeight;

  /// Path or URL for a background image.
  final String? backgroundImage;

  /// Custom color for the back button icon.
  final Color? backIconColor;

  /// Custom height for the app bar. Defaults to [kToolbarHeight].
  final double? height;

  const AppBarWidget({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.onBack,
    this.backgroundColor,
    this.titleColor,
    this.elevation = 0,
    this.actions,
    this.titleFontSize,
    this.titleFontWeight,
    this.backgroundImage,
    this.backIconColor,
    this.height,
  });

  bool get _isNetwork => backgroundImage != null && backgroundImage!.startsWith('http');

  bool get _isSvg => backgroundImage != null && backgroundImage!.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      elevation: elevation,
      scrolledUnderElevation: elevation,
      backgroundColor: backgroundImage != null ? Colors.transparent : backgroundColor ?? theme.colorScheme.surface,

      leading: showBackButton
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: backIconColor ?? theme.colorScheme.onSurface),
              onPressed:
                  onBack ??
                  () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
            )
          : null,

      title: AppTextWidget(
        text: title,
        textAlign: TextAlign.center,
        fontSize: titleFontSize,
        fontWeight: titleFontWeight ?? FontWeight.w600,
        color: titleColor ?? theme.colorScheme.onSurface,
        maxLines: 2,
        textOverflow: TextOverflow.ellipsis,
        base: context.text.headlineSmall,
      ),

      actions: actions,

      /// Proper way to apply background image
      flexibleSpace: backgroundImage != null ? FlexibleSpaceBar(background: _buildBackgroundImage()) : null,
    );
  }

  /// Helper to render either a network or asset image based on the [backgroundImage] path.
  Widget _buildBackgroundImage() {
    if (_isSvg) {
      return _isNetwork ? Image.network(backgroundImage!, fit: BoxFit.cover) : Image.asset(backgroundImage!, fit: BoxFit.cover);
    }

    return _isNetwork ? Image.network(backgroundImage!, fit: BoxFit.cover) : Image.asset(backgroundImage!, fit: BoxFit.cover);
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);
}
