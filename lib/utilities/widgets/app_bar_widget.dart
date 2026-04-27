import 'package:bloc_clean_arch/core.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onBack;
  final Color? backgroundColor;
  final Color? titleColor;
  final double elevation;
  final List<Widget>? actions;
  final double? titleFontSize;
  final FontWeight? titleFontWeight;
  final String? backgroundImage;
  final Color? backIconColor;
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

  Widget _buildBackgroundImage() {
    if (_isSvg) {
      return _isNetwork ? Image.network(backgroundImage!, fit: BoxFit.cover) : Image.asset(backgroundImage!, fit: BoxFit.cover);
    }

    return _isNetwork ? Image.network(backgroundImage!, fit: BoxFit.cover) : Image.asset(backgroundImage!, fit: BoxFit.cover);
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);
}
