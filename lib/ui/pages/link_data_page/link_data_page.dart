import 'package:ardico_test/resources/app_styles.dart';
import 'package:ardico_test/resources/strings.dart';
import 'package:ardico_test/utils/deep_link_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LinkDataPage extends StatelessWidget {
  final String info;

  const LinkDataPage({
    Key key,
    this.info,
  }) : super(key: key);

  void _hideKeyboard() {
    FocusManager.instance.primaryFocus.unfocus();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  bool _isOpenedFromApp(BuildContext context) {
    return Navigator.of(context).canPop();
  }

  void _closeApp() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  @override
  Widget build(BuildContext context) {
    _hideKeyboard();
    return Scaffold(
      appBar: AppBar(
        leading: _buildAppBarButton(context),
        title: Text(Strings.linkDataPageTitle),
        centerTitle: true,
      ),
      body: _buildPageBody(),
    );
  }
  
  Widget _buildAppBarButton(BuildContext context) {
    if (_isOpenedFromApp(context)) {
      return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        color: Colors.white,
        onPressed: () => Navigator.of(context).pop(),
      );
    }
    
    return IconButton(
      icon: Icon(Icons.close),
      color: Colors.white,
      onPressed: _closeApp,
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
