import 'dart:convert';

class UserResponseModel {
  UserResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool success;
  final String message;
  final UserModel data;

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      UserResponseModel(
        success: json["success"],
        message: json["message"],
        data: UserModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class UserModel {
  UserModel({
    required this.name,
    required this.lastname,
    required this.email,
    required this.role,
    required this.favourites,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  final String name;
  final String lastname;
  final String email;
  final List<Role> role;
  final List<Favourite> favourites;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;

  UserModel copyWith({
    String? name,
    String? lastname,
    String? email,
    List<Role>? role,
    List<Favourite>? favourites,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
  }) =>
      UserModel(
        name: name ?? this.name,
        lastname: lastname ?? this.lastname,
        email: email ?? this.email,
        role: role ?? this.role,
        favourites: favourites ?? this.favourites,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        id: id ?? this.id,
      );

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        role: List<Role>.from(json["role"].map((x) => Role.fromJson(x))),
        favourites: List<Favourite>.from(
            json["favourites"].map((x) => Favourite.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lastname": lastname,
        "email": email,
        "role": List<dynamic>.from(role.map((x) => x.toJson())),
        "favourites": List<dynamic>.from(favourites.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
      };
}

class Favourite {
  Favourite({
    required this.image,
    required this.name,
    required this.portions,
    required this.preparationTime,
    required this.difficulty,
    required this.type,
    required this.id,
  });

  final FavouriteRecipeImage image;
  final String name;
  final int portions;
  final int preparationTime;
  final Difficulty difficulty;
  final Type type;
  final String id;

  factory Favourite.fromJson(Map<String, dynamic> json) => Favourite(
        image: FavouriteRecipeImage.fromJson(json["image"]),
        name: json["name"],
        portions: json["portions"],
        preparationTime: json["preparationTime"],
        difficulty: Difficulty.fromJson(json["difficulty"]),
        type: Type.fromJson(json["type"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "image": image.toJson(),
        "name": name,
        "portions": portions,
        "preparationTime": preparationTime,
        "difficulty": difficulty.toJson(),
        "type": type,
        "id": id,
      };
}

class FavouriteRecipeImage {
  FavouriteRecipeImage({
    required this.pathFolder,
    required this.images,
  });

  final String pathFolder;
  final List<String> images;

  FavouriteRecipeImage copyWith({
    String? pathFolder,
    List<String>? images,
  }) =>
      FavouriteRecipeImage(
        pathFolder: pathFolder ?? this.pathFolder,
        images: images ?? this.images,
      );

  factory FavouriteRecipeImage.fromJson(Map<String, dynamic> json) =>
      FavouriteRecipeImage(
        pathFolder: json["path_folder"],
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "path_folder": pathFolder,
        "images": List<dynamic>.from(images.map((x) => x)),
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

class Role {
  Role({
    required this.roleName,
    required this.id,
  });

  final String roleName;
  final String id;

  Role copyWith({
    String? roleName,
    String? id,
  }) =>
      Role(
        roleName: roleName ?? this.roleName,
        id: id ?? this.id,
      );

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        roleName: json["roleName"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "roleName": roleName,
        "id": id,
      };
}

class Difficulty {
  Difficulty({
    required this.name,
  });

  final String name;

  factory Difficulty.fromJson(Map<String, dynamic> json) => Difficulty(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
