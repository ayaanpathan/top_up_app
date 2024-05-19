import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/domain/entities/beneficiary.dart';
import 'package:top_up_app/domain/entities/topup_option.dart';
import 'package:top_up_app/domain/entities/user.dart';
import 'package:top_up_app/presentation/cubits/top_up/topup_cubit.dart';
import 'package:top_up_app/presentation/cubits/user/user_cubit.dart';
import 'package:top_up_app/presentation/widgets/alert_dialog.dart';
import 'package:top_up_app/presentation/widgets/balance_card.dart';
import 'package:top_up_app/presentation/widgets/top_up_confirmation_sheet.dart';

class TopupScreen extends StatefulWidget {
  final Beneficiary beneficiary;
  final User user;

  const TopupScreen({
    Key? key,
    required this.beneficiary,
    required this.user,
  }) : super(key: key);

  @override
  State<TopupScreen> createState() => _TopupScreenState();
}

class _TopupScreenState extends State<TopupScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Top Up ${widget.beneficiary.nickname}',
          style:
              theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        backgroundColor: theme.primaryColorDark,
        elevation: theme.appBarTheme.elevation ?? 0,
      ),
      backgroundColor: theme.primaryColorDark,
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserBalanceUpdate) {
            final availableLimit =
                state.user.getAvailableBeneficiaryLimit(widget.beneficiary);

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const BalanceCard(),
                  const SizedBox(height: 20),
                  LimitCard(
                      title: 'Available Beneficiary Limit:',
                      availableLimit: availableLimit),
                  const SizedBox(height: 20),
                  LimitCard(
                      title: 'Available Monthly Limit:',
                      availableLimit: state.user.getAvailableMonthlyLimit()),
                  const SizedBox(height: 20),
                  const Text(
                    'Select Top Up Amount',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  BlocListener<TopupCubit, TopupState>(
                    listener: (context, state) {
                      if (state is TopupFailure) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialogWidget(
                              title: 'Error!',
                              content: state.error,
                            );
                          },
                        );
                        context.read<TopupCubit>().resetState();
                      } else if (state is TopupFailureMonthlyLimit) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialogWidget(
                              title: 'Error!',
                              content: state.error,
                            );
                          },
                        );
                        context.read<TopupCubit>().resetState();
                      }
                    },
                    child: Expanded(
                      child: ListView.builder(
                        itemCount: TopupOption.options.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final option = TopupOption.options[index];
                          return Card(
                            color: theme.cardColor,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 16,
                              ),
                              title: Text(
                                'AED ${option.amount}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                color: Theme.of(context).hintColor,
                              ),
                              onTap: () {
                                if (availableLimit == 0) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const AlertDialogWidget(
                                        title: 'Error!',
                                        content:
                                            'You have reached the monthly top-up limit for this beneficiary.',
                                      );
                                    },
                                  );
                                } else if (option.amount >
                                    state.user.getAvailableMonthlyLimit()) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const AlertDialogWidget(
                                        title: 'Error!',
                                        content:
                                            'Topup option is more than the available monthly limit',
                                      );
                                    },
                                  );
                                } else if (option.amount > availableLimit) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const AlertDialogWidget(
                                        title: 'Error!',
                                        content:
                                            'Topup option is more than the available beneficiary limit',
                                      );
                                    },
                                  );
                                } else {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    isDismissible: state is !TopupLoading,
                                    backgroundColor:
                                        theme.scaffoldBackgroundColor,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    builder: (context) => Padding(
                                      padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom,
                                      ),
                                      child: TopupConfirmationSheet(
                                        option: option,
                                        beneficiary: widget.beneficiary,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
            ),
          );
        },
      ),
    );
  }
}

class LimitCard extends StatelessWidget {
  final double availableLimit;
  final String title;

  const LimitCard({
    super.key,
    required this.title,
    required this.availableLimit,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      color: theme.cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            Text(
              'AED $availableLimit',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).hintColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
