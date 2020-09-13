import 'package:ardico_test/resources/strings.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  final String info;

  const InfoPage({
    Key key,
    this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.infoPageTitle),
      ),
      body: Container(
        child: Center(
          child: Text(info),
        ),
      ),
    );
  }
}
