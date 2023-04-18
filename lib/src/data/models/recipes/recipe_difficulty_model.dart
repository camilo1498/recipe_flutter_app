class RecipeDifficultyResponseModel {
  RecipeDifficultyResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool success;
  final String message;
  final List<RecipeDifficultyModel> data;

  factory RecipeDifficultyResponseModel.fromJson(Map<String, dynamic> json) =>
      RecipeDifficultyResponseModel(
        success: json["success"],
        message: json["message"],
        data: List<RecipeDifficultyModel>.from(
            json["data"].map((x) => RecipeDifficultyModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class RecipeDifficultyModel {
  RecipeDifficultyModel({
    required this.name,
    required this.id,
  });

  final String name;
  final String id;

  factory RecipeDifficultyModel.fromJson(Map<String, dynamic> json) =>
      RecipeDifficultyModel(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}
