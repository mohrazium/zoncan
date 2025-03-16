// ignore_for_file: overridden_fields

part of '../../data.dart';

@Entity()
@JsonSerializable()
class AddressTable extends AddressEntity {
  @override
  @Id()
   int id;
  @override
  @Unique()
  final String? uid;
  @override
  final String? postalCode;
  @override
  final String? province;
  @override
  final String? county;
  @override
  final String? city;
  @override
  final String? blv;
  @override
  final String fullAddress;
  @override
  final String? description;
  @override
  @Property(type: PropertyType.date)
  @JsonKey(
      fromJson: DateTimeEpochConverter.fromJsonNullable,
      toJson: DateTimeEpochConverter.toJsonNullable)
  final DateTime? createdAt;
  @override
  @Property(type: PropertyType.date)
  @JsonKey(
      fromJson: DateTimeEpochConverter.fromJsonNullable,
      toJson: DateTimeEpochConverter.toJsonNullable)
  final DateTime? updatedAt;

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
  }) : super(
          id: id,
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

  factory AddressTable.fromJson(String jsonString) =>
      _$AddressTableJson(json.decode(jsonString));

  String toJson() => json.encode(_$AddressTableToJson(this));
}
