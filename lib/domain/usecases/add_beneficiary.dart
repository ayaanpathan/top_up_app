import 'package:top_up_app/domain/entities/beneficiary.dart';
import 'package:top_up_app/domain/repositories/beneficiary_repository.dart';

/// Use case for adding a beneficiary.
class AddBeneficiary {
  /// The repository for managing beneficiaries.
  final BeneficiaryRepository repository;

  /// Constructor for `AddBeneficiary` use case.
  ///
  /// [repository] - The repository instance used to manage beneficiaries.
  AddBeneficiary(this.repository);

  /// Calls the repository to add a new beneficiary.
  ///
  /// [beneficiary] - The beneficiary to be added.
  Future<void> call(Beneficiary beneficiary) async {
    return await repository.addBeneficiary(beneficiary);
  }
}
