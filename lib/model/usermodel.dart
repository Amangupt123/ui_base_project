class ProfileModel {
  String? email;
  String? name;
  String? dateofBirth;
  ProfileModel({
    this.email,
    this.name,
    this.dateofBirth,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    dateofBirth = json['dateofBirth'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['name'] = name;
    _data['dateofBirth'] = dateofBirth;
    return _data;
  }
}
