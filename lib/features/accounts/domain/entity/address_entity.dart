
class AddressEntity {
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

  AddressEntity({
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
