import 'package:top_up_app/domain/entities/beneficiary.dart';
import 'package:top_up_app/domain/entities/user.dart';

/// Provides mock data for the Top Up App, including users and beneficiaries.
class MockData {

  /// A verified user with a balance of 5000.0
  static User user1 = User(
    id: '1',
    name: 'Verified User',
    isVerified: true,
    balance: 5000.0,
    userName: 'user1',
    password: '12345678',
  );

  /// An unverified user with a balance of 5000.0
  static User user2 = User(
    id: '2',
    name: 'Unverified User',
    isVerified: false,
    balance: 5000.0,
    userName: 'user2',
    password: '12345678',
  );

  /// A list of beneficiaries, initially empty
  static List<Beneficiary> beneficiaries = [];
}
