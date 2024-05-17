import 'package:top_up_app/domain/repositories/beneficiary_repository.dart';

class RemoveBeneficiary {
  final BeneficiaryRepository repository;

  RemoveBeneficiary(this.repository);

  Future<void> call(String id) async {
    return await repository.removeBeneficiary(id);
  }
}
