import 'package:ardico_test/resources/app_colors.dart';
import 'package:ardico_test/resources/constants.dart';
import 'package:ardico_test/resources/strings.dart';
import 'package:ardico_test/ui/views/bottom_bar_button.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WebViewController _controller;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            WebView(
              onPageStarted: (_) => setState(() {
                _isLoading = true;
              }),
              onPageFinished: (_) => setState(() {
                _isLoading = false;
              }),
              initialUrl: Constants.exploreRusspassUrl,
              onWebViewCreated: (WebViewController webViewController) {
                _controller = webViewController;
              },
              javascriptMode: JavascriptMode.unrestricted,
              initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
            ),
            if (_isLoading) _buildPositionedLoader(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
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
            child: BottomBarButton(
              text: Strings.exploreButtonLabel,
              onTap: () => _controller.loadUrl(Constants.exploreRusspassUrl),
            ),
          ),
          Expanded(
            child: BottomBarButton(
              text: Strings.ticketsButtonLabel,
              onTap: () => _controller.loadUrl(Constants.aviaTicketsUrl),
            ),
          ),
        ],
      ),
    );
  }
}
