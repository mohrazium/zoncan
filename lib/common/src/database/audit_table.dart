import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

import 'package:zoncan/common/common.dart' show DateTimeEpochConverter;

part 'audit_table.g.dart';

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
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory AuditTable.fromJson(String jsonString) =>
      _$AuditTableFromJson(json.decode(jsonString));

  String toJson() => json.encode(_$AuditTableToJson(this));

  @override
  String toString() {
    return 'Auditable(createdBy: $createdBy, modifiedBy: $updatedBy, targetTable: $targetTable, targetId: $targetId, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  AuditTable copyWith({
    int? id,
    String? createdBy,
    String? updatedBy,
    String? deletedBy,
    String? targetTable,
    String? targetId,
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
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}
