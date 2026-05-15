class UserProfileModel {
  final DataModel? data;

  UserProfileModel({this.data});

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      data: json['data'] != null
          ? DataModel.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
    };
  }
}

class DataModel {
  final List<UserModel> users;
  final int? totalPages;
  final int? totalUsers;
  final String? verifiedEmail;
  final bool? isVerified;
  final List<String> blockedUsers;

  DataModel({
    required this.users,
    this.totalPages,
    this.totalUsers,
    this.verifiedEmail,
    this.isVerified,
    required this.blockedUsers,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      users: (json['user'] as List?)
              ?.map((e) => UserModel.fromJson(e))
              .toList() ??
          [],
      totalPages: json['totalPages'],
      totalUsers: json['totalUsers'],
      verifiedEmail: json['verifiedEmail'],
      isVerified: json['isVerified'],
      blockedUsers:
          List<String>.from(json['blockedUsers'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': users.map((e) => e.toJson()).toList(),
      'totalPages': totalPages,
      'totalUsers': totalUsers,
      'verifiedEmail': verifiedEmail,
      'isVerified': isVerified,
      'blockedUsers': blockedUsers,
    };
  }
}

class UserModel {
  final LocationModel? location;
  final bool? mustUpdateProfile;
  final List<String> favourite;
  final List<String> followers;
  final List<String> following;
  final bool? isAdmin;
  final List<String> deviceId;
  final String? lastLogin;
  final bool? isDeleted;
  final bool? isBlocked;
  final bool? termAndCondition;
  final bool? verified;
  final List<String> passion;
  final String? id;
  final String? email;
  final String? name;
  final String? date;
  final int? version;
  final String? about;
  final String? image;

  UserModel({
    this.location,
    this.mustUpdateProfile,
    required this.favourite,
    required this.followers,
    required this.following,
    this.isAdmin,
    required this.deviceId,
    this.lastLogin,
    this.isDeleted,
    this.isBlocked,
    this.termAndCondition,
    this.verified,
    required this.passion,
    this.id,
    this.email,
    this.name,
    this.date,
    this.version,
    this.about,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : null,
      mustUpdateProfile: json['mustUpdateProfile'],
      favourite: List<String>.from(json['favourite'] ?? []),
      followers: List<String>.from(json['followers'] ?? []),
      following: List<String>.from(json['following'] ?? []),
      isAdmin: json['isAdmin'],
      deviceId: List<String>.from(json['deviceId'] ?? []),
      lastLogin: json['lastLogin'],
      isDeleted: json['isDeleted'],
      isBlocked: json['isBlocked'],
      termAndCondition: json['termAndCondition'],
      verified: json['verified'],
      passion: List<String>.from(json['passion'] ?? []),
      id: json['_id'],
      email: json['email'],
      name: json['name'],
      date: json['date'],
      version: json['__v'],
      about: json['about'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location?.toJson(),
      'mustUpdateProfile': mustUpdateProfile,
      'favourite': favourite,
      'followers': followers,
      'following': following,
      'isAdmin': isAdmin,
      'deviceId': deviceId,
      'lastLogin': lastLogin,
      'isDeleted': isDeleted,
      'isBlocked': isBlocked,
      'termAndCondition': termAndCondition,
      'verified': verified,
      'passion': passion,
      '_id': id,
      'email': email,
      'name': name,
      'date': date,
      '__v': version,
      'about': about,
      'image': image,
    };
  }
}

class LocationModel {
  final List<double> coordinates;

  LocationModel({
    required this.coordinates,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      coordinates:
          List<double>.from(json['coordinates'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coordinates': coordinates,
    };
  }
}