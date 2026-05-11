class PassionModel {
  final String id;
  final String name;

  PassionModel({required this.id, required this.name});

  factory PassionModel.fromJson(Map<String, dynamic> json) {
    return PassionModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }
}
