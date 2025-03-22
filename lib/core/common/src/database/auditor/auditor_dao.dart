part of '../database.dart';
enum AuditType {
  create,
  update,
  delete,
}

@DriftAccessor(tables: [AuditTable])
class AuditorDAO extends DatabaseAccessor<ZoncanDatabase> with _$AuditorDAOMixin {
  AuditorDAO(super.db);

  Future<AuditTableData> setup() {
    into(auditTable).insertOnConflictUpdate(AuditTableData(
      id: 1,
      time: DateTime.now(),
      auditBy: "SYSTEM",
      operation: "SETUP",
      descriptions: "Setup database and runnig auditor to watch user :)",
    ).toCompanion(true));

    return (select(auditTable)..where((tbl) => tbl.id.equals(1))).getSingle();
  }

  Future<AuditTableData> doInsert(AuditTableData entry) {
    return into(auditTable).insertReturning(entry.toCompanion(true));
  }

  Future<List<AuditTableData>> findAll() async {
    return (select(auditTable)..orderBy([(t) => OrderingTerm.desc(t.time)])).get();
  }
}





//
// abstract class Auditor extends Storing<int, AuditTable> {
//   late String? currentUserId;
//
//   Future<AuditTable?> findByTarget(dynamic targetTable, String targetId);
//
//   Future<AuditTable?> audit(
//       AuditType type, dynamic targetTable, String targetId);
//
//   Future<AuditTable?> findAllByUser(String userId);
// }
//
// class AuditorImpl implements Auditor {
//   late String? _currentUserId;
//
//   @override
//   set currentUserId(String? userId) {
//     _currentUserId = userId;
//   }
//
//   @override
//   String? get currentUserId => _currentUserId;
//
//   @override
//   Future<Box<AuditTable>> get storeBox async {
//     ZoncanDatabase database = Injection.serviceLocator.get<ZoncanDatabase>();
//     return await database.zoncanObjectBoxDB
//         .then((db) => db.objectBoxStore.box<AuditTable>())
//         .onError((error, stackTrace) => throw FailureException(
//               level: ExceptionLevel.ERROR,
//               type: ExceptionType.CantCREATE,
//               message: "Can't create audit box in auditor repository.",
//               error: error,
//               stackTrace: stackTrace,
//             ));
//   }
//
//   @override
//   Future<List<AuditTable?>> findAll() async {
//     return await storeBox
//         .then((box) => box.getAll())
//         .onError((error, stackTrace) => throw FailureException(
//               level: ExceptionLevel.ERROR,
//               type: ExceptionType.NotFOUND,
//               message: "Can't find all audits.",
//               error: error,
//               stackTrace: stackTrace,
//             ));
//   }
//
//   @override
//   Future<AuditTable?> findById(int id) async {
//     return await storeBox
//         .then((box) => box.get(id))
//         .onError((error, stackTrace) => throw FailureException(
//               level: ExceptionLevel.ERROR,
//               type: ExceptionType.NotFOUND,
//               message: "Can't find audit by id $id",
//               error: error,
//               stackTrace: stackTrace,
//             ));
//   }
//
//   @override
//   Future<List<AuditTable?>> findByIds(List<int> ids) async {
//     return await storeBox
//         .then((box) => box.getMany(ids))
//         .onError((error, stackTrace) => throw FailureException(
//               level: ExceptionLevel.ERROR,
//               type: ExceptionType.NotFOUND,
//               message: "Can't find audits by this id's $ids",
//               error: error,
//               stackTrace: stackTrace,
//             ));
//   }
//
//   @override
//   Future<int?> save(
//     AuditTable audit,
//   ) async {
//     return await storeBox
//         .then((box) async => await box.putAsync(audit, mode: PutMode.insert))
//         .onError((error, stackTrace) => throw FailureException(
//               level: ExceptionLevel.ERROR,
//               type: ExceptionType.CantCREATE,
//               message: "Can't save this user :${audit.toString()}",
//               error: error,
//               stackTrace: stackTrace,
//             ));
//   }
//
//   @override
//   Future<List<int>> saveAll(List<AuditTable> audits) async {
//     return await storeBox
//         .then((box) async => box.putMany(audits, mode: PutMode.insert))
//         .onError((error, stackTrace) => throw FailureException(
//               level: ExceptionLevel.ERROR,
//               type: ExceptionType.CantCREATE,
//               message: "Can't save all audits :${audits.toString()}",
//               error: error,
//               stackTrace: stackTrace,
//             ));
//   }
//
//   @override
//   Future<int> saveQueued(AuditTable audit) async {
//     return await storeBox
//         .then((box) async => box.putQueued(audit, mode: PutMode.insert))
//         .onError((error, stackTrace) => throw FailureException(
//               level: ExceptionLevel.ERROR,
//               type: ExceptionType.CantCREATE,
//               message: "Can't save audit in queue :${audit.toString()}",
//               error: error,
//               stackTrace: stackTrace,
//             ));
//   }
//
//   @override
//   Future<AuditTable?> findByTarget(dynamic targetTable, String targetId) async {
//     final String targetTableName = targetTable.runtimeType.toString();
//     return await storeBox.then((box) {
//       Query<AuditTable> query = box
//           .query(AuditTable_.targetTable
//               .equals(targetTableName)
//               .and(AuditTable_.targetId.equals(targetId)))
//           .build();
//       return query.findUnique();
//     }).onError((error, stackTrace) => throw FailureException(
//           level: ExceptionLevel.ERROR,
//           type: ExceptionType.NotFOUND,
//           message:
//               "Can't find audit by target table: $targetTableName and target id: $targetId",
//           error: error,
//           stackTrace: stackTrace,
//         ));
//   }
//
//   @override
//   Future<AuditTable?> audit(
//       AuditType type, dynamic targetTable, String targetId) async {
//     final String targetTableName = targetTable.runtimeType.toString();
//     switch (type) {
//       case AuditType.create:
//         final audit = AuditTable(
//           createdAt: DateTime.now(),
//           createdBy: currentUserId,
//           targetTable: targetTableName,
//           targetId: targetId,
//         );
//         return await save(audit).then((id) {
//           if (id != null) {
//             return findById(id);
//           } else {
//             return null;
//           }
//         });
//       case AuditType.update:
//         return findByTarget(targetTableName, targetId).then((foundedAudit) {
//           if (foundedAudit != null) {
//             final audit = foundedAudit.copyWith(
//               updatedAt: DateTime.now(),
//               updatedBy: currentUserId,
//             );
//
//             return update(audit).then((isUpdated) {
//               if (isUpdated) {
//                 return findByTarget(targetTableName, targetId);
//               } else {
//                 return null;
//               }
//             });
//           } else {
//             return null;
//           }
//         });
//       case AuditType.delete:
//         return findByTarget(targetTableName, targetId).then((foundedAudit) {
//           if (foundedAudit != null) {
//             final audit = foundedAudit.copyWith(
//               deletedAt: DateTime.now(),
//               deletedBy: currentUserId,
//             );
//
//             return update(audit).then((isUpdated) {
//               if (isUpdated) {
//                 return findByTarget(targetTableName, targetId);
//               } else {
//                 return null;
//               }
//             });
//           } else {
//             return null;
//           }
//         });
//     }
//   }
//
//   @override
//   Future<AuditTable?> findAllByUser(String userId) async {
//     return await storeBox.then((box) {
//       Query<AuditTable> query = box
//           .query(AuditTable_.createdBy.equals(userId).or(AuditTable_.updatedBy
//               .equals(userId)
//               .or(AuditTable_.deletedBy.equals(userId))))
//           .build();
//       return query.findUnique();
//     }).onError((error, stackTrace) => throw FailureException(
//           level: ExceptionLevel.ERROR,
//           type: ExceptionType.NotFOUND,
//           message: "Can't find audit by user id: $userId",
//           error: error,
//           stackTrace: stackTrace,
//         ));
//   }
//
//   @protected
//   @override
//   Future<bool> update(AuditTable audit) async {
//     return await storeBox
//         .then((box) async => await box.putAsync(audit, mode: PutMode.update))
//         .then((updatedUserId) async {
//       return updatedUserId == audit.id
//           ? true
//           : throw FailureException(
//               level: ExceptionLevel.ERROR,
//               type: ExceptionType.CantUPDATE,
//               message: "Can't update this audit :${audit.toString()}",
//             );
//     }).onError((error, stackTrace) => throw FailureException(
//               level: ExceptionLevel.ERROR,
//               type: ExceptionType.CantUPDATE,
//               message: "Can't update user in queue :${audit.toString()}",
//               error: error,
//               stackTrace: stackTrace,
//             ));
//   }
//
//   @protected
//   @override
//   Future<bool> delete(AuditTable audit) async {
//     return false;
//   }
//
//   @protected
//   @override
//   Future<int> deleteAll() async {
//     return 0;
//   }
// }
