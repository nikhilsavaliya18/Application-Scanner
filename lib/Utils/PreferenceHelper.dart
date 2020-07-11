import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'PrefUtils.dart';

class PreferenceHelper {
  SharedPreferences prefs;

  PreferenceHelper(SharedPreferences prefs) {
    this.prefs = prefs;
  }

  void saveIsUserNew(bool isLoggedIn) {
    prefs.setBool(PrefUtils.IS_USERNEW, isLoggedIn);
  }

  bool getIsUserNew() {
    return prefs.getBool(PrefUtils.IS_USERNEW) ?? true;
  }

  void saveIsSpinSound(bool isSinSound) {
    prefs.setBool(PrefUtils.IS_SPINSOUND, isSinSound);
  }

  bool getIsSpinSound() {
    return prefs.getBool(PrefUtils.IS_SPINSOUND) ?? true;
  }

  void saveIsUserLoggedIn(bool isLoggedIn) {
    prefs.setBool(PrefUtils.IS_LOGGED_IN, isLoggedIn);
  }

  bool getIsUserLoggedIn() {
    return prefs.getBool(PrefUtils.IS_LOGGED_IN) ?? false;
  }

  void saveFirebaseToken(String token) {
    prefs.setString(PrefUtils.FB_TOKEN, token);
  }

  String getFirebaseToken() {
    return prefs.getString(PrefUtils.FB_TOKEN) ?? "";
  }

  void saveReceiveAddress(String token) {
    prefs.setString(PrefUtils.RECEIVE_ADDRESS, token);
  }

  String getReceiveAddress() {
    return prefs.getString(PrefUtils.RECEIVE_ADDRESS) ?? "";
  }

  void saveCounter(int counter) {
    prefs.setInt(PrefUtils.IS_COUNTER, counter);
  }

  int getCounter() {
    return prefs.getInt(PrefUtils.IS_COUNTER) ?? '';
  }


  void saveFirebaseUserId(String uid) {
    prefs.setString(PrefUtils.User_Id, uid);
  }

  String getFirebaseUserId() {
    return prefs.getString(PrefUtils.User_Id) ?? "";
  }
  void saveCurrentUserId(String currentuid) {
    prefs.setString(PrefUtils.Current_User_Id, currentuid);
  }

  int getUserStatusTimer() {
    return prefs.getInt(PrefUtils.Current_User_status_timer) ?? 0;
  }
  // ignore: non_constant_identifier_names
  void SaveUserStatusTimer(int time) {
    prefs.setInt(PrefUtils.Current_User_status_timer, time);
  }

  String getCurrentUserId() {
    return prefs.getString(PrefUtils.Current_User_Id) ?? "";
  }
  void saveFirebaseUserStatus(String uid) {
    prefs.setString(PrefUtils.User_STATUS, uid);
  }

  String getFirebaseUserStatus() {
    return prefs.getString(PrefUtils.User_STATUS) ?? "";
  }


  void clearAll() {
    prefs.remove(PrefUtils.USER_DATA);
    prefs.remove(PrefUtils.User_Id);
    prefs.remove(PrefUtils.IS_LOGGED_IN);
    prefs.remove(PrefUtils.USER_BALANCE);
    prefs.remove(PrefUtils.User_STATUS);
    prefs.remove(PrefUtils.FB_TOKEN);
    prefs.remove(PrefUtils.IS_SPINSOUND);
    prefs.remove(PrefUtils.RECEIVE_ADDRESS);
  }
}
