
import 'package:fpdart/fpdart.dart';
import 'package:zoncan/core/exceptions/exceptions.dart';

abstract class Usecase <Type,Params>{
  Future<Either<FailureException,Type>> call({required Params params});
}