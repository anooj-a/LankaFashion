import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/Provider/Models/PaymentModel.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AddPayment extends StatefulWidget {
  const AddPayment({super.key});

  @override
  State<AddPayment> createState() => _AddPaymentState();
}

class _AddPaymentState extends State<AddPayment> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController(); // Renamed logically in UI to Security Code
  // TextEditingController _addressController = TextEditingController();
  final maskFormatter = MaskTextInputFormatter(
    mask: "*** **** *****",
    filter: {"*": RegExp(r'[0-9]')},
  );
  
  // New formatter for CVV (3 digits)
  final cvvMaskFormatter = MaskTextInputFormatter(
    mask: "***",
    filter: {"*": RegExp(r'[0-9]')},
  );

  double balance = 0.0;

  String? selectedMethod;

  final List<String> paymentMethods = [
    "Debit Card",
    "Cash on Delivery",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Payment Methods", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  
                  // Dropdown with Enhanced UI
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonFormField<String>(
                      hint: const Text("Select Payment Method"),
                      initialValue: selectedMethod,
                      items: paymentMethods.map((method) {
                        return DropdownMenuItem(value: method, child: Text(method));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedMethod = value;
                        });
                      },
                      validator: (value) =>
                          value == null ? "Please select a method" : null,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Show these fields ONLY if Debit Card is selected
                  if (selectedMethod == "Debit Card") ...[
                    
                    const Text(
                      "Card Details",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),

                    TextFormField(
                      controller: _userNameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "Card Holder Name",
                        hintText: "eg. Anooj",
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.black, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    
                    TextFormField(
                      controller: _cardNumberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Card Number",
                        hintText: "eg. 185 0200 55040",
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.black, width: 2),
                        ),
                      ),
                      inputFormatters: [maskFormatter],
                      validator: (value) {
                        if (value == null ||
                            value.replaceAll('', '').length != 10) {
                          return "Card number must be exactly 16 digits";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    
                    // Changed Balance to Security Code (CVV)
                    TextFormField(
                      controller: _balanceController,
                      keyboardType: TextInputType.number,
                      maxLength: 3,
                      decoration: InputDecoration(
                        labelText: "Security Code (CVV)",
                        hintText: "123",
                        counterText: "", // Hide default counter
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.black, width: 2),
                        ),
                      ),
                      inputFormatters: [cvvMaskFormatter],
                      onChanged: (value) => balance = double.tryParse(value) ?? 0.0,
                    ),
                  ],

                  const SizedBox(height: 30),
                  
                  // Button Enhanced UI
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final payment = PaymentModel(
                            method: selectedMethod ?? "",
                            name: _userNameController.text,
                            cardNumber: _cardNumberController.text,
                            balance: balance,
                          );

                          Navigator.pop(context, payment);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "ADD PAYMENT METHOD",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  // void addPaymentMethod      codes

  // bakend
}