part of 'beneficiary_cubit.dart';

/// Abstract class representing the state of beneficiary-related operations.
abstract class BeneficiaryState extends Equatable {
  const BeneficiaryState();

  @override
  List<Object> get props => [];
}

/// Initial state of the beneficiary-related operations.
class BeneficiaryInitial extends BeneficiaryState {}

/// State indicating that beneficiary-related operations are in progress.
class BeneficiaryLoading extends BeneficiaryState {}

/// State indicating that beneficiaries have been successfully loaded.
class BeneficiaryLoaded extends BeneficiaryState {
  /// List of loaded beneficiaries.
  final List<Beneficiary> beneficiaries;

  /// Constructor for `BeneficiaryLoaded` state.
  const BeneficiaryLoaded(
      this.beneficiaries,
      );

  @override
  List<Object> get props => [beneficiaries];
}

/// State indicating an error in beneficiary-related operations.
class BeneficiaryError extends BeneficiaryState {
  /// Error message describing the encountered issue.
  final String message;

  /// Constructor for `BeneficiaryError` state.
  const BeneficiaryError({required this.message});
}

