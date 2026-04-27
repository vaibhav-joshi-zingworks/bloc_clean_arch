import 'package:flutter/material.dart';

import 'app_loading.dart';

class AppScaffold extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? drawer;
  final Widget? endDrawer;
  final Color? backgroundColor;
  final Gradient? gradient;
  final bool useGradient;
  final bool useBackgroundImage;
  final bool resizeToAvoidBottomInset;
  final List<Widget>? persistentFooterButtons;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final bool primary;
  final bool isSafe;
  final bool isOverlayLoader;
  final bool maskForClarity;
  final Future<void> Function()? onRefresh;

  final bool useDefaultMargin;
  final bool usePaddingBottomNavigationBar;

  /// Custom margin if you want to override the default 16
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

    // Handle keyboard dismissal
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

    // Apply refresh indicator if needed
    if (onRefresh != null) {
      content = RefreshIndicator(onRefresh: onRefresh!, child: content);
    }

    return Stack(
      children: [
        // Background
        Container(
          decoration: BoxDecoration(
            gradient: useGradient ? (gradient ?? const LinearGradient(colors: [Colors.blue, Colors.deepOrangeAccent])) : null,
            color: !useGradient ? (backgroundColor) : null,
          ),
        ),

        // Scaffold
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

        // Overlay loader
        if (isOverlayLoader) const Positioned.fill(child: AppLoadingWidget(isInitialApi: false)),
      ],
    );
  }
}
