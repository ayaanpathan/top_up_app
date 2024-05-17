import 'package:top_up_app/domain/entities/beneficiary.dart';

abstract class BeneficiaryRepository {
  Future<List<Beneficiary>> getBeneficiaries();
  Future<void> addBeneficiary(Beneficiary beneficiary);
  Future<void> removeBeneficiary(String id);
  Future<void> clearBeneficiaries();
}
