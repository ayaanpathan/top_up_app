import 'beneficiary.dart';

class User {
  final String id;
  final String name;
  final bool isVerified;
  double balance;
  final String userName;
  final String password;
  final List<Beneficiary> beneficiaries;

  User({
    required this.id,
    required this.name,
    required this.isVerified,
    required this.balance,
    required this.userName,
    required this.password,
    required this.beneficiaries,
  });
}
