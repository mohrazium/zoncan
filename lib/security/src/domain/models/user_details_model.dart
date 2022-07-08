import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:zoncan/common/common.dart';

import '../../data/data.dart' show UserDetailsTable;

part 'user_details_model.g.dart';

abstract class UserDetailsModel
    implements Built<UserDetailsModel, UserDetailsModelBuilder> {
  int get id;
  String? get uid;
  String? get nickName;
  String get userName;
  String? get email;
  String? get phoneNumber;
  bool get isActive;
  bool get isEmailVerified;
  bool get isPhoneNumberVerified;
  String get encryptedPassword;
  DateTime? get createdAt;
  DateTime? get updatedAt;

  factory UserDetailsModel([void Function(UserDetailsModelBuilder) updates]) =
      _$UserDetailsModel;
  UserDetailsModel._();

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