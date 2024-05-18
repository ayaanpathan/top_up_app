import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/presentation/cubits/beneficiary/beneficiary_cubit.dart';
import 'package:top_up_app/presentation/cubits/user/user_cubit.dart';
import 'package:top_up_app/presentation/widgets/add_beneficiary_sheet.dart';
import 'package:top_up_app/presentation/widgets/balance_card.dart';
import 'package:top_up_app/presentation/widgets/beneficiary_card.dart';
import 'login_screen.dart';

class BeneficiaryScreen extends StatefulWidget {
  const BeneficiaryScreen({super.key});

  @override
  State<BeneficiaryScreen> createState() => _BeneficiaryScreenState();
}

class _BeneficiaryScreenState extends State<BeneficiaryScreen> {
  bool _showBalance = false;

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserCubit>().user;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Top Up App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.black87,
        elevation: 0,
        actions: [
          const Text('Show Balance ', style: TextStyle(color: Colors.white)),
          Switch(
              value: _showBalance,
              onChanged: (val) {
                setState(() {
                  _showBalance = !_showBalance;
                });
              },
              activeColor: Colors.white),
        ],
      ),
      backgroundColor: Colors.black87,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Center(
                child: Text(
                  'Hi, ${user.name}!',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              onTap: () => _logOut(context),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome back!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Manage your beneficiaries below',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[300],
                ),
              ),
              const SizedBox(height: 24),
              if (_showBalance) const BalanceCard(),
              const SizedBox(height: 24),
              const Divider(thickness: 1, color: Colors.grey),
              const SizedBox(height: 16),
              const Text(
                'Your Beneficiaries',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              BlocBuilder<BeneficiaryCubit, BeneficiaryState>(
                bloc: context.read<BeneficiaryCubit>(),
                builder: (context, state) {
                  if (state is BeneficiaryLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    );
                  } else if (state is BeneficiaryLoaded) {
                    return Column(
                      children: [
                        SizedBox(
                          height: state.beneficiaries.isEmpty ? 0 : 240,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            clipBehavior: Clip.none,
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.beneficiaries.length,
                            itemBuilder: (context, index) {
                              final beneficiary = state.beneficiaries[index];
                              return BeneficiaryCard(
                                beneficiary: beneficiary,
                                user: user,
                              );
                            },
                          ),
                        ),
                        SizedBox(height: state.beneficiaries.isEmpty ? 0 : 16),
                        if (state.beneficiaries.length < 5)
                          ElevatedButton(
                            onPressed: () => showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              builder: (context) => Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom,
                                ),
                                child: const AddBeneficiaryBottomSheet(),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                            ),
                            child: const Text(
                              'Add a new Beneficiary',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    );
                  } else {
                    return const Center(
                        child: Text(
                      'Failed to load beneficiaries',
                      style: TextStyle(color: Colors.white),
                    ));
                  }
                },
              ),
              const SizedBox(height: 16),
              const Divider(thickness: 1, color: Colors.grey),
              const SizedBox(height: 24),
              const Text(
                'Quick Tips:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '• You can add up to 5 beneficiaries.\n'
                '• Please make sure to verify the phone numbers of your beneficiaries.\n'
                '• You can top up your beneficiaries’ accounts quickly and securely.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[300],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  void _logOut(BuildContext context) {
    context.read<BeneficiaryCubit>().clearBeneficiaries();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (Route<dynamic> route) => false);
  }
}
