import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

void main() {
  runApp(MainApp());
}

void handleQrCode(String? code) {
  print('QR Code scanned: $code');
}

class MainApp extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Quiz Connexion')),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox.square(
                dimension: 250.00,
                child: QrCamera(
                  qrCodeCallback: handleQrCode,
                ),
              ),

              Form(
                key: _formKey,
                child: TextFormField( 
                  decoration: const InputDecoration(
                    hintText: 'Enter the code',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some digits.';
                    }
                    return null;
                  },
                ),
              ),
               
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    if (_formKey.currentState!.validate()) {
                      // Process data.
                    }
                  },
                  child: const Text('Submit'),
                )
              )

            ]
          )
        ),
      ),
    );
  }
}