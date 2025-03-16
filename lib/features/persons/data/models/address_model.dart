part of '../data.dart';

@MappableClass(
    generateMethods: GenerateMethods.copy |
        GenerateMethods.equals |
        GenerateMethods.stringify |
        GenerateMethods.decode |
        GenerateMethods.encode)
class AddressModel extends AddressEntity with AddressModelMappable {
  AddressModel(
      {required super.id,
      super.uid,
      super.postalCode,
      super.province,
      super.county,
      super.city,
      super.blv,
      required super.fullAddress,
      super.description,
      super.createdAt,
      super.updatedAt});

  factory AddressModel.init() => AddressModel(id: 0, fullAddress: "");

  factory AddressModel.fromTable(AddressTable table) =>
      AddressModel.fromJson(table.toJson());

  AddressTable toTable() => PersonTable.fromJson(toJson());
}
