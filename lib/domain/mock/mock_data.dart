import 'package:top_up_app/domain/entities/beneficiary.dart';
import 'package:top_up_app/domain/entities/user.dart';

class MockData {
  static User user1 = User(
    id: '1',
    name: 'Verified User',
    isVerified: true,
    balance: 5000.0,
    userName: 'user1',
    password: '12345678',
    beneficiaries: [],
  );

  static User user2 = User(
    id: '2',
    name: 'Unverified User',
    isVerified: false,
    balance: 5000.0,
    userName: 'user2',
    password: '12345678',
    beneficiaries: [],
  );

  static List<Beneficiary> beneficiaries = [];
}
