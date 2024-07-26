part of 'generics.dart';

abstract class Usecase <Type,Params>{
  Future<Either<FailureException,Type>> call({required Params params});
}