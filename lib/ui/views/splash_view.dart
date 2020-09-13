import 'package:ardico_test/resources/app_colors.dart';
import 'package:ardico_test/resources/app_styles.dart';
import 'package:ardico_test/resources/strings.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  final VoidCallback onButtonPressed;

  const SplashView({
    Key key,
    @required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.primary,
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
        onPressed: onButtonPressed,
      ),
    );
  }
}
