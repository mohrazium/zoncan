part of '../data.dart';

typedef AddressMapper = AddressModelMapper;

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

  factory AddressModel.fromTable(AddressTable table) {
    return AddressModel(
      id: table.id,
      uid: table.uid,
      postalCode: table.postalCode,
      province: table.province,
      county: table.county,
      city: table.city,
      blv: table.blv,
      fullAddress: table.fullAddress,
      description: table.description,
      createdAt: table.createdAt,
      updatedAt: table.updatedAt,
    );
  }

  AddressTable toTable() {
    return AddressTable(
      id: this.id,
      uid: this.uid,
      postalCode: this.postalCode,
      province: this.province,
      county: this.county,
      city: this.city,
      blv: this.blv,
      fullAddress: this.fullAddress,
      description: this.description,
      createdAt: this.createdAt,
      updatedAt: this.updatedAt,
    );
  }
}
