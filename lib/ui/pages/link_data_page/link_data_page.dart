import 'package:ardico_test/resources/app_styles.dart';
import 'package:ardico_test/resources/strings.dart';
import 'package:ardico_test/utils/deep_link_utils.dart';
import 'package:flutter/material.dart';

class LinkDataPage extends StatelessWidget {
  final String info;

  const LinkDataPage({
    Key key,
    this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.infoPageTitle),
      ),
      body: _buildPageBody(),
    );
  }

  Widget _buildPageBody() {
    return Container(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            extractEventIdentifier(info),
            textAlign: TextAlign.center,
            style: AppStyles.infoPageText,
          ),
        ),
      ),
    );
  }
}
