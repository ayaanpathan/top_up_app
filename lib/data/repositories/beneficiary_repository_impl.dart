import 'package:top_up_app/domain/entities/beneficiary.dart';
import 'package:top_up_app/domain/mock/mock_data.dart';
import 'package:top_up_app/domain/repositories/beneficiary_repository.dart';

/// A repository implementation for handling beneficiary data operations.
///
/// This class implements the [BeneficiaryRepository] interface and provides
/// methods to interact with beneficiary data. It uses mock data stored in the
/// [MockData] class for testing purposes.
class BeneficiaryRepositoryImpl implements BeneficiaryRepository {


  /// Retrieves a list of beneficiaries.
  ///
  /// This method simulates fetching beneficiaries from a data source by
  /// returning mock data after a delay of 1 second.
  @override
  Future<List<Beneficiary>> getBeneficiaries() async {
    // Simulate asynchronous delay
    return Future.delayed(
        const Duration(seconds: 1), () => MockData.beneficiaries);
  }

  /// Adds a new beneficiary to the repository.
  ///
  /// This method adds the provided [beneficiary] to the mock data list.
  @override
  Future<void> addBeneficiary(Beneficiary beneficiary) async {
    MockData.beneficiaries.add(beneficiary);
  }

  /// Removes a beneficiary from the repository.
  ///
  /// This method removes the beneficiary with the specified [id] from the
  /// mock data list.
  @override
  Future<void> removeBeneficiary(String id) async {
    MockData.beneficiaries.removeWhere((beneficiary) => beneficiary.id == id);
  }

  /// Clears all beneficiaries from the repository.
  ///
  /// This method clears the mock data list, effectively removing all
  /// beneficiaries.
  @override
  Future<void> clearBeneficiaries() async {
    MockData.beneficiaries = [];
  }
}
