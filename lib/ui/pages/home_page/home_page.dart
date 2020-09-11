import 'package:ardico_test/resources/app_colors.dart';
import 'package:ardico_test/resources/app_styles.dart';
import 'package:ardico_test/resources/constants.dart';
import 'package:ardico_test/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: Constants.exploreRusspassUrl,
          onWebViewCreated: (WebViewController webViewController) {
            _controller = webViewController;
          },
          javascriptMode: JavascriptMode.unrestricted,
          initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
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
            child: _buildAviaTicketsButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildExploreButton() {
    return InkWell(
      child: Container(
        height: 50.0,
        child: Center(
          child: Text(
            Strings.exploreButtonLabel.toUpperCase(),
            style: AppStyles.bottomBarButton,
          ),
        ),
      ),
      onTap: () => _controller.loadUrl(Constants.exploreRusspassUrl),
    );
  }

  Widget _buildAviaTicketsButton() {
    return InkWell(
      child: Container(
        height: 50.0,
        child: Center(
          child: Text(
            Strings.ticketsButtonLabel.toUpperCase(),
            style: AppStyles.bottomBarButton,
          ),
        ),
      ),
      onTap: () => _controller.loadUrl(Constants.aviaTicketsUrl),
    );
  }
}
