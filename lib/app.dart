import 'package:ardico_test/resources/app_colors.dart';
import 'package:ardico_test/resources/strings.dart';
import 'package:ardico_test/ui/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        accentColor: AppColors.accent,
      ),
      home: HomePage(),
    );
  }
}
