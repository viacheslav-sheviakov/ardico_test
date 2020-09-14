import 'package:ardico_test/resources/strings.dart';

String extractEventIdentifier(String linkUriString) {
  try {
    final linkUri = Uri.parse(linkUriString);
    return linkUri.pathSegments.join(", ");
  } catch (exception) {
    return Strings.generalErrorMessage;
  }
}
