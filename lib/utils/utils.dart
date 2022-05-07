import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Utils {
  static Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  static void loadAd(String adId) {
    InterstitialAd.load(
        adUnitId: adId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            ad.show();
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (InterstitialAd ad) =>
                  ad.dispose(),
              onAdFailedToShowFullScreenContent:
                  (InterstitialAd ad, AdError error) => ad.dispose(),
            );
          },
          onAdFailedToLoad: (LoadAdError error) {},
        ));
  }
}
