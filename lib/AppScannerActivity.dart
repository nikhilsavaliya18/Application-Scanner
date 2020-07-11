import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:sacnner_app/Demo.dart';
import 'package:sacnner_app/IndiaSacnActivity.dart';
import 'package:sacnner_app/NonIndianAppActivity.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Utils/AppColors.dart';
import 'package:sacnner_app/InstalledAppActivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:launch_review/launch_review.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';

import 'Utils/PreferenceHelper.dart';

class AppScannerActivity extends StatefulWidget {
  @override
  _AppScannerActivityState createState() => _AppScannerActivityState();
}

class _AppScannerActivityState extends State<AppScannerActivity> {
  PreferenceHelper preferenceHelper;
  SharedPreferences prefs;
  PackageInfo packageInfo;

  getSharedPreferenceObject() async {
    SharedPreferences.getInstance().then((SharedPreferences pr) async {
      prefs = pr;
      preferenceHelper = new PreferenceHelper(prefs);

      packageInfo = await PackageInfo.fromPlatform();


    });
  }

  @override
  void initState() {
    super.initState();
    getSharedPreferenceObject();
    FacebookAudienceNetwork.init(

      testingId: "1c22eca4-3df8-405b-9181-33fb36378dca",
    );
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: "944462399310965_947528505671021",
      listener: (result, value) {
        if (result == InterstitialAdResult.LOADED)
          FacebookInterstitialAd.showInterstitialAd(delay: 5000);
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("App Sccaner"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                AppColors.accent,
                AppColors.primary,
              ])),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    height: 44,
                    width: MediaQuery.of(context).size.width / 1.5,
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                      child: Text(
                        'Installed App'.toUpperCase(),
                        style: TextStyle(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  onTap: () {
                    SystemChannels.textInput.invokeMethod('TextInput.hide');

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              InstalledAppActivity(),
                        ));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                    height: 44,
                    width: MediaQuery.of(context).size.width / 1.5,
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                      child: Text(
                        'Non Indian App'.toUpperCase(),
                        style: TextStyle(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  onTap: () {
                    SystemChannels.textInput.invokeMethod('TextInput.hide');

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              NonIndianAppActivity(),
                        ));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                    height: 44,
                    width: MediaQuery.of(context).size.width / 1.5,
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                      child: Text(
                        'Scan App'.toUpperCase(),
                        style: TextStyle(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  onTap: () {
                    SystemChannels.textInput.invokeMethod('TextInput.hide');

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              IndiaSacnActivity(),
                        ));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                    height: 44,
                    width: MediaQuery.of(context).size.width / 1.5,
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                      child: Text(
                        'Rate Us'.toUpperCase(),
                        style: TextStyle(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  onTap: () {
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                    rateApp();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                    height: 44,
                    width: MediaQuery.of(context).size.width / 1.5,
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                      child: Text(
                        'Share Us'.toUpperCase(),
                        style: TextStyle(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  onTap: () {
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                    shareApp();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                    height: 44,
                    width: MediaQuery.of(context).size.width / 1.5,
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                      child: Text(
                        'Privacy Policy'.toUpperCase(),
                        style: TextStyle(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  onTap: () {
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                    _launchPolicyUrl();
                  },
                ),
              ),
              Container(
                alignment: Alignment(1, 1),
                child: FacebookBannerAd(
                  placementId: "944462399310965_944463042644234",
                  bannerSize: BannerSize.STANDARD,
                  listener: (result, value) {
                    switch (result) {
                      case BannerAdResult.ERROR:
                        print("Error: $value");
                        break;
                      case BannerAdResult.LOADED:
                        print("Loaded: $value");
                        break;
                      case BannerAdResult.CLICKED:
                        print("Clicked: $value");
                        break;
                      case BannerAdResult.LOGGING_IMPRESSION:
                        print("Logging Impression: $value");
                        break;
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _launchPolicyUrl() async {
    String url = 'https://sites.google.com/view/privacytktk/home';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void shareApp() async {
    String packageName = packageInfo.packageName;
    print('TAG packagename = ' + packageInfo.packageName);
    Share.share(
        'Check out My Application at https://play.google.com/store/apps/details?id=$packageName');
  }

  void rateApp() {
    print('TAG packagename = ' + packageInfo.packageName);
    LaunchReview.launch(
        androidAppId: packageInfo.packageName,
        iOSAppId: packageInfo.packageName);
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
