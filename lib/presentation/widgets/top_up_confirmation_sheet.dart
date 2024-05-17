import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/domain/entities/topup_option.dart';
import 'package:top_up_app/domain/entities/user.dart';
import 'package:top_up_app/presentation/cubits/topup_cubit.dart';
import 'package:top_up_app/presentation/cubits/user_cubit.dart';

class TopupConfirmationSheet extends StatelessWidget {
  final TopupOption option;

  const TopupConfirmationSheet({
    super.key,
    required this.option,
  });

  @override
  Widget build(BuildContext context) {
    final User user = context.read<UserCubit>().user;
    const double serviceFee = 1.0;
    final double totalAmount = option.amount + serviceFee;
    final double remainingBalance = user.balance - totalAmount;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
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
              fontFamily: 'Roboto',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          _buildInfoRow('Top Up Amount:', 'AED ${option.amount}'),
          const SizedBox(height: 8),
          _buildInfoRow('Service Fee:', 'AED $serviceFee'),
          const Divider(height: 24, thickness: 1),
          _buildInfoRow('Total Deduction:', 'AED $totalAmount'),
          const SizedBox(height: 16),
          _buildInfoRow('Remaining Balance:', 'AED $remainingBalance'),
          const SizedBox(height: 24),
          ActionSlider.standard(
            action: (controller) async {
              controller.loading();
              await Future.delayed(const Duration(seconds: 2));
              if (!context.mounted) return;
              Navigator.of(context).pop(true);
              await context.read<TopupCubit>().topUp(option, user, context);
              controller.success();
            },
            backgroundColor: Colors.white,
            sliderBehavior: SliderBehavior.stretch,
            loadingIcon: const CircularProgressIndicator(
              color: Colors.white,
            ),
            toggleColor: Colors.red,
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
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

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
