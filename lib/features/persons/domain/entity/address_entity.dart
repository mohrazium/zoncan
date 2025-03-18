part of '../domain.dart';

abstract class AddressEntity {
  int id;
  String? uid;
  String? postalCode;
  String? province;
  String? county;
  String? city;
  String? blv;
  String fullAddress;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  AddressEntity({
    required this.id,
    this.uid,
    this.postalCode,
    this.province,
    this.county,
    this.city,
    this.blv,
    required this.fullAddress,
    this.description,
    this.createdAt,
    this.updatedAt,
  });
}
