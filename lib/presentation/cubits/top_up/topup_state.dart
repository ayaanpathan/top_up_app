part of 'topup_cubit.dart';

abstract class TopupState extends Equatable {
  const TopupState();

  @override
  List<Object> get props => [];
}

class TopupInitial extends TopupState {}

class TopupSuccess extends TopupState {
  final double remainingBalance;

  const TopupSuccess(this.remainingBalance);

  @override
  List<Object> get props => [remainingBalance];
}

class TopupFailure extends TopupState {
  final String error;

  const TopupFailure(this.error);

  @override
  List<Object> get props => [error];
}

class TopupFailureMonthlyLimit extends TopupState {
  final String error;

  const TopupFailureMonthlyLimit(this.error);

  @override
  List<Object> get props => [error];
}
