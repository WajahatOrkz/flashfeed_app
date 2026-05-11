class UserProfileModel {
  final String name;
  final String email;
  final String about;
  final String? image;

  UserProfileModel({
    required this.name,
    required this.email,
    required this.about,
    this.image,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      about: json['about']?.toString() ?? '',
      image: json['image']?.toString(),
    );
  }
}
