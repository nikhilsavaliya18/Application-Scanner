import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:launch_review/launch_review.dart';
import 'package:package_info/package_info.dart';
import 'package:sacnner_app/Utils/AppColors.dart';
import 'package:sacnner_app/Utils/ChinaPojo.dart';
import 'package:sacnner_app/Utils/PreferenceHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vdialog/vdialog.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';



class NonIndianAppActivity extends StatefulWidget {
  @override
  _NonIndianAppActivityState createState() => _NonIndianAppActivityState();
}

class _NonIndianAppActivityState extends State<NonIndianAppActivity> {
  PreferenceHelper preferenceHelper;
  SharedPreferences prefs;
  var new_data;
  PackageInfo packageInfo;
  var packageNameplaystore;
  List searchresult = new List();
  bool _isSearching;
  List<ChinaPojo> data= List();
  List<Search> searchList = List<Search>();
  TextEditingController searchController = new TextEditingController();

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
    getSharedPreferenceObject();

  }

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/chaina.json');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Non Indian App"),
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
      body: new Column(children: <Widget>[

        Expanded(
          flex: 7,
          child: Container(
            child: Center(
              child: FutureBuilder(
                  future: DefaultAssetBundle.of(context)
                      .loadString('assets/images/chaina.json'),
                  builder: (context, snapshot) {
                    // Decode the JSON
                    new_data = json.decode(snapshot.data.toString());

                    print("dgfgf"+new_data.toString());

                  /*  ChinaPojo ch=new ChinaPojo();
                    for(var i=0;i>new_data.length;i++){
                      ch.aplogo=new_data[i]['aplogo'];
                      ch.pname=new_data[i]['pname'];
                      ch.aname=new_data[i]['aname'];
                    }
                    data.addAll(ch);*/

                  Search s=new Search();

                    for (int i = 0; i < new_data.length; i++) {
                      s = new Search();
                      s.pname = new_data[i]['pname'];
                      s.aname = new_data[i]['aname'];
                      s.aplogo=new_data[i]['aplogo'];
                      searchList.add(s);

                    }
                    searchresult.add(s);



                    return ListView.builder(
                      // Build the ListView
                      itemBuilder: (BuildContext context, int index) {
                        return ListItem(context, index);
                      },
                      itemCount: new_data == null ? 0 : new_data.length,
                    );
                  }),
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
      ]),
    );
  }




  void searchOperation(String searchText) {

    searchresult.clear();
    if (_isSearching != null) {
      for (int i = 0; i < searchList.length; i++) {
        String data = searchList[i].aname;
        if (data.toLowerCase().contains(searchText.toLowerCase())) {

          print("data "+data);
          Search s=new Search();

          for (int i = 0; i < new_data.length; i++) {
             s = new Search();
            s.pname = new_data[i]['pname'];
            s.aname = new_data[i]['aname'];
            s.aplogo=new_data[i]['aplogo'];
            searchList.add(s);

          }
          searchresult.add(s);
        }
      }
    }
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
      child: new Column(
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: new Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.black,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                NetworkImage(new_data[index]['aplogo']),
                          ),
                        ),
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: new Text(
                                new_data[index]['aname'],
                                textAlign: TextAlign.start,
                                style: new TextStyle(
                                  color: AppColors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10, top: 6),
                              child: new Text(
                                new_data[index]['pname'],
                                style: new TextStyle(
                                    color: AppColors.grayText,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          packageNameplaystore = new_data[index]['pname'];
                        });
                        print('TAG packagename = ' + packageInfo.packageName);
                        LaunchReview.launch(
                            androidAppId: packageNameplaystore,
                            iOSAppId: packageInfo.packageName);
                        /*showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext ctx) => CustomDialog(
                            titleContainerWidget: customTitleText(),
                            contentContainerWidget: customContentText(),
                            customButtonOneWidget: customButtonOne(),
                            // customButtonTwoWidget: customButtonTwo(),
                            showButtonOne: true,
                            showButtonTwo: false,
                            icon: Icons.info_outline,
                            iconHexColor: "ffffff",
                            iconBackgroundHexColor: "FE8484",
                            alignmentIcon: mainAlignment.center,
                          ),
                        );*/
                      },
                      child: new Icon(
                        FontAwesomeIcons.googlePlay,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget customTitleText() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Text(
        "Uninstall App",
        textAlign: TextAlign.end,
        style: TextStyle(
          fontSize: 24,
        ),
      ),
    );
  }

  Widget customContentText() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Text(
                "Step:1",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              new Text(
                " Open PlayStore",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(),
              ),
            ],
          ),
          SizedBox(
            height:10.0,
          ), new Row(
            children: <Widget>[
              new Text(
                "Step:2",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              new Text(
                " Search AppName",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(),
              ),
            ],
          ),
          SizedBox(
            height:10.0,
          ),
          new Row(
            children: <Widget>[
              new Text(
                "Step:3",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              new Text(" Click on Uninstall Button",
              maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget customButtonOne() {
    return Container(
      child: new Row(
        children: <Widget>[
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                height: 44,
                width: MediaQuery.of(context).size.width / 3.5,
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Center(
                  child: Text(
                    'PlayStore'.toUpperCase(),
                    maxLines: 2,
                    style: TextStyle(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            onTap: () {
              SystemChannels.textInput.invokeMethod('TextInput.hide');

              print('TAG packagename = ' + packageInfo.packageName);
              LaunchReview.launch(
                  androidAppId: packageNameplaystore,
                  iOSAppId: packageInfo.packageName);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              child: Container(
                margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                height: 44,
                width: MediaQuery.of(context).size.width / 3.5,
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Center(
                  child: Text(
                    'Cancel'.toUpperCase(),
                    style: TextStyle(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onTap: () {
                SystemChannels.textInput.invokeMethod('TextInput.hide');

                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
