part of 'user_cubit.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final User user;

  UserLoaded(this.user);
}

class UserBalanceUpdate extends UserState {
  final User user;

  UserBalanceUpdate(this.user);
}

class UserError extends UserState {
  final String message;

  UserError(this.message);
}
