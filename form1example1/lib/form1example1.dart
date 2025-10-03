// STEP 0: Import Flutter's Material library for ready-made UI widgets.
import 'package:flutter/material.dart';

// STEP 1: The app entry point. runApp() inflates our widget tree and shows it on screen.
void main() {
  runApp(const MainApp());
}

// STEP 2: Top-level widget. Stateless because this wrapper doesn't manage state directly.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // STEP 3: MaterialApp sets up app-wide concerns like theming, routing, etc.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mobile UI Form',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      // STEP 4: Home page scaffold (basic page layout: AppBar + body).
      home: const SignUpPage(),
    );
  }
}

// STEP 5: Separate StatefulWidget so we can manage text controllers & validation cleanly.
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // STEP 6: Controllers read the current text from the TextFields.
  final TextEditingController _usernameCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  // Optional: a simple form key for basic validation.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // STEP 7: Always dispose controllers to avoid memory leaks.
  @override
  void dispose() {
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // STEP 8: AppBar with a title — matches your original.
      appBar: AppBar(
        title: const Text('Mobile UI Form'),
      ),

      // STEP 9: Body padding for comfortable spacing.
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        // STEP 10: Form groups our inputs and lets us validate easily.
        child: Form(
          key: _formKey,
          child: Column(
            // Align children to the start (left).
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // STEP 11: Section header — same text as your example.
              const Text(
                'New User Form',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              // STEP 12: Username field (TextField -> TextFormField so we can validate).
              TextFormField(
                controller: _usernameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Username', // identical label intent
                  border: OutlineInputBorder(),
                ),
                // Simple "non-empty" validation.
                validator: (value) =>
                    (value == null || value.trim().isEmpty)
                        ? 'Please enter a username'
                        : null,
              ),

              const SizedBox(height: 16),

              // STEP 13: Password field with typical properties (obscure, no suggestions).
              TextFormField(
                controller: _passwordCtrl,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: 'Password', // identical label intent
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    (value == null || value.isEmpty)
                        ? 'Please enter a password'
                        : null,
              ),

              const SizedBox(height: 20),

              // STEP 14: Action button — TextButton with custom colors (matches your styleFrom).
              SizedBox(
                width: double.infinity, // make the button full-width (nice UX)
                child: TextButton(
                  // styleFrom uses current theme for primary color background & white text.
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  // STEP 15: onPressed must be a void callback — do work here.
                  onPressed: () {
                    // Validate form; if OK, show a friendly message.
                    if (_formKey.currentState!.validate()) {
                      final username = _usernameCtrl.text.trim();

                      // STEP 16: Show a SnackBar confirmation.
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Signed up as: $username'),
                        ),
                      );

                      // Optional: Clear fields after "sign up".
                      _usernameCtrl.clear();
                      _passwordCtrl.clear();_
