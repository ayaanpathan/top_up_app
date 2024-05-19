part of 'user_cubit.dart';

/// Represents the different states of the user-related operations.
abstract class UserState {}

/// Initial state when the user state is not yet initialized.
class UserInitial extends UserState {}

/// State indicating that user data is being loaded.
class UserLoading extends UserState {}

/// State indicating that user data has been successfully loaded.
class UserLoaded extends UserState {
  /// Instance of the loaded user.
  final User user;

  /// Constructs a [UserLoaded] state with the provided user data.
  UserLoaded(this.user);
}

/// State indicating that user balance has been updated.
class UserBalanceUpdate extends UserState {
  /// Instance of the updated user.
  final User user;

  /// Constructs a [UserBalanceUpdate] state with the updated user data.
  UserBalanceUpdate(this.user);
}

/// State indicating an error occurred during user-related operations.
class UserError extends UserState {
  /// Error message describing the encountered issue.
  final String message;

  /// Constructs a [UserError] state with the provided error message.
  UserError(this.message);
}

