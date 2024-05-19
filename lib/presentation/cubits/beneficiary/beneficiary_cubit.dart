import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/data/services/mock_http_service.dart';
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
  final MockHttpService httpService;

  BeneficiaryCubit({
    required this.getBeneficiaries,
    required this.addBeneficiary,
    required this.removeBeneficiary,
    required this.httpService,  // Initialize the HTTP service
  }) : super(BeneficiaryInitial());

  void fetchBeneficiaries() async {
    emit(BeneficiaryLoading());
    try {
      final beneficiaries = await getBeneficiaries();
      emit(BeneficiaryLoaded(beneficiaries, MockData.user1.balance));
    } catch (_) {
      emit(const BeneficiaryError(message: 'Beneficiary with this phone number already exists!'));
    }
  }

  void addNewBeneficiary(Beneficiary beneficiary) async {
    emit(BeneficiaryLoading());
    try {
      final response = await httpService.addBeneficiary(beneficiary);
      if (response) {
        fetchBeneficiaries();
      } else {
        emit(const BeneficiaryError(message: 'Beneficiary with this phone number already exists!'));
      }
    } catch (e) {
      emit(BeneficiaryError(message: e.toString()));
    }
  }

  void removeExistingBeneficiary(String id) async {
    await removeBeneficiary(id);
    fetchBeneficiaries();
  }

  void clearBeneficiaries() async {
    MockData.beneficiaries = [];
    emit(const BeneficiaryLoaded([], 0));
  }
}
