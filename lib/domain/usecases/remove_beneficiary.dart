import 'package:top_up_app/domain/repositories/beneficiary_repository.dart';

/// Use case for removing a beneficiary.
class RemoveBeneficiary {
  /// The repository for managing beneficiaries.
  final BeneficiaryRepository repository;

  /// Constructor for `RemoveBeneficiary` use case.
  ///
  /// [repository] - The repository instance used to manage beneficiaries.
  RemoveBeneficiary(this.repository);

  /// Calls the repository to remove a beneficiary by their ID.
  ///
  /// [id] - The unique identifier of the beneficiary to be removed.
  Future<void> call(String id) async {
    return await repository.removeBeneficiary(id);
  }
}
