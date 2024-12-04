class UserModel {
  final String id;

  UserModel({required this.id});

  UserModel copyWith({String? id}) => UserModel(
        id: id ?? this.id,
      );
}
