import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_appavailability/flutter_appavailability.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:launch_review/launch_review.dart';
import 'package:package_info/package_info.dart';
import 'package:sacnner_app/Utils/ChinaPojo.dart';
import 'package:sacnner_app/Utils/PreferenceHelper.dart';
import 'package:sacnner_app/Utils/AppPojo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'Utils/AppColors.dart';

class InstalledAppActivity extends StatefulWidget {
  @override
  _InstalledAppActivityState createState() => _InstalledAppActivityState();
}

class _InstalledAppActivityState extends State<InstalledAppActivity> {
  TextEditingController searchController = new TextEditingController();
  List<Map<String, String>> installedApps;
  PreferenceHelper preferenceHelper;
  SharedPreferences prefs;
  bool _isSearching;
  PackageInfo packageInfo;
  var new_data;
  List<Search> searchList = List<Search>();

  Future<void> getApps() async {
    List<Map<String, String>> _installedApps;

    if (Platform.isAndroid) {
      _installedApps = await AppAvailability.getInstalledApps();

      print(await AppAvailability.checkAvailability("com.android.chrome"));
      // Returns: Map<String, String>{app_name: Chrome, package_name: com.android.chrome, versionCode: null, version_name: 55.0.2883.91}

      print(await AppAvailability.isAppEnabled("com.android.chrome"));
      // Returns: true

    }

    setState(() {
      installedApps = _installedApps;
      print("installedApps"+installedApps.toString());

    });
  }




  getSharedPreferenceObject() async {
    SharedPreferences.getInstance().then((SharedPreferences pr) async {
      prefs = pr;
      preferenceHelper = new PreferenceHelper(prefs);

      packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        if (installedApps == null) getApps();





      });
    });
  }

  @override
  void initState() {
    super.initState();
    _isSearching = false;
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
        title: new Text("Installed App"),
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
      body: new Column(
        children: <Widget>[

          Expanded(
            flex:3,
            child: ListView.builder(
                itemCount: installedApps == null ? 0 : installedApps.length,
                itemBuilder: (context, index) {
                  return ListItem(context,index);
                }),
          ),


          Expanded(
            flex:4,
            child: FutureBuilder(
                future: DefaultAssetBundle.of(context)
                    .loadString('assets/images/chaina.json'),
                builder: (context, snapshot) {

                  new_data = json.decode(snapshot.data.toString());

                  print("dgfgf"+new_data.toString());


                  Search s=new Search();

                  for(int i=0;i<installedApps.length;i++){

                    if(installedApps[i]['app_name']==new_data[i]['aname']){
                      s = new Search();
                      s.pname = new_data[i]['pname'];
                      s.aname = new_data[i]['aname'];
                      s.aplogo=new_data[i]['aplogo'];

                      print("search...."+s.aname.toString());
                    }
                    searchList.add(s);
                    print("search...."+searchList.toString());
                  }

                  for (int i = 0; i < new_data.length; i++) {
                    s = new Search();
                    s.pname = new_data[i]['pname'];
                    s.aname = new_data[i]['aname'];
                    s.aplogo=new_data[i]['aplogo'];
                    searchList.add(s);

                  }




                  return ListView.builder(
                    // Build the ListView
                    itemBuilder: (BuildContext context, int index) {
                      return ListItem(context, index);
                    },
                    itemCount: new_data == null ? 0 : new_data.length,
                  );
                }),
          ),
         /* Expanded(

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
          )*/
        ],
      ),
    );
  }


  Widget ListItem(BuildContext context, int index) {
    return new Container(
      margin: EdgeInsets.only(
        left: 15,
        right: 15,
        top: 15,
      ),
      decoration: new BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.pinkAccent[100],
          blurRadius: 24,
        ),
      ]),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: new Text(
                installedApps[index]["app_name"],
                textAlign: TextAlign.start,
                style: new TextStyle(
                  color: AppColors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            InkWell(
              onTap: (){
                print('TAG packagename = ' + packageInfo.packageName);
                LaunchReview.launch(
                    androidAppId: packageInfo.packageName,
                    iOSAppId: packageInfo.packageName);
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                    padding: EdgeInsets.only(left: 10, top: 6),
                    child: new Icon(
                      FontAwesomeIcons.googlePlay,
                      color: Colors.black,
                      size: 20,
                    ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  /*void searchOperation(String searchText) {

    searchresult.clear();
    if (_isSearching != null) {
      for (int i = 0; i < installedApps.length; i++) {
        String data = installedApps[i]["app_name"];
        if (data.toLowerCase().contains(searchText.toLowerCase())) {

          print("data "+data);
          CategoryData s = new CategoryData(catList[i].catagoryId, catList[i].catagoryname, catList[i].catagoryImage);
          searchresult.add(s);
        }
      }
    }
  }*/

}
