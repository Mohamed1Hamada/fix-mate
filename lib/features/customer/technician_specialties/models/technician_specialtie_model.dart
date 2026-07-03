class TechnicianSpecialtyModel  {
  final String id;
  final String name;
  final String image;

  TechnicianSpecialtyModel ({required this.name, required this.image, required this.id});
  factory TechnicianSpecialtyModel.fromJson(Map<String, dynamic> json) {
    return TechnicianSpecialtyModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
  toJson() => {"id": id, 'name': name, 'image': image};
}
