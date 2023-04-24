class CommentResponseModel {
  CommentResponseModel({
    required this.success,
    required this.message,
    required this.page,
    required this.nextPage,
    required this.prevPage,
    required this.totalPages,
    required this.totalItems,
    required this.hasPrevPage,
    required this.hasNextPage,
    required this.data,
  });

  final bool success;
  final String message;
  final int page;
  final int nextPage;
  final int prevPage;
  final int totalPages;
  final int totalItems;
  final bool hasPrevPage;
  final bool hasNextPage;
  final List<CommentModel> data;

  factory CommentResponseModel.fromJson(Map<String, dynamic> json) =>
      CommentResponseModel(
        success: json["success"],
        message: json["message"],
        page: json["page"],
        nextPage: json["nextPage"],
        prevPage: json["prevPage"],
        totalPages: json["totalPages"],
        totalItems: json["total_items"],
        hasPrevPage: json["hasPrevPage"],
        hasNextPage: json["hasNextPage"],
        data: List<CommentModel>.from(
            json["data"].map((x) => CommentModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "page": page,
        "nextPage": nextPage,
        "prevPage": prevPage,
        "totalPages": totalPages,
        "total_items": totalItems,
        "hasPrevPage": hasPrevPage,
        "hasNextPage": hasNextPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CommentModel {
  CommentModel({
    required this.id,
    required this.user,
    required this.recipe,
    required this.message,
    required this.image,
    required this.date,
    required this.datumId,
  });

  final String id;
  final User user;
  final String recipe;
  final String message;
  final Image image;
  final DateTime date;
  final String datumId;

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json["_id"],
        user: User.fromJson(json["user"]),
        recipe: json["recipe"],
        message: json["message"],
        image: Image.fromJson(json["image"]),
        date: DateTime.parse(json["date"]),
        datumId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user.toJson(),
        "recipe": recipe,
        "message": message,
        "image": image.toJson(),
        "date": date.toIso8601String(),
        "id": datumId,
      };
}

class Image {
  Image({
    this.pathFolder,
    required this.images,
  });

  final String? pathFolder;
  final List<String> images;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        pathFolder: json["path_folder"],
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "path_folder": pathFolder,
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.lastname,
  });

  final String id;
  final String name;
  final String lastname;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        lastname: json["lastname"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "lastname": lastname,
      };
}
