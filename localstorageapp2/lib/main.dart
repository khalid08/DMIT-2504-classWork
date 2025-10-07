import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const DogApp());

class DogApp extends StatefulWidget {
  const DogApp({super.key});
  @override
  State<DogApp> createState() => _DogAppState();
}

class _DogAppState extends State<DogApp> {
  String? _imageUrl;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadSavedImage();
  }

  // Load saved image URL from file storage
  Future<void> _loadSavedImage() async {
    final file = await _getLocalFile();
    if (await file.exists()) {
      final savedUrl = await file.readAsString();
      setState(() => _imageUrl = savedUrl);
    }
  }

  // Fetch a new random dog image
  Future<void> _getNewDog() async {
    setState(() => _loading = true);
    try {
      final response =
          await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final url = data['message'];
        setState(() => _imageUrl = url);
        final file = await _getLocalFile();
        await file.writeAsString(url); // save image URL locally
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load image!')),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  //Getting the file handle:

  Future<File> _getLocalFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/last_dog.txt');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Dog Viewer')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_imageUrl == null)
                  const Text('Tap the button to load a cute dog!')
                else
                  GestureDetector(
                    onDoubleTap: _getNewDog,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        _imageUrl!,
                        height: 300,
                        width: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                _loading
                    ? const CircularProgressIndicator()
                    : ElevatedButton.icon(
                        onPressed: _getNewDog,
                        icon: const Icon(Icons.refresh),
                        label: const Text('New Dog'),
                      ),
                const SizedBox(height: 10),
                const Text('Double-tap the image to fetch another',
                    style: TextStyle(fontSize: 12, color: Colors.black54)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
