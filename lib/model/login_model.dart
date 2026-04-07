class LoginModel {
  String? authToken;
  String? name;
  String? email;
  bool? verified;
  bool? requireProfileUpdate;
  List<String>? blockedUsers;
  String? sId;

  LoginModel(
      {this.authToken,
      this.name,
      this.email,
      this.verified,
      this.requireProfileUpdate,
      this.blockedUsers,
      this.sId});

  LoginModel.fromJson(Map<String, dynamic> json) {
    authToken = json['authToken'];
    name = json['name'];
    email = json['email'];
    verified = json['verified'];
    requireProfileUpdate = json['requireProfileUpdate'];
    blockedUsers = json['BlockedUsers'].cast<String>();
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authToken'] = this.authToken;
    data['name'] = this.name;
    data['email'] = this.email;
    data['verified'] = this.verified;
    data['requireProfileUpdate'] = this.requireProfileUpdate;
    data['BlockedUsers'] = this.blockedUsers;
    data['_id'] = this.sId;
    return data;
  }
}
