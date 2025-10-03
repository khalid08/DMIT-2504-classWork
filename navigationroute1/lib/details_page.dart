import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String data = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(title: const Text('Details Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Received: $data"),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Send back Modified Data"),
              onPressed: () {
                Navigator.pop(context, "Modified: $data");
              },
            ),
          ],
        ),
      ),
    );
  }
}
