class ProfileModel{
  String user_id;
  String user_name;
  String user_surname;
  String user_email;
  String city;
  String district;

  ProfileModel(
      {required this.user_id,
      required this.user_name,
      required this.user_surname,
      required this.user_email,
      required this.city,
      required this.district});
  factory ProfileModel.fromJson(Map<dynamic,dynamic> json ,String key){
    return ProfileModel(
        user_id: json["user"],
        user_name: json["user_name"],
        user_surname: json["user_surname"],
        user_email: json["user_email"],
        city: json["city"],
        district: json["district"]
    );
  }
}
