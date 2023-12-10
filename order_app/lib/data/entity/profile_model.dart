class ProfileModel{
  String user_id;
  String user_name;
  String user_email;
  String city;
  ProfileModel(
      {required this.user_id,
      required this.user_name,
      required this.user_email,
      required this.city});
  factory ProfileModel.fromJson(Map<dynamic,dynamic> json ,String key){
    return ProfileModel(
        user_id: key,
        user_name: json["user_name"] as String,
        user_email: json["user_email"] as String,
        city: json["city"] as String,
    );
  }
}
