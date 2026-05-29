import 'package:flutter/material.dart';

class PaymentMethodList extends StatefulWidget {
  final String? selectedPaymentMethodId;
  final double? selectedPaymentBalance;
  final double? finalAmount;
  final Function(String?, double?) onPaymentMethdSelected;

  const PaymentMethodList({
    super.key,
    required this.selectedPaymentMethodId,
    required this.selectedPaymentBalance,
    required this.finalAmount,
    required this.onPaymentMethdSelected,
  });

  @override
  State<PaymentMethodList> createState() => _PaymentMethodListState();
}

class _PaymentMethodListState extends State<PaymentMethodList> {
  // Mock data - Replace this with your actual backend fetching logic
  final List<Map<String, dynamic>> paymentMethods = [
    {"id": "pm_1", "name": "Visa **** 1234", "balance": 150.0},
    {"id": "pm_2", "name": "Apple Pay", "balance": 45.0},
    {"id": "pm_3", "name": "PayPal", "balance": 1000.0},
  ];

  @override
  Widget build(BuildContext context) {
    if (paymentMethods.isEmpty) {
      return const SizedBox(
        height: 100,
        child: Center(child: Text("No Payment Methods Available")),
      );
    }

    return SizedBox(
      height: 200, // Constrain the height for the dialog
      child: ListView.builder(
        shrinkWrap: true, 
        itemCount: paymentMethods.length,
        itemBuilder: (context, index) {
          final method = paymentMethods[index];
          final bool isSelected = widget.selectedPaymentMethodId == method['id'];

          return Material(
            color: isSelected ? Colors.blue[50] : Colors.transparent,
            child: ListTile(
              onTap: () {
                widget.onPaymentMethdSelected(method['id'], method['balance']);
              },
              leading: const Icon(Icons.account_balance_wallet),
              title: Text(method['name']),
              subtitle: Text("Balance: \$${method['balance']}"),
              trailing: isSelected 
                  ? const Icon(Icons.check_circle, color: Colors.blue) 
                  : null,
            ),
          );
        },
      ),
    );
  }
}