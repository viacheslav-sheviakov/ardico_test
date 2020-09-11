import 'package:ardico_test/resources/app_styles.dart';
import 'package:flutter/material.dart';

class BottomBarButton extends StatelessWidget {
  final String text;
  final void Function() onTap;

  const BottomBarButton({
    Key key,
    @required this.text,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 50.0,
        child: Center(
          child: Text(
            text.toUpperCase(),
            style: AppStyles.bottomBarButton,
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
