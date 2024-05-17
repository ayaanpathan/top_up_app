import 'package:top_up_app/domain/entities/beneficiary.dart';
import 'package:top_up_app/domain/mock/mock_data.dart';
import 'package:top_up_app/domain/repositories/beneficiary_repository.dart';

class BeneficiaryRepositoryImpl implements BeneficiaryRepository {
  @override
  Future<List<Beneficiary>> getBeneficiaries() async {
    return Future.delayed(
        const Duration(seconds: 1), () => MockData.beneficiaries);
  }

  @override
  Future<void> addBeneficiary(Beneficiary beneficiary) async {
    MockData.beneficiaries.add(beneficiary);
  }

  @override
  Future<void> removeBeneficiary(String id) async {
    MockData.beneficiaries.removeWhere((beneficiary) => beneficiary.id == id);
  }

  @override
  Future<void> clearBeneficiaries() async {
    MockData.beneficiaries = [];
  }
}
