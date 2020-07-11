class ChinaPojo {
   String pname;
   String aname;
   String aplogo;

  ChinaPojo({this.pname, this.aname, this.aplogo});

  factory ChinaPojo.fromJson(Map<String, dynamic> json) {
    return new ChinaPojo(
      pname: json['name'] as String,
      aname: json['aname'] as String,
      aplogo: json['aplogo'] as String,
    );
  }
}

class Search {

  String pname;
  String aname;
  String aplogo;
  String uid;

  Search({this.pname, this.aname,this.aplogo});

  Map toMap(Search user) {
    var data = Map<String, dynamic>();
    data['pname'] = user.pname;
    data['aname'] = user.aname;
    data['aplogo'] = user.aplogo;

    return data;
  }

  Search.fromMap(Map<String, dynamic> mapData) {
    this.pname = mapData['pname'];
    this.aname = mapData['aname'];
    this.aplogo = mapData['imgUrl'];

  }


}

