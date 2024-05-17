import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/domain/entities/user.dart';
import 'package:top_up_app/presentation/cubits/beneficiary_cubit.dart';
import 'package:top_up_app/presentation/widgets/add_beneficiary_sheet.dart';
import 'package:top_up_app/presentation/widgets/beneficiary_card.dart';

import 'login_screen.dart';

class BeneficiaryScreen extends StatelessWidget {
  const BeneficiaryScreen({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Top Up App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            fontFamily: 'Roboto', // Use a modern font
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[100],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.red,
              ),
              child: Text(
                'Hi, ${user.name}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.black),
              title: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Roboto',
                ),
              ),
              onTap: () => _logOut(context),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<BeneficiaryCubit, BeneficiaryState>(
            bloc: context.read<BeneficiaryCubit>(),
            builder: (context, state) {
              if (state is BeneficiaryLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is BeneficiaryLoaded) {
                return Column(
                  children: [
                    SizedBox(
                      height: 180,
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
                    const SizedBox(height: 48),
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
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: const AddBeneficiaryBottomSheet(),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[600],
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
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                );
              } else {
                return const Center(
                    child: Text('Failed to load beneficiaries'));
              }
            },
          ),
        ],
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
