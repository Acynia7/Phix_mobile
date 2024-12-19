import 'package:flutter/material.dart';
import '../services/api_services.dart'; // Importer ApiService

class PseudoScreen extends StatefulWidget {
  const PseudoScreen({super.key});

  @override
  _PseudoScreenState createState() => _PseudoScreenState();
}

class _PseudoScreenState extends State<PseudoScreen> {
  final TextEditingController _pseudoController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _pseudoController.dispose();
    super.dispose();
  }

  Future<void> _submitPseudo(String sessionCode) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await ApiService.updatePseudo(sessionCode, _pseudoController.text);
      // Handle success (e.g., show a success message or navigate to another screen)
    } catch (e) {
      // Handle error (e.g., show an error message)
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Pseudo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _pseudoController,
              decoration: const InputDecoration(labelText: 'Enter Pseudo'),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      // Replace 'your_session_code' with the actual session code
                      _submitPseudo('your_session_code');
                    },
                    child: const Text('Submit'),
                  ),
          ],
        ),
      ),
    );
  }
}