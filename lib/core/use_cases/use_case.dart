import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ricky_mobile/core/error/failure.dart';

class NoParams extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class Params extends Equatable {
  const Params() : super();

  @override
  List<Object?> get props => [];
}

abstract class UseCase<Type, T> {
  Future<Either<Failure, Type>> call(T params);
}
