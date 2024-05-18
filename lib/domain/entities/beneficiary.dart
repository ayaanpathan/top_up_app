class Beneficiary {
  final String id;
  final String nickname;
  final String phoneNumber;
  double remainingBalance;
  double topupAmount;
  DateTime topupDate;

  Beneficiary({
    required this.id,
    required this.nickname,
    required this.phoneNumber,
    required this.remainingBalance,
    this.topupAmount = 0.0,
    DateTime? topupDate,
  }) : topupDate = topupDate ?? DateTime.now();
}
