part of '../database.dart';

@Entity()
@JsonSerializable()
class AuditTable {
  @Id()
  int id;
  final String? createdBy;
  final String? updatedBy;
  final String? deletedBy;
  final String? targetTable;
  final String? targetId;
  final String? title;
  final String? description;
  @Property(type: PropertyType.date)
  @JsonKey(
      fromJson: DateTimeEpochConverter.fromJsonNullable,
      toJson: DateTimeEpochConverter.toJsonNullable)
  final DateTime? createdAt;
  @Property(type: PropertyType.date)
  @JsonKey(
      fromJson: DateTimeEpochConverter.fromJsonNullable,
      toJson: DateTimeEpochConverter.toJsonNullable)
  final DateTime? updatedAt;
  @Property(type: PropertyType.date)
  @JsonKey(
      fromJson: DateTimeEpochConverter.fromJsonNullable,
      toJson: DateTimeEpochConverter.toJsonNullable)
  final DateTime? deletedAt;

  AuditTable({
    this.id = 0,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.targetTable,
    this.targetId,
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory AuditTable.fromJson(String jsonString) =>
      _$AuditTableFromJson(json.decode(jsonString));

  String toJson() => json.encode(_$AuditTableToJson(this));

  @override
  String toString() {
    return 'Auditable(createdBy: $createdBy, modifiedBy: $updatedBy, targetTable: $targetTable, targetId: $targetId,title: $title,description: $description, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  AuditTable copyWith({
    int? id,
    String? createdBy,
    String? updatedBy,
    String? deletedBy,
    String? targetTable,
    String? targetId,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return AuditTable(
      id: id ?? this.id,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      deletedBy: deletedBy ?? this.deletedBy,
      targetTable: targetTable ?? this.targetTable,
      targetId: targetId ?? this.targetId,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}
