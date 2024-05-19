/// Represents a beneficiary in the Top Up App with an ID, nickname, phone number, remaining balance, top-up amount, and top-up date.
class Beneficiary {
  /// Unique identifier of the beneficiary
  final String id;

  /// Nickname of the beneficiary
  final String nickname;

  /// Phone number of the beneficiary
  final String phoneNumber;

  /// Remaining balance of the beneficiary
  double remainingBalance;

  /// Amount last topped up for the beneficiary
  double topupAmount;

  /// Date when the last top-up occurred
  DateTime topupDate;

  /// Creates a [Beneficiary] with the specified [id], [nickname], [phoneNumber], [remainingBalance], [topupAmount] (defaults to 0.0), and [topupDate] (defaults to current date and time).
  Beneficiary({
    required this.id,
    required this.nickname,
    required this.phoneNumber,
    required this.remainingBalance,
    this.topupAmount = 0.0,
    DateTime? topupDate,
  }) : topupDate = topupDate ?? DateTime.now();
}
