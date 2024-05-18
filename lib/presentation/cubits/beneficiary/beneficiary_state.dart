part of 'beneficiary_cubit.dart';

abstract class BeneficiaryState extends Equatable {
  const BeneficiaryState();

  @override
  List<Object> get props => [];
}

class BeneficiaryInitial extends BeneficiaryState {}

class BeneficiaryLoading extends BeneficiaryState {}

class BeneficiaryLoaded extends BeneficiaryState {
  final List<Beneficiary> beneficiaries;
  final double balance;

  const BeneficiaryLoaded(
    this.beneficiaries,
    this.balance,
  );

  @override
  List<Object> get props => [beneficiaries];
}

class BeneficiaryError extends BeneficiaryState {}
