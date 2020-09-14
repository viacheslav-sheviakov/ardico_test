import 'package:ardico_test/resources/app_colors.dart';
import 'package:ardico_test/resources/constants.dart';
import 'package:ardico_test/ui/views/app_bottom_bar/app_bottom_bar.dart';
import 'package:ardico_test/ui/views/app_web_view.dart';
import 'package:ardico_test/ui/views/splash_view.dart';
import 'package:ardico_test/utils/platform_utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WebViewController _webViewController;
  int _currentViewDisplayIndex = 0;
  bool _isSplashGone = false;

  void _onStartPressed() {
    setState(() {
      _currentViewDisplayIndex = 1;
      _isSplashGone = true;
    });
  }

  void _onExploreButtonPressed() {
    _webViewController?.loadUrl(Constants.exploreRusspassUrl);
  }

  void _onTicketsButtonPressed() async {
    final isLowerAndroid = await PlatformUtils.isAndroidSdkLowerThan(28);
    final canLoad = await canLaunch(Constants.aviaTicketsUrl);

    if (isLowerAndroid && canLoad) {
      launch(Constants.aviaTicketsUrl);
    } else {
      _webViewController?.loadUrl(Constants.aviaTicketsUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: IndexedStack(
        index: _currentViewDisplayIndex,
        children: [
          SplashView(onButtonPressed: _onStartPressed),
          _buildPageContents(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildPageContents() {
    return SafeArea(
      bottom: false,
      child: AppWebView(
        webViewControllerInitializer: (WebViewController controller) {
          _webViewController = controller;
        },
      ),
    );
  }

  Widget _buildBottomNavBar() {
    var bottomBar;

    if (_isSplashGone) {
      bottomBar = AppBottomBar(
        onExploreButtonPressed: _onExploreButtonPressed,
        onTicketsButtonPressed: _onTicketsButtonPressed,
      );
    }

    return bottomBar;
  }
}
