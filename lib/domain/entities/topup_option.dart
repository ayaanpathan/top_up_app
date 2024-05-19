/// Represents a top-up option with a specific amount.
class TopupOption {
  /// The amount for the top-up option.
  final int amount;

  /// Constructor to create a [TopupOption] with the given [amount].
  TopupOption({required this.amount});

  /// Pre-defined list of top-up options.
  static List<TopupOption> options = [
    TopupOption(amount: 5),
    TopupOption(amount: 10),
    TopupOption(amount: 20),
    TopupOption(amount: 30),
    TopupOption(amount: 50),
    TopupOption(amount: 75),
    TopupOption(amount: 100),
  ];
}
