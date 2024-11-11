import 'package:flutter/material.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // TODO: 1. Deklarasikan variabel
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final String _errorText = '';


  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: 2. Pasang AppBar
      appBar: AppBar(title: const Text('Sign Up')),
      // TODO: 3. Pasang body
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
                child: Column(
                  // TODO: 4. Atur mainAxisAlignment dan crossAxisAlignment
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _fullnameController,
                      decoration: const InputDecoration(
                        labelText: "Nama Lengkap Pengguna",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    // TODO: 6. Pasang TextFormField Nama Pengguna
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: "Nama Pengguna",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    // TODO: 7. Pasang TextFormField Kata Sandi
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: "Kata Sandi",
                        errorText: _errorText.isNotEmpty ? _errorText : null,
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscurePassword = ! _obscurePassword;
                            });
                          },
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          ),
                        ),
                      ),
                      obscureText: _obscurePassword,
                    ),
                    // TODO: 8. Pasang ElevatedButton Sign In
                    const SizedBox(height: 20),
                    ElevatedButton(onPressed: () {}, child: const Text('Sign Up')),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
