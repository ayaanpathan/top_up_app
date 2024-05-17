import 'package:flutter/material.dart';
import 'package:top_up_app/domain/entities/beneficiary.dart';
import 'package:top_up_app/domain/entities/user.dart';
import 'package:top_up_app/presentation/pages/topup_screen.dart';

class BeneficiaryCard extends StatelessWidget {
  final Beneficiary beneficiary;
  final User user;

  const BeneficiaryCard(
      {super.key, required this.beneficiary, required this.user});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      height: 180,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        shadowColor: Colors.black,
        elevation: 8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                beneficiary.nickname,
                style: const TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              beneficiary.phoneNumber,
              style: const TextStyle(fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TopupScreen(
                        beneficiary: beneficiary,
                        user: user,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[300],
                ),
                child: const Text(
                  'Recharge Now',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
