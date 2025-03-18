// ignore_for_file: overridden_fields

part of '../../data.dart';

@Entity()
@JsonSerializable()
class AddressTable {
  @Id()
  int id;
  @Unique()
  String? uid;
  String? postalCode;
  String? province;
  String? county;
  String? city;
  String? blv;
  String fullAddress;
  String? description;
  @Property(type: PropertyType.date)
  @JsonKey(
      fromJson: DateTimeEpochConverter.fromJsonNullable,
      toJson: DateTimeEpochConverter.toJsonNullable)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  @JsonKey(
      fromJson: DateTimeEpochConverter.fromJsonNullable,
      toJson: DateTimeEpochConverter.toJsonNullable)
  DateTime? updatedAt;

  AddressTable({
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

  factory AddressTable.fromJson(String jsonString) =>
      _$AddressTableFromJson(json.decode(jsonString));

  String toJson() => json.encode(_$AddressTableToJson(this));
}
