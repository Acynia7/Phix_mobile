import 'package:flutter/material.dart';
import 'package:phix/screen/pseudo_screen.dart';
import '../qr_camera_widget.dart';
import '../services/api_services.dart'; // Importer ApiService

class MainApp extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();

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
                child: QrCameraWidget(),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _codeController,
                        decoration: const InputDecoration(
                          labelText: 'Enter Code',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a code';
                          }
                          return null;
                        },
                      ),
                      Builder(
                        builder: (BuildContext context) {
                          return ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                // Appeler verifySessionCode
                                bool sessionExists = await ApiService.verifySessionCode(_codeController.text);
                                if (sessionExists) {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PseudoScreen()),);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Session code is invalid.')),
                                  );
                                }
                              }
                            },
                            child: const Text('Submit'),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}