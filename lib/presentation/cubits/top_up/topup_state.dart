part of 'topup_cubit.dart';
/// State classes for managing the state of top-up operations.
abstract class TopupState extends Equatable {
  const TopupState();

  @override
  List<Object> get props => [];
}

/// Initial state of the top-up operation.
class TopupInitial extends TopupState {}

/// State indicating that the top-up operation is in progress.
class TopupLoading extends TopupState {}

/// State indicating that the top-up operation was successful.
class TopupSuccess extends TopupState {
  /// Remaining balance after the top-up.
  final double remainingBalance;

  /// Constructor for `TopupSuccess`.
  const TopupSuccess(this.remainingBalance);

  @override
  List<Object> get props => [remainingBalance];
}

/// State indicating that the top-up operation failed.
class TopupFailure extends TopupState {
  /// Error message describing the reason for failure.
  final String error;

  /// Constructor for `TopupFailure`.
  const TopupFailure(this.error);

  @override
  List<Object> get props => [error];
}

/// State indicating that the top-up operation failed due to exceeding the monthly limit.
class TopupFailureMonthlyLimit extends TopupState {
  /// Error message describing the reason for failure.
  final String error;

  /// Constructor for `TopupFailureMonthlyLimit`.
  const TopupFailureMonthlyLimit(this.error);

  @override
  List<Object> get props => [error];
}
