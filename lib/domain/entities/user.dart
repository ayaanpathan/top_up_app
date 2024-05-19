import 'package:top_up_app/domain/mock/mock_data.dart';
import 'beneficiary.dart';

/// Represents a user in the Top Up App with an ID, name, verification status, username, password, and balance.
class User {
  /// Unique identifier of the user
  final String id;

  /// Name of the user
  final String name;

  /// Verification status of the user
  final bool isVerified;

  /// Username of the user
  final String userName;

  /// Password of the user
  final String password;

  /// Balance of the user
  double balance;

  /// Creates a [User] with the specified [id], [name], [isVerified], [userName], [password], and [balance].
  User({
    required this.id,
    required this.name,
    required this.isVerified,
    required this.userName,
    required this.password,
    required this.balance,
  });
}

/// Extension methods for [User] to provide additional functionality.
extension UserExtension on User {
  /// Gets the available beneficiary limit for the given [beneficiary].
  /// The limit is calculated based on the user's verification status and the amount already topped up for the beneficiary in the current month.
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

  /// Gets the available monthly limit for the user.
  /// The limit is calculated based on the total amount topped up for all beneficiaries in the current month.
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
