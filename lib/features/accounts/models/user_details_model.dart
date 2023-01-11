part of zoncan.features.accounts.models;

abstract class UserDetailsModel
    implements Built<UserDetailsModel, UserDetailsModelBuilder> {
  int get id;
  String? get uid;
  String? get nickName;
  String get userName;
  String? get email;
  String? get phoneNumber;
  bool get isActive;
  bool get isAuthenticated;
  bool get isEmailVerified;
  bool get isPhoneNumberVerified;
  String? get encryptedPassword;
  DateTime? get expirationDate;
  DateTime? get createdAt;
  DateTime? get updatedAt;

  factory UserDetailsModel({
    int? id,
    String? uid,
    String? nickName,
    required String userName,
    String? email,
    String? phoneNumber,
    bool? isActive,
    bool? isAuthenticated,
    bool? isEmailVerified,
    bool? isPhoneNumberVerified,
    String? encryptedPassword,
    DateTime? expirationDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      UserDetailsModel.builder(
        (b) => b
          ..id = id ?? 0
          ..uid = uid ?? const Uuid().v4().toString()
          ..nickName = nickName
          ..userName = userName
          ..email = email
          ..phoneNumber = phoneNumber
          ..isActive = isActive ?? false
          ..isAuthenticated = isAuthenticated ?? false
          ..isEmailVerified = isEmailVerified ?? false
          ..isPhoneNumberVerified = isPhoneNumberVerified ?? false
          ..encryptedPassword = encryptedPassword
          ..expirationDate =
              (expirationDate ?? DateTime.now().add(const Duration(days: 365)))
                  .toUtc()
          ..createdAt = (createdAt ?? DateTime.now()).toUtc()
          ..updatedAt = (updatedAt)?.toUtc(),
      );

  factory UserDetailsModel.builder(
      [void Function(UserDetailsModelBuilder) updates]) = _$UserDetailsModel;

  UserDetailsModel._();

  factory UserDetailsModel.init() => UserDetailsModel(userName: "");

  static Serializer<UserDetailsModel> get serializer =>
      _$userDetailsModelSerializer;

  String toJson() => json.encode(ModelSerializer.standardSerializers
      .serializeWith(UserDetailsModel.serializer, this));

  factory UserDetailsModel.fromJson(String jsonString) =>
      ModelSerializer.standardSerializers.deserializeWith(
          UserDetailsModel.serializer, json.decode(jsonString)) ??
      _$UserDetailsModel();

  factory UserDetailsModel.fromTable(UserDetailsTable table) =>
      UserDetailsModel.fromJson(table.toJson());

  UserDetailsTable toTable() => UserDetailsTable.fromJson(toJson());
}
