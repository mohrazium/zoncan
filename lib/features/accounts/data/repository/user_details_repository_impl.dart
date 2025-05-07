

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import 'package:zoncan/config/config.dart' show TranslationsProvider;
import 'package:zoncan/core/exceptions/exceptions.dart';
import 'package:zoncan/features/accounts/data/datasource/local/tables/user_details_table.dart';

import '../../domain/repository/user_details_repository.dart';
import '../datasource/local/daos/user_details_dao.dart';
import '../models/user_details_model.dart';

@Injectable(as: UserDetailsRepository)
class UserDetailsRepositoryImpl implements UserDetailsRepository {
  final UserDetailsDao _userDetailsDao;
  UserDetailsRepositoryImpl(this._userDetailsDao);

  @override
  Future<Either<FailureException, UserDetailsModel>> saveUser(
    UserDetailsModel user,
  ) async {
    try {
      if (user.uid == null) {
        user = user.copyWith(uid: const Uuid().v4());
      }

      if (user.userName.isEmpty) {
        user = user.copyWith(userName: user.email);
      }

      UserDetailsModel? savedUser = await _userDetailsDao
          .insert(user.toEntity().toData())
          .then(
            (savedUser) => UserDetailsModel.fromEntity(savedUser!.toEntity()),
          );
      if (savedUser != null) {
        return Right(savedUser);
      } else {
        return Left(FailureException(userMessage: TranslationsProvider.translator.accounts.userNotSaved));
      }
    } on Error catch (e) {
      return Left(
        FailureException(
          level: LogLevel.ERROR,
          type: ExceptionType.CantCREATE,
          message: "Can't save this user :${user.toString()}",
          userMessage: TranslationsProvider.translator.accounts.userNotSaved,
          error: e,
          stackTrace: e.stackTrace,
        ),
      );
    }
  }

  @override
  Future<Either<FailureException, List<UserDetailsModel>>>
  findAllUsers() async {
    try {
      List<UserDetailsModel> users = List.empty();
      await _userDetailsDao.getAllUser.then((res) {
        for (final user in res) {
          if (user != null) {
            users.add(UserDetailsModel.fromEntity(user.toEntity()));
          }
        }
      });
      return Right(users);
    } catch (e, stackTrace) {
      return Left(
        FailureException(
          level: LogLevel.ERROR,
          type: ExceptionType.CantDELETE,
          error: e,
          stackTrace: stackTrace,
          message: "Can't retrive users from db",
          userMessage: "بارگذاری کاربران امکان پذیرنیست",
        ),
      );
    }
  }

  @override
  Future<Either<FailureException, UserDetailsModel>> findUserByEmail(
    String email,
  ) async {
    try {
      final foundedUser = await _userDetailsDao.getUserByEmail(email);
      if (foundedUser == null) {
        return Left(
          FailureException(
            level: LogLevel.ERROR,
            type: ExceptionType.CantCREATE,
            message:
                "Can't find this user by username or email address :$email",
            userMessage: "کاربری بااین ایمیل یافت نشد!",
          ),
        );
      } else {
        return Right(UserDetailsModel.fromEntity(foundedUser.toEntity()));
      }
    } on Error catch (e) {
      return Left(
        FailureException(
          level: LogLevel.ERROR,
          type: ExceptionType.CantCREATE,
          message: "Finding user by :$email faild. check the error",
          userMessage:
              ".کاربر یافت نشد! مشکلی درعملیات یافتن کاربر پیش امده است",
          error: e,
          stackTrace: e.stackTrace,
        ),
      );
    }
  }

  @override
  Future<Either<FailureException, UserDetailsModel>> findUser(
    String uuid,
  ) async {
    try {
      final user = await _userDetailsDao.getUser(uuid);
      if (user != null) {
        return Right(UserDetailsModel.fromEntity(user.toEntity()));
      } else {
        return Left(
          FailureException(
            level: LogLevel.INFO,
            type: ExceptionType.NONE,
            userMessage: "متاسفانه کاربر یافت نشد",
          ),
        );
      }
    } catch (e, stackTrace) {
      return Left(
        FailureException(
          level: LogLevel.ERROR,
          type: ExceptionType.CantDELETE,
          error: e,
          stackTrace: stackTrace,
          message: "Can't find this user by uid:$uuid",
          userMessage: "خطا در پیدا کردن کاربر!",
        ),
      );
    }
  }

  @override
  Future<Either<FailureException, UserDetailsModel>> findUserByUsername(
    String username,
  ) async {
    try {
      final user = await _userDetailsDao.getUserByUsername(username);
      if (user != null) {
        return Right(UserDetailsModel.fromEntity(user.toEntity()));
      } else {
        return Left(
          FailureException(
            level: LogLevel.INFO,
            type: ExceptionType.NONE,
            userMessage: "کاربری بااین نام کاربری یافت نشد!",
          ),
        );
      }
    } on Error catch (e) {
      return Left(
        FailureException(
          level: LogLevel.ERROR,
          type: ExceptionType.CantCREATE,
          message: "Finding user by :$username faild. check the error",
          userMessage:
              ".کاربر یافت نشد! مشکلی درعملیات یافتن کاربر پیش امده است",
          error: e,
          stackTrace: e.stackTrace,
        ),
      );
    }
  }

  @override
  Future<Either<FailureException, UserDetailsModel>> updateUser(
    UserDetailsModel model,
  ) async {
    try {
      final user = await _userDetailsDao.updateUser(model.toEntity().toData());
      if (user != null) {
        return Right(UserDetailsModel.fromEntity(user.toEntity()));
      } else {
        return Left(
          FailureException(
            level: LogLevel.INFO,
            type: ExceptionType.NONE,
            userMessage: "اطلاعات کاربر بروز نشد",
          ),
        );
      }
    } on Error catch (e) {
      return Left(
        FailureException(
          level: LogLevel.ERROR,
          type: ExceptionType.CantCREATE,
          message:
              "Updating user by :${model.toString()} faild. check the error",
          userMessage:
              ".کاربر یافت نشد! مشکلی درعملیات بروزرسانی کاربر پیش امده است",
          error: e,
          stackTrace: e.stackTrace,
        ),
      );
    }
  }

  @override
  Future<Either<FailureException, bool>> userExist(
    String usernameOrEmail,
  ) async {
    try {
      final userByEmail = await _userDetailsDao.getUserByEmail(usernameOrEmail);
      final userByUsername = await _userDetailsDao.getUserByUsername(
        usernameOrEmail,
      );
      if (userByEmail != null || userByUsername != null) {
        return const Right(true);
      } else {
        return const Right(false);
      }
    } on Error catch (e) {
      return Left(
        FailureException(
          level: LogLevel.ERROR,
          type: ExceptionType.NotFOUND,
          message: "Finding user by :$usernameOrEmail faild. check the error",
          userMessage:
              ".کاربر یافت نشد! مشکلی درعملیات جستجوی کاربر پیش امده است",
          error: e,
          stackTrace: e.stackTrace,
        ),
      );
    }
  }

  @override
  Future<Either<FailureException, bool>> removeUser(
    UserDetailsModel entity,
  ) async {
    try {
      return await _userDetailsDao
          .deleteUser(entity.toEntity().toData())
          .then((res) => Right(res));
    } catch (e, stackTrace) {
      return Left(
        FailureException(
          level: LogLevel.ERROR,
          type: ExceptionType.CantDELETE,
          error: e,
          stackTrace: stackTrace,
          message: "Can't find this user by uid:${entity.uid}",
          userMessage: "خطا در حذف کاربر!",
        ),
      );
    }
  }
}