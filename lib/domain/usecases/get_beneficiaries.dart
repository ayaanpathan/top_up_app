import 'package:top_up_app/domain/entities/beneficiary.dart';
import 'package:top_up_app/domain/repositories/beneficiary_repository.dart';

/// Use case for retrieving beneficiaries.
class GetBeneficiaries {
  /// The repository for managing beneficiaries.
  final BeneficiaryRepository repository;

  /// Constructor for `GetBeneficiaries` use case.
  ///
  /// [repository] - The repository instance used to manage beneficiaries.
  GetBeneficiaries(this.repository);

  /// Calls the repository to get the list of beneficiaries.
  ///
  /// Returns a list of beneficiaries.
  Future<List<Beneficiary>> call() async {
    return await repository.getBeneficiaries();
  }
}
