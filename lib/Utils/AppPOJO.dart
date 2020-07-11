class AppPOJO {
  String status;
  String package_name;
  String app_name;

  AppPOJO({
    this.package_name,
    this.app_name,
  });

  factory AppPOJO.fromJson(Map<String, dynamic> json) => new AppPOJO(
    package_name: json["package_name"],
    app_name: json["app_name"],
  );

  Map<String, dynamic> toJson() => {
    "package_name": package_name,
    "app_name": app_name,
  };
}

