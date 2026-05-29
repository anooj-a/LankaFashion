class PaymentModel {
  final String method;
  final String name;
  final String cardNumber;
  final double balance;

  PaymentModel({
    required this.method,
    required this.name,
    required this.cardNumber,
    required this.balance,
  });
}