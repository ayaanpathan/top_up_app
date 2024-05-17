import 'package:top_up_app/domain/entities/beneficiary.dart';
import 'package:top_up_app/domain/repositories/beneficiary_repository.dart';

class GetBeneficiaries {
  final BeneficiaryRepository repository;

  GetBeneficiaries(this.repository);

  Future<List<Beneficiary>> call() async {
    return await repository.getBeneficiaries();
  }
}
