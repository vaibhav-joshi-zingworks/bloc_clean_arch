import 'package:flutter/material.dart';

import 'app_loading.dart';

/// A standard [Scaffold] wrapper providing consistent layout, background, 
/// and common behavior (like keyboard dismissal and safety areas).
class AppScaffold extends StatelessWidget {
  /// The key used to access the [ScaffoldState].
  final GlobalKey<ScaffoldState>? scaffoldKey;

  /// Optional app bar to display at the top.
  final PreferredSizeWidget? appBar;

  /// The primary content of the scaffold.
  final Widget? body;

  /// A button displayed floating above the body.
  final Widget? floatingActionButton;

  /// The location of the [floatingActionButton].
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// A panel displayed to the side of the body, often hidden on mobile.
  final Widget? drawer;

  /// A panel displayed to the side of the body, opposite to the [drawer].
  final Widget? endDrawer;

  /// The color of the background.
  final Color? backgroundColor;

  /// An optional gradient background.
  final Gradient? gradient;

  /// Whether to use the [gradient] instead of [backgroundColor].
  final bool useGradient;

  /// Whether to use a background image (config currently depends on theme).
  final bool useBackgroundImage;

  /// Whether the body should resize when the keyboard appears.
  final bool resizeToAvoidBottomInset;

  /// A set of buttons displayed at the bottom of the scaffold.
  final List<Widget>? persistentFooterButtons;

  /// A navigation bar to display at the bottom of the scaffold.
  final Widget? bottomNavigationBar;

  /// A sheet to display at the bottom of the scaffold.
  final Widget? bottomSheet;

  /// Whether the body should extend to the bottom of the screen.
  final bool extendBody;

  /// Whether the body should extend behind the [appBar].
  final bool extendBodyBehindAppBar;

  /// Whether the scaffold is the primary content.
  final bool primary;

  /// Whether to wrap the body in a [SafeArea].
  final bool isSafe;

  /// Whether to display a full-screen overlay loader over the scaffold.
  final bool isOverlayLoader;

  /// Whether to apply a mask for visual clarity when the loader is shown.
  final bool maskForClarity;

  /// An optional callback to enable pull-to-refresh on the body.
  final Future<void> Function()? onRefresh;

  /// Whether to apply default horizontal margins to the body content.
  final bool useDefaultMargin;

  /// Whether to apply standard padding to the [bottomNavigationBar].
  final bool usePaddingBottomNavigationBar;

  /// Custom margin to override the default spacing.
  final EdgeInsets? margin;

  const AppScaffold({
    super.key,
    this.scaffoldKey,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.drawer,
    this.endDrawer,
    this.backgroundColor,
    this.gradient,
    this.useGradient = false,
    this.useBackgroundImage = false,
    this.resizeToAvoidBottomInset = true,
    this.persistentFooterButtons,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.primary = true,
    this.isSafe = true,
    this.isOverlayLoader = false,
    this.maskForClarity = false,
    this.onRefresh,
    this.useDefaultMargin = true,
    this.usePaddingBottomNavigationBar = true,
    this.margin,
  }) : assert(isOverlayLoader || body != null, 'body cannot be null unless overlay loader is shown');

  @override
  Widget build(BuildContext context) {
    // Start with the original body
    Widget bodyContent = body ?? const SizedBox.shrink();

    // Apply margin if needed
    if (useDefaultMargin || margin != null) {
      bodyContent = Padding(padding: margin ?? const EdgeInsets.all(16.0), child: bodyContent);
    }

    // Handle keyboard dismissal and safety areas
    Widget content = GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.unfocus();
        }
      },
      child: isSafe ? SafeArea(child: bodyContent) : bodyContent,
    );

    // Apply refresh indicator if onRefresh callback is provided
    if (onRefresh != null) {
      content = RefreshIndicator(onRefresh: onRefresh!, child: content);
    }

    return Stack(
      children: [
        // Background layer (Color or Gradient)
        Container(
          decoration: BoxDecoration(
            gradient: useGradient ? (gradient ?? const LinearGradient(colors: [Colors.blue, Colors.deepOrangeAccent])) : null,
            color: !useGradient ? (backgroundColor) : null,
          ),
        ),

        // Primary Scaffold layer
        Scaffold(
          key: scaffoldKey,
          appBar: appBar,
          extendBody: extendBody,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation,
          drawer: drawer,
          endDrawer: endDrawer,
          persistentFooterButtons: persistentFooterButtons,
          bottomSheet: bottomSheet,
          bottomNavigationBar: bottomNavigationBar != null
              ? SafeArea(
                  top: false,
                  child: usePaddingBottomNavigationBar
                      ? Padding(padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8), child: bottomNavigationBar!)
                      : bottomNavigationBar!,
                )
              : null,
          // backgroundColor: Colors.transparent,
          body: content,
        ),

        // Optional full-screen overlay loader layer
        if (isOverlayLoader) const Positioned.fill(child: AppLoadingWidget(isInitialApi: false)),
      ],
    );
  }
}
