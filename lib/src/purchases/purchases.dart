import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PaymentsHelper with ChangeNotifier {
  Offerings? offerings;
  static Future<void> initPlatformState() async {
    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup("iBrlteFnLusdGTqBxeZbLQDSBZXzNaew");
  }

  PaymentsHelper(){
    this.fetchOfferings();
  }

  Future<Offerings?> fetchOfferings() async {
    try {
      Offerings offerings = await Purchases.getOfferings();
      if (offerings.current != null) {
        print('Found something');
      } else throw('No Offerings');
      this.offerings = offerings;
      return offerings;
    } on PlatformException catch (e) {
      // optional error handling
      print(e);
    }
  }
}