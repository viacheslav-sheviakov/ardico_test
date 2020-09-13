import 'dart:async';

import 'package:ardico_test/resources/app_colors.dart';
import 'package:ardico_test/resources/strings.dart';
import 'package:ardico_test/ui/pages/home_page/home_page.dart';
import 'package:ardico_test/ui/pages/link_data_page/link_data_page.dart';
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
      _initialPage = LinkDataPage(info: info ?? Strings.generalErrorMessage);
    });
  }

  _initPlatformStateForStringUniLinks() async {
    _deepLinksSubscription = getLinksStream().listen(
      (String link) {
        if (!mounted) return;
        _navigateToInfoPage(link ?? Strings.generalErrorMessage);
      },
      onError: (err) {
        if (!mounted) return;
        _navigateToInfoPage(err.toString());
      },
    );

    String initialLink;
    try {
      initialLink = await getInitialLink();
    } on PlatformException {
      initialLink = Strings.errorGettingInitialLinkMessage;
    } on FormatException {
      initialLink = Strings.errorParsingUri;
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
