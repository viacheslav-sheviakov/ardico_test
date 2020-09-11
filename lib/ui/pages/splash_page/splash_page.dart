import 'package:ardico_test/resources/app_colors.dart';
import 'package:ardico_test/resources/app_styles.dart';
import 'package:ardico_test/resources/strings.dart';
import 'package:ardico_test/ui/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void _navigateHome() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => HomePage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildTitle(),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Expanded(
      child: Center(
        child: Text(
          Strings.appName,
          style: AppStyles.splashTitle,
        ),
      ),
    );
  }

  Widget _buildButton() {
    return Padding(
      padding: EdgeInsets.all(32.0),
      child: MaterialButton(
        padding: EdgeInsets.all(16.0),
        color: AppColors.primaryDark,
        minWidth: double.infinity,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Text(
          Strings.startButtonLabel.toUpperCase(),
          style: AppStyles.appButtonText,
        ),
        onPressed: _navigateHome,
      ),
    );
  }
}
