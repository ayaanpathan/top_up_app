import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/data/services/mock_http_service.dart';
import 'package:top_up_app/domain/entities/beneficiary.dart';
import 'package:top_up_app/domain/mock/mock_data.dart';
import 'package:top_up_app/domain/usecases/add_beneficiary.dart';
import 'package:top_up_app/domain/usecases/get_beneficiaries.dart';
import 'package:top_up_app/domain/usecases/remove_beneficiary.dart';

part 'beneficiary_state.dart';

/// Cubit for managing beneficiary-related operations.
class BeneficiaryCubit extends Cubit<BeneficiaryState> {
  /// Use case for getting beneficiaries.
  final GetBeneficiaries getBeneficiaries;

  /// Use case for adding a new beneficiary.
  final AddBeneficiary addBeneficiary;

  /// Use case for removing an existing beneficiary.
  final RemoveBeneficiary removeBeneficiary;

  /// HTTP service for beneficiary-related operations.
  final MockHttpService httpService;

  /// Constructor for the `BeneficiaryCubit`.
  ///
  /// [getBeneficiaries] - Use case for getting beneficiaries.
  /// [addBeneficiary] - Use case for adding a new beneficiary.
  /// [removeBeneficiary] - Use case for removing an existing beneficiary.
  /// [httpService] - HTTP service for beneficiary-related operations.
  BeneficiaryCubit({
    required this.getBeneficiaries,
    required this.addBeneficiary,
    required this.removeBeneficiary,
    required this.httpService,
  }) : super(BeneficiaryInitial());

  /// Fetches the list of beneficiaries.
  void fetchBeneficiaries() async {
    emit(BeneficiaryLoading());
    try {
      final beneficiaries = await getBeneficiaries();
      emit(BeneficiaryLoaded(beneficiaries));
    } catch (_) {
      emit(const BeneficiaryError(message: 'Failed to load beneficiaries'));
    }
  }

  /// Adds a new beneficiary.
  ///
  /// [beneficiary] - The beneficiary to be added.
  void addNewBeneficiary(Beneficiary beneficiary) async {
    emit(BeneficiaryLoading());
    try {
      final response = await httpService.addBeneficiary(beneficiary);
      if (response) {
        fetchBeneficiaries();
      } else {
        emit(const BeneficiaryError(message: 'Beneficiary already exists'));
      }
    } catch (e) {
      emit(BeneficiaryError(message: e.toString()));
    }
  }

  /// Removes an existing beneficiary.
  ///
  /// [id] - The ID of the beneficiary to be removed.
  void removeExistingBeneficiary(String id) async {
    await removeBeneficiary(id);
    fetchBeneficiaries();
  }

  /// Clears the list of beneficiaries.
  void clearBeneficiaries() async {
    MockData.beneficiaries = [];
    emit(const BeneficiaryLoaded([]));
  }
}
