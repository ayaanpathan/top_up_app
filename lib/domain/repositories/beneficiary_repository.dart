import 'package:top_up_app/domain/entities/beneficiary.dart';

/// An abstract repository for managing beneficiaries.
abstract class BeneficiaryRepository {
  /// Retrieves a list of all beneficiaries.
  Future<List<Beneficiary>> getBeneficiaries();

  /// Adds a new beneficiary.
  ///
  /// [beneficiary] - The beneficiary to be added.
  Future<void> addBeneficiary(Beneficiary beneficiary);

  /// Removes a beneficiary by their ID.
  ///
  /// [id] - The ID of the beneficiary to be removed.
  Future<void> removeBeneficiary(String id);

  /// Clears all beneficiaries from the repository.
  Future<void> clearBeneficiaries();
}
