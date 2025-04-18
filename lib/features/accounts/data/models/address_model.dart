part of '../data.dart';

typedef AddressMapper = AddressModelMapper;

@MappableClass(
    generateMethods: GenerateMethods.copy |
    GenerateMethods.equals |
    GenerateMethods.stringify |
    GenerateMethods.decode |
    GenerateMethods.encode)
class AddressModel with AddressModelMappable {
  final String? uid;
  final String? postalCode;
  final String? province;
  final String? county;
  final String? city;
  final String? blv;
  final String fullAddress;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AddressModel({
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

  factory AddressModel.init() => AddressModel(fullAddress: "");

  factory AddressModel.fromEntity(AddressEntity entity) => AddressModel(
        uid: entity.uid,
        postalCode: entity.postalCode,
        province: entity.province,
        county: entity.county,
        city: entity.city,
        blv: entity.blv,
        fullAddress: entity.fullAddress,
        description: entity.description,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );

AddressEntity toEntity() => AddressEntity(
      uid: uid,
      postalCode: postalCode,
      province: province,
      county: county,
      city: city,
      blv: blv,
      fullAddress: fullAddress,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
}
