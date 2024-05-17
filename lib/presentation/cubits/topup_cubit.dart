import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/domain/entities/beneficiary.dart';
import 'package:top_up_app/domain/entities/topup_option.dart';
import 'package:top_up_app/domain/entities/user.dart';
import 'package:top_up_app/presentation/cubits/user_cubit.dart';

part 'topup_state.dart';

class TopupCubit extends Cubit<TopupState> {
  TopupCubit() : super(TopupInitial());

  Future<void> topUp(
      TopupOption option, User user, BuildContext context) async {
    if (user.balance >= option.amount + 1) {
      user.balance = user.balance - option.amount - 1;
      emit(TopupSuccess(user.balance - option.amount - 1));
      context.read<UserCubit>().emit(UserLoaded(user));
    } else {
      emit(const TopupFailure('Insufficient balance'));
    }
  }
}
