// import 'package:drift/drift.dart';

// class AccountsTable extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   IntColumn get userId => integer()();
//   // TextColumn get accountType => text().check(isIn(['بانکی', 'نقدی', 'کارت اعتباری', 'سایر']))();
//   TextColumn get name => text()();
//   TextColumn get currency => text().withDefault(const Constant('IRT'))();
//   RealColumn get balance => real().withDefault(const Constant(0.0))();
//   TextColumn get description => text().nullable()();
//   IntColumn get createdAt => integer().clientDefault(() => DateTime.now().millisecondsSinceEpoch ~/ 1000)();
//   IntColumn get updatedAt => integer().nullable().clientDefault(() => DateTime.now().millisecondsSinceEpoch ~/ 1000)();

//   @override
//   Set<Column> get primaryKey => {id};
// }

// class CategoriesTable extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   IntColumn get userId => integer()();
//   // TextColumn get categoryType => text().check(isIn(['درآمد', 'هزینه']))();
//   TextColumn get name => text()();
//   TextColumn get description => text().nullable()();
//   IntColumn get createdAt => integer().clientDefault(() => DateTime.now().millisecondsSinceEpoch ~/ 1000)();
//   IntColumn get updatedAt => integer().nullable().clientDefault(() => DateTime.now().millisecondsSinceEpoch ~/ 1000)();

//   @override
//   Set<Column> get primaryKey => {id};
// }

// class TransactionsTable extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   IntColumn get userId => integer()();
//   IntColumn get accountId => integer().references(AccountsTable, #id)();
//   IntColumn get categoryId => integer().references(CategoriesTable, #id)();
//   // TextColumn get transactionType => text().check(isIn(['درآمد', 'هزینه', 'انتقال']))();
//   RealColumn get amount => real()();
//   IntColumn get transactionDate => integer()(); // Store as timestamp
//   TextColumn get description => text().nullable()();
//   TextColumn get paymentMethod => text().nullable()();
//   TextColumn get referenceNumber => text().nullable()();
//   TextColumn get attachmentPath => text().nullable()();
//   IntColumn get transferToAccountId => integer().nullable().references(AccountsTable, #id)();
//   IntColumn get createdAt => integer().clientDefault(() => DateTime.now().millisecondsSinceEpoch ~/ 1000)();
//   IntColumn get updatedAt => integer().nullable().clientDefault(() => DateTime.now().millisecondsSinceEpoch ~/ 1000)();

//   @override
//   Set<Column> get primaryKey => {id};
// }

// class BusinessesTable extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   IntColumn get userId => integer()();
//   TextColumn get name => text()();
//   TextColumn get businessType => text().nullable()();
//   TextColumn get nationalId => text().nullable()();
//   TextColumn get registrationNumber => text().nullable()();
//   TextColumn get address => text().nullable()();
//   TextColumn get phoneNumber => text().nullable()();
//   TextColumn get email => text().nullable()();
//   TextColumn get website => text().nullable()();
//   TextColumn get logoPath => text().nullable()();
//   IntColumn get createdAt => integer().clientDefault(() => DateTime.now().millisecondsSinceEpoch ~/ 1000)();
//   IntColumn get updatedAt => integer().nullable().clientDefault(() => DateTime.now().millisecondsSinceEpoch ~/ 1000)();

//   @override
//   Set<Column> get primaryKey => {id};
// }

// class ContactsTable extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   IntColumn get userId => integer()();
//   IntColumn get businessId => integer().nullable().references(BusinessesTable, #id)();
//   // TextColumn get contactType => text().check(isIn(['مشتری', 'تامین کننده', 'سایر']))();
//   TextColumn get name => text()();
//   TextColumn get phoneNumber => text().nullable()();
//   TextColumn get email => text().nullable()();
//   TextColumn get address => text().nullable()();
//   TextColumn get description => text().nullable()();
//   IntColumn get createdAt => integer().clientDefault(() => DateTime.now().millisecondsSinceEpoch ~/ 1000)();
//   IntColumn get updatedAt => integer().nullable().clientDefault(() => DateTime.now().millisecondsSinceEpoch ~/ 1000)();

//   @override
//   Set<Column> get primaryKey => {id};
// }

// class InvoicesTable extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   IntColumn get userId => integer()();
//   IntColumn get businessId => integer().nullable().references(BusinessesTable, #id)();
//   IntColumn get contactId => integer().references(ContactsTable, #id)();
//   TextColumn get invoiceNumber => text()();
//   IntColumn get invoiceDate => integer()(); // Store as timestamp
//   // IntColumn get dueDate => integer().nullable(); // Store as timestamp
//   RealColumn get totalAmount => real()();
//   RealColumn get discount => real().withDefault(const Constant(0.0))();
//   RealColumn get taxAmount => real().withDefault(const Constant(0.0))();
//   TextColumn get description => text().nullable()();
//   // TextColumn get invoiceStatus => text().check(isIn(['پیش نویس', 'پرداخت نشده', 'پرداخت شده', 'باطل شده']))();
//   IntColumn get createdAt => integer().clientDefault(() => DateTime.now().millisecondsSinceEpoch ~/ 1000)();
//   IntColumn get updatedAt => integer().nullable().clientDefault(() => DateTime.now().millisecondsSinceEpoch ~/ 1000)();

//   @override
//   Set<Column> get primaryKey => {id};
// }

// class InvoiceItemsTable extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   IntColumn get invoiceId => integer().references(InvoicesTable, #id)();
//   TextColumn get itemName => text()();
//   RealColumn get quantity => real()();
//   RealColumn get unitPrice => real()();
//   RealColumn get totalPrice => real()();
//   TextColumn get description => text().nullable()();

//   @override
//   Set<Column> get primaryKey => {id};
// }

// class InventoryUnitsTable extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   IntColumn get userId => integer()();
//   IntColumn get businessId => integer().nullable().references(BusinessesTable, #id)();
//   TextColumn get name => text()();
//   TextColumn get abbreviation => text().nullable()();
//   IntColumn get createdAt => integer().clientDefault(() => DateTime.now().millisecondsSinceEpoch ~/ 1000)();
//   IntColumn get updatedAt => integer().nullable().clientDefault(() => DateTime.now().millisecondsSinceEpoch ~/ 1000)();

//   @override
//   Set<Column> get primaryKey => {id};
// }

// class InventoryItemsTable extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   IntColumn get userId => integer()();
//   IntColumn get businessId => integer().nullable().references(BusinessesTable, #id)();
//   TextColumn get name => text()();
//   TextColumn get code => text().nullable().unique()();
//   IntColumn get unitId => integer().nullable().references(InventoryUnitsTable, #id)();
//   IntColumn get reorderLevel => integer().nullable()();
//   TextColumn get description => text().nullable()();
//   IntColumn get createdAt => integer().clientDefault(() => DateTime.now().millisecondsSinceEpoch ~/ 1000)();
//   IntColumn get updatedAt => integer().nullable().clientDefault(() => DateTime.now().millisecondsSinceEpoch ~/ 1000)();

//   @override
//   Set<Column> get primaryKey => {id};
// }

// class InventoryTransactionsTable extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   IntColumn get inventoryItemId => integer().references(InventoryItemsTable, #id)();
//   // TextColumn get transactionType => text().check(isIn(['ورود', 'خروج']))();
//   RealColumn get quantity => real()();
//   IntColumn get transactionDate => integer()(); // Store as timestamp
//   TextColumn get referenceDocument => text().nullable()();
//   TextColumn get description => text().nullable()();
//   IntColumn get createdAt => integer().clientDefault(() => DateTime.now().millisecondsSinceEpoch ~/ 1000)();

//   @override
//   Set<Column> get primaryKey => {id};
// }

// class AuditsTable extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   IntColumn get userId => integer()(); // Foreign key to your users table (if you have one in Drift)
//   // TextColumn get tableName => text()();
//   IntColumn get recordId => integer()();
//   // TextColumn get operationType => text().check(isIn(['CREATE', 'UPDATE', 'DELETE']))();
//   TextColumn get oldValues => text().nullable()();
//   TextColumn get newValues => text().nullable()();
//   TextColumn get changedFields => text().nullable()();
//   IntColumn get auditTimestamp => integer().clientDefault(() => DateTime.now().millisecondsSinceEpoch ~/ 1000)();

//   @override
//   Set<Column> get primaryKey => {id};
// }