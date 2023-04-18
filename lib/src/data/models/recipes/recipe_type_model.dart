class RecipeTypeResponseModel {
  RecipeTypeResponseModel({
    this.success,
    this.message,
    this.totalItems,
    required this.data,
  });

  bool? success;
  String? message;
  int? totalItems;
  List<RecipeTypeModel> data;

  factory RecipeTypeResponseModel.fromJson(Map<String, dynamic> json) =>
      RecipeTypeResponseModel(
        success: json["success"],
        message: json["message"],
        totalItems: json["total_items"],
        data: json["data"] == null
            ? []
            : List<RecipeTypeModel>.from(
                json["data"]!.map((x) => RecipeTypeModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "total_items": totalItems,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class RecipeTypeModel {
  RecipeTypeModel({
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  String name;
  DateTime createdAt;
  DateTime updatedAt;
  String id;

  factory RecipeTypeModel.fromJson(Map<String, dynamic> json) =>
      RecipeTypeModel(
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
