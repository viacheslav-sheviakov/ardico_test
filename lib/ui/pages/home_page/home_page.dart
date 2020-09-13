import 'package:ardico_test/resources/app_colors.dart';
import 'package:ardico_test/resources/constants.dart';
import 'package:ardico_test/resources/strings.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      color: AppColors.primaryOpacity50,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryDark),
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Material(
      color: AppColors.primary,
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
    );
  }

  Widget _buildExploreButton() {
    return BottomBarButton(
      text: Strings.exploreButtonLabel,
      onTap: () => _webViewController.loadUrl(Constants.exploreRusspassUrl),
    );
  }

  Widget _buildTicketsButton() {
    return BottomBarButton(
      text: Strings.ticketsButtonLabel,
      onTap: () => _webViewController.loadUrl(Constants.aviaTicketsUrl),
    );
  }
}
