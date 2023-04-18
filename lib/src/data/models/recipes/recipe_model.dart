class RecipeResponseModel {
  RecipeResponseModel({
    required this.success,
    required this.message,
    this.totalItems,
    required this.data,
  });

  final bool success;
  final String message;
  final int? totalItems;
  final List<RecipeModel> data;

  factory RecipeResponseModel.fromJson(Map<String, dynamic> json) =>
      RecipeResponseModel(
        success: json["success"],
        message: json["message"],
        totalItems: json["total_items"],
        data: List<RecipeModel>.from(
            json["data"].map((x) => RecipeModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "total_items": totalItems,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class RecipeModel {
  RecipeModel({
    required this.image,
    required this.name,
    required this.portions,
    required this.preparationTime,
    required this.videoUri,
    required this.difficulty,
    required this.type,
    required this.steps,
    required this.comments,
    required this.ingredients,
    required this.favouriteCount,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  final RecipeImage image;
  final String name;
  final int portions;
  final int preparationTime;
  final String videoUri;
  final Difficulty difficulty;
  final Type type;
  final List<Step> steps;
  final List<dynamic> comments;
  final List<String> ingredients;
  final List<dynamic> favouriteCount;
  final CreatedBy createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        image: RecipeImage.fromJson(json["image"]),
        name: json["name"],
        portions: json["portions"],
        preparationTime: json["preparationTime"],
        videoUri: json["videoUri"],
        difficulty: Difficulty.fromJson(json["difficulty"]),
        type: Type.fromJson(json["type"]),
        steps: List<Step>.from(json["steps"].map((x) => Step.fromJson(x))),
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        ingredients: List<String>.from(json["ingredients"].map((x) => x)),
        favouriteCount:
            List<dynamic>.from(json["favourite_count"].map((x) => x)),
        createdBy: CreatedBy.fromJson(json["created_by"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "image": image.toJson(),
        "name": name,
        "portions": portions,
        "preparationTime": preparationTime,
        "videoUri": videoUri,
        "difficulty": difficulty.toJson(),
        "type": type.toJson(),
        "steps": List<dynamic>.from(steps.map((x) => x.toJson())),
        "comments": List<dynamic>.from(comments.map((x) => x)),
        "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
        "favourite_count": List<dynamic>.from(favouriteCount.map((x) => x)),
        "created_by": createdBy,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
      };
}

class RecipeImage {
  RecipeImage({
    required this.pathFolder,
    required this.images,
  });

  final String pathFolder;
  final List<String> images;

  factory RecipeImage.fromJson(Map<String, dynamic> json) => RecipeImage(
        pathFolder: json["path_folder"],
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "path_folder": pathFolder,
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}

class Step {
  Step({
    required this.title,
    required this.description,
    required this.id,
  });

  final String title;
  final String description;
  final String id;

  factory Step.fromJson(Map<String, dynamic> json) => Step(
        title: json["title"],
        description: json["description"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "_id": id,
      };
}

class Type {
  Type({
    required this.name,
    required this.id,
  });

  final String name;
  final String id;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}

class CreatedBy {
  CreatedBy({
    required this.name,
    required this.lastname,
    required this.id,
  });

  final String name;
  final String lastname;
  final String id;

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        name: json["name"],
        lastname: json["lastname"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lastname": lastname,
        "id": id,
      };
}

class Difficulty {
  Difficulty({
    required this.name,
    this.id = '',
  });

  final String name;
  final String id;

  factory Difficulty.fromJson(Map<String, dynamic> json) => Difficulty(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}
