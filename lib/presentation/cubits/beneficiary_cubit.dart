import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/domain/entities/beneficiary.dart';
import 'package:top_up_app/domain/mock/mock_data.dart';
import 'package:top_up_app/domain/usecases/add_beneficiary.dart';
import 'package:top_up_app/domain/usecases/get_beneficiaries.dart';
import 'package:top_up_app/domain/usecases/remove_beneficiary.dart';

part 'beneficiary_state.dart';

class BeneficiaryCubit extends Cubit<BeneficiaryState> {
  final GetBeneficiaries getBeneficiaries;
  final AddBeneficiary addBeneficiary;
  final RemoveBeneficiary removeBeneficiary;

  BeneficiaryCubit({
    required this.getBeneficiaries,
    required this.addBeneficiary,
    required this.removeBeneficiary,
  }) : super(BeneficiaryInitial());

  void fetchBeneficiaries() async {
    emit(BeneficiaryLoading());
    try {
      final beneficiaries = await getBeneficiaries();
      emit(BeneficiaryLoaded(beneficiaries, MockData.user1.balance));
    } catch (_) {
      emit(BeneficiaryError());
    }
  }

  void addNewBeneficiary(Beneficiary beneficiary) async {
    await addBeneficiary(beneficiary);
    fetchBeneficiaries();
  }

  void removeExistingBeneficiary(String id) async {
    await removeBeneficiary(id);
    fetchBeneficiaries();
  }

  void clearBeneficiaries() async {
    emit(const BeneficiaryLoaded([], 0));
  }
}
