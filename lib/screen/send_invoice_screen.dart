import 'package:flutter/material.dart';

class SendInvoiceScreen extends StatefulWidget {
  const SendInvoiceScreen({super.key});

  @override
  State<SendInvoiceScreen> createState() => _SendInvoiceScreenState();
}

class _SendInvoiceScreenState extends State<SendInvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Wyślij fakturę'),
    );
  }
}
