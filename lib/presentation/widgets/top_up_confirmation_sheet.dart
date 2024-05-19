import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/domain/entities/beneficiary.dart';
import 'package:top_up_app/domain/entities/topup_option.dart';
import 'package:top_up_app/domain/entities/user.dart';
import 'package:top_up_app/presentation/cubits/top_up/topup_cubit.dart';
import 'package:top_up_app/presentation/cubits/user/user_cubit.dart';

/// A bottom sheet widget for confirming a top-up transaction.
class TopupConfirmationSheet extends StatelessWidget {
  /// The top-up option selected.
  final TopupOption option;

  /// The beneficiary to top up.
  final Beneficiary beneficiary;

  /// Constructs a [TopupConfirmationSheet] with the specified [option] and [beneficiary].
  const TopupConfirmationSheet({
    super.key,
    required this.option,
    required this.beneficiary,
  });

  @override
  Widget build(BuildContext context) {
    final User user = context.read<UserCubit>().user;
    final ThemeData theme = Theme.of(context);
    const double serviceFee = 1.0;
    final double totalAmount = option.amount + serviceFee;
    final double remainingBalance = user.balance - totalAmount;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Top Up Confirmation',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            'Top Up Amount:',
            'AED ${option.amount}',
          ),
          const SizedBox(height: 8),
          _buildInfoRow(
            'Service Fee:',
            'AED $serviceFee',
          ),
          const Divider(height: 24, thickness: 1),
          _buildInfoRow(
            'Total Deduction:',
            'AED $totalAmount',
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            'Remaining Balance:',
            'AED $remainingBalance',
          ),
          const SizedBox(height: 24),
          _buildSlider(
            context,
            user,
          ),
        ],
      ),
    );
  }

  /// Builds the action slider widget for confirming the top-up transaction.
  Widget _buildSlider(BuildContext context, User user) {
    return ActionSlider.standard(
      action: (controller) async {
        controller.loading();
        await Future.delayed(const Duration(seconds: 2));
        controller.success();
        if (!context.mounted) return;
        await context
            .read<TopupCubit>()
            .topUp(option, beneficiary, user, context);
        if (!context.mounted) return;
        Navigator.of(context).pop();
      },
      backgroundColor: Theme.of(context).cardColor,
      sliderBehavior: SliderBehavior.stretch,
      loadingIcon: const CircularProgressIndicator(
        color: Colors.white,
      ),
      toggleColor: Theme.of(context).primaryColor,
      icon: const Icon(
        Icons.chevron_right,
        color: Colors.white,
      ),
      successIcon: const Icon(
        Icons.check_circle_outline,
        color: Colors.white,
      ),
      child: const Text(
        'Slide to confirm',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  /// Builds a row widget with label and value.
  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
