class LoanOfferModel {
  final double rate;
  final int installments;
  final double simulatedAmount;
  final double installmentAmount;
  final String agreement;
  final String bank;

  LoanOfferModel({
    required this.rate,
    required this.installments,
    required this.simulatedAmount,
    required this.installmentAmount,
    required this.agreement,
    required this.bank,
  });
}
