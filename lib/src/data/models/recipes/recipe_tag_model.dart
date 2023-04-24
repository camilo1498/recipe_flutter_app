class RecipeTagResponseModel {
  RecipeTagResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool success;
  final String message;
  final List<RecipeTagModel> data;

  factory RecipeTagResponseModel.fromJson(Map<String, dynamic> json) =>
      RecipeTagResponseModel(
        success: json["success"],
        message: json["message"],
        data: List<RecipeTagModel>.from(
            json["data"].map((x) => RecipeTagModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class RecipeTagModel {
  RecipeTagModel({
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;

  factory RecipeTagModel.fromJson(Map<String, dynamic> json) => RecipeTagModel(
        name: json["name"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
      };
}
