import 'dart:async';

import 'package:ardico_test/resources/app_colors.dart';
import 'package:ardico_test/resources/constants.dart';
import 'package:ardico_test/ui/pages/link_data_page/link_data_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppWebView extends StatefulWidget {
  final void Function(WebViewController) webViewControllerInitializer;

  const AppWebView({
    Key key,
    @required this.webViewControllerInitializer,
  }) : super(key: key);

  @override
  _AppWebViewState createState() => _AppWebViewState();
}

class _AppWebViewState extends State<AppWebView> {
  bool _isWebViewLoading = false;

  FutureOr<NavigationDecision> _defineNavigation(NavigationRequest request) {
    if (request.url.startsWith(Constants.russpassLinkPrefix)) {
      _navigateToInfoPage(request.url);
      return NavigationDecision.prevent;
    }
    return NavigationDecision.navigate;
  }

  void _navigateToInfoPage(String info) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => LinkDataPage(info: info),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          onWebViewCreated: widget.webViewControllerInitializer,
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
      color: AppColors.primaryOpacity95,
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
}
