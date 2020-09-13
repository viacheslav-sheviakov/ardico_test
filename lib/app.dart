import 'dart:async';

import 'package:ardico_test/resources/app_colors.dart';
import 'package:ardico_test/resources/strings.dart';
import 'package:ardico_test/ui/pages/home_page/home_page.dart';
import 'package:ardico_test/ui/pages/info_page/info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription _deepLinksSubscription;
  Widget _initialPage = HomePage();

  @override
  void initState() {
    super.initState();
    _initPlatformStateForStringUniLinks();
  }

  @override
  dispose() {
    if (_deepLinksSubscription != null) _deepLinksSubscription.cancel();
    super.dispose();
  }

  void _navigateToInfoPage(String info) {
    setState(() {
      _initialPage = InfoPage(info: info ?? Strings.errorMessage);
    });
  }

  /// An implementation using a [String] link
  _initPlatformStateForStringUniLinks() async {
    // Attach a listener to the links stream
    _deepLinksSubscription = getLinksStream().listen(
      (String link) {
        if (!mounted) return;
        _navigateToInfoPage(link ?? Strings.errorMessage);
      },
      onError: (err) {
        if (!mounted) return;
        _navigateToInfoPage('Failed to get latest link: $err.');
      },
    );

    // Get the latest link
    String initialLink;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      initialLink = await getInitialLink();
    } on PlatformException {
      initialLink = 'Failed to get initial link.';
    } on FormatException {
      initialLink = 'Failed to parse the initial link as Uri.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    if (initialLink != null) {
      _navigateToInfoPage(initialLink);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        accentColor: AppColors.accent,
      ),
      home: _initialPage,
    );
  }
}
