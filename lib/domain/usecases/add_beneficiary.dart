import 'package:top_up_app/domain/entities/beneficiary.dart';
import 'package:top_up_app/domain/repositories/beneficiary_repository.dart';

class AddBeneficiary {
  final BeneficiaryRepository repository;

  AddBeneficiary(this.repository);

  Future<void> call(Beneficiary beneficiary) async {
    return await repository.addBeneficiary(beneficiary);
  }
}
