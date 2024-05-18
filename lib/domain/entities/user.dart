import 'package:top_up_app/domain/mock/mock_data.dart';

import 'beneficiary.dart';

class User {
  final String id;
  final String name;
  final bool isVerified;
  double balance;
  final String userName;
  final String password;

  User({
    required this.id,
    required this.name,
    required this.isVerified,
    required this.balance,
    required this.userName,
    required this.password,
  });
}

extension UserExtension on User {
  double getAvailableBeneficiaryLimit(Beneficiary beneficiary) {
    final currentMonth = DateTime.now().month;
    final currentYear = DateTime.now().year;
    double currentTopupAmount = 0.0;

    if (beneficiary.topupDate.month == currentMonth &&
        beneficiary.topupDate.year == currentYear) {
      currentTopupAmount = beneficiary.topupAmount;
    }

    if (isVerified) {
      return 1000 - currentTopupAmount;
    } else {
      return 500 - currentTopupAmount;
    }
  }

  double getAvailableMonthlyLimit() {
    final currentMonth = DateTime.now().month;
    final currentYear = DateTime.now().year;
    double totalTopUpThisMonth = MockData.beneficiaries.fold(0.0, (total, b) {
      if (b.topupDate.month == currentMonth &&
          b.topupDate.year == currentYear) {
        return total + b.topupAmount;
      }
      return total;
    });
    return 3000 - totalTopUpThisMonth;
  }
}
