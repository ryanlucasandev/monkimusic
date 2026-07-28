import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerPage extends StatelessWidget {
  const QrScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool _isScanned = false;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Scan QR'),
      ),
      body: Center(
        child: MobileScanner(
          onDetect: (capture) {
            if (_isScanned) return;

            final value = capture.barcodes.first.rawValue;
            if (value == null) return;

            _isScanned = true;
            Navigator.pop(context, value);
          },
        ),
      ),
    );
  }
}
