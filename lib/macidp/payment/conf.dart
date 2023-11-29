import 'dart:io';

class InAppPaymentSetting {
  // shopperResultUrl : this name must like scheme in intent-filter , url scheme in xcode
  static const String shopperResultUrl = "https://oppwa.com/";
  static const String merchantId = "8ac9a4cd88e221c50188e28742ed0737"; //Done
  static const String countryCode = "SA";
  static getLang() {
    if (Platform.isIOS) {
      return "en"; // ar
    } else {
      return "en_US"; // ar_AR
    }
  }
}
