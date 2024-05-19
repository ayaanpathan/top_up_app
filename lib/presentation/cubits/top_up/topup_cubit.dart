import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/domain/entities/beneficiary.dart';
import 'package:top_up_app/domain/entities/topup_option.dart';
import 'package:top_up_app/domain/entities/user.dart';
import 'package:top_up_app/domain/mock/mock_data.dart';
import 'package:top_up_app/presentation/cubits/user/user_cubit.dart';

part 'topup_state.dart';

class TopupCubit extends Cubit<TopupState> {
  TopupCubit() : super(TopupInitial());

  final int serviceCharge = 1;

  Future<void> topUp(TopupOption option, Beneficiary beneficiary, User user,
      BuildContext context) async {
    if (canTopUp(user, beneficiary, option.amount)) {
      beneficiary.remainingBalance += option.amount;
      beneficiary.topupAmount += option.amount;
      beneficiary.topupDate = DateTime.now();
      user.balance -= option.amount + serviceCharge;
      context.read<UserCubit>().setUserData(user);
      emit(TopupSuccess(user.balance));
    }
  }

  bool canTopUp(User user, Beneficiary beneficiary, int amount) {
    const int transactionFee = 1;
    final int totalAmount = amount + transactionFee;
    final currentMonth = DateTime.now().month;
    final currentYear = DateTime.now().year;

    // Check if the user has enough balance
    if (user.balance < totalAmount) {
      return false;
    }

    // Check total top-up amount for the user
    double totalTopUpThisMonth = MockData.beneficiaries.fold(0.0, (total, b) {
      if (b.topupDate.month == currentMonth &&
          b.topupDate.year == currentYear) {
        return total + b.topupAmount;
      }
      return total;
    });

    if (totalTopUpThisMonth + amount > 3000) {
      print(totalTopUpThisMonth);
      emit(const TopupFailureMonthlyLimit(
          'You have reached your total monthly top-up limit of AED 3000.'));
      return false; // Exceeds total top-up limit for all beneficiaries
    }

    // Check individual beneficiary top-up limit
    if (beneficiary.topupDate.month == currentMonth &&
        beneficiary.topupDate.year == currentYear) {
      if (user.isVerified && beneficiary.topupAmount + amount > 1000) {
        print('here1');
        emit(const TopupFailure(
            'Uh oh! Not enough monthly limit available to Top-up.'));
        return false; // Exceeds individual beneficiary limit for verified users
      }
      if (!user.isVerified && beneficiary.topupAmount + amount > 500) {
        print('here2');
        emit(const TopupFailure(
            'Uh oh! Not enough monthly limit available to Top-up. To increase your limit, please verify your account'));
        return false; // Exceeds individual beneficiary limit for non-verified users
      }
    } else {
      // Reset beneficiary top-up amount for the new month
      beneficiary.topupAmount = 0.0;
      beneficiary.topupDate = DateTime.now();
    }

    return true;
  }

  void resetState() {
    emit(TopupInitial());
  }
}
