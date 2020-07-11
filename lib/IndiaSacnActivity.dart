import 'package:flutter/material.dart';
import 'package:sacnner_app/InstalledAppActivity.dart';
import 'package:sacnner_app/Utils/AppColors.dart';

import 'package:facebook_audience_network/facebook_audience_network.dart';


class IndiaSacnActivity extends StatefulWidget {
  @override
  _IndiaSacnActivityState createState() => _IndiaSacnActivityState();
}

class _IndiaSacnActivityState extends State<IndiaSacnActivity> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: new Container(
          child: Padding(
            padding: const EdgeInsets.only(top:80.0,left:10.0,right:10.0),
            child:new Column(
              children: <Widget>[
                new Container(
                  // alignment: Alignment.bottomCenter,
                    width: MediaQuery.of(context).size.width,
                    height: 200.0,
                    child: Image.asset(
                      "assets/images/ic_india1.gif",
                      height: 125.0,
                      width: 125.0,
                    )

                ),
                SizedBox(height:20.0),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text("Click on Scan Button to find Chienese app in your mobile",
                  style: TextStyle(fontWeight: FontWeight.w600,color: AppColors.black,fontSize: 25),
                  ),
                ),

                SizedBox(height:20.0),

                InkWell(
                  onTap:(){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              InstalledAppActivity(),
                        ));
                  },
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.black,
                    child: Text(
                      "Scan Now",
                      style: TextStyle(color: AppColors.textColor),
                    ),
                  ),
                ),
                Expanded(

                  child: Container(
                    alignment: Alignment(0.5, 1),
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
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
