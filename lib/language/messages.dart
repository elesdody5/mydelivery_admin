import 'package:get/get.dart';

import 'ar.dart';
import 'en.dart';

class Messages extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {'en_US': enJson, "ar": arJson};
}
