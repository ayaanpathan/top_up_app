class TopupOption {
  final int amount;

  TopupOption({required this.amount});

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
