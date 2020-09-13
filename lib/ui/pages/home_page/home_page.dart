import 'dart:async';

import 'package:ardico_test/resources/app_colors.dart';
import 'package:ardico_test/resources/constants.dart';
import 'package:ardico_test/resources/strings.dart';
import 'package:ardico_test/ui/pages/link_data_page/link_data_page.dart';
import 'package:ardico_test/ui/views/bottom_bar_button.dart';
import 'package:ardico_test/ui/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WebViewController _webViewController;
  bool _isWebViewLoading = false;
  int _displayIndex = 0;

  void _onStartPressed() {
    setState(() {
      _displayIndex = 1;
    });
  }

  void _navigateToInfoPage(String info) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => LinkDataPage(info: info),
      ),
    );
  }

  FutureOr<NavigationDecision> _defineNavigation(NavigationRequest request) {
    if (request.url.startsWith(Constants.russpassLinkPrefix)) {
      _navigateToInfoPage(request.url);
      return NavigationDecision.prevent;
    }
    return NavigationDecision.navigate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: IndexedStack(
        index: _displayIndex,
        children: [
          SplashView(
            onButtonPressed: _onStartPressed,
          ),
          _buildPageContents(),
        ],
      ),
    );
  }

  Widget _buildPageContents() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SafeArea(
            bottom: false,
            child: _buildWebView(),
          ),
        ),
        _buildBottomBar(),
      ],
    );
  }

  Widget _buildWebView() {
    return Stack(
      children: [
        WebView(
          onPageStarted: (_) => setState(() {
            _isWebViewLoading = true;
          }),
          onPageFinished: (_) => setState(() {
            _isWebViewLoading = false;
          }),
          initialUrl: Constants.exploreRusspassUrl,
          onWebViewCreated: (WebViewController webViewController) {
            _webViewController = webViewController;
          },
          javascriptMode: JavascriptMode.unrestricted,
          initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
          navigationDelegate: _defineNavigation,
        ),
        if (_isWebViewLoading) _buildPositionedLoader(),
      ],
    );
  }

  Widget _buildPositionedLoader() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: _buildProgressContainer(),
    );
  }

  Widget _buildProgressContainer() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.primaryOpacity75,
      child: Center(
        child: SizedBox(
          width: 64.0,
          height: 64.0,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryDark),
            strokeWidth: 6.0,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Material(
      color: AppColors.primary,
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: _buildExploreButton(),
            ),
            Expanded(
              child: _buildTicketsButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExploreButton() {
    return BottomBarButton(
      text: Strings.exploreButtonLabel,
      onTap: () => _webViewController?.loadUrl(Constants.exploreRusspassUrl),
    );
  }

  Widget _buildTicketsButton() {
    return BottomBarButton(
      text: Strings.ticketsButtonLabel,
      onTap: () => _webViewController?.loadUrl(Constants.aviaTicketsUrl),
    );
  }
}
