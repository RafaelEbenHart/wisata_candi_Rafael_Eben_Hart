import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wisata_candi_rafael_eben_hart/screens/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  //todo 1.deklarasi variable
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorText = "";

  bool _isSignedIn = false;

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //todo 2.appbar
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      //todo 3.body
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              child: Column(
                //todo 4. main and cross
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //todo 5 textformfeild username
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: "Nama Pengguna",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  //todo 6 textfromfeild password
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      errorText: _errorText.isNotEmpty ? _errorText : null,
                      labelText: "Kata Sandi",
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = ! _obscurePassword;
                          });
                        },
                        icon: Icon(_obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                    obscureText: _obscurePassword,
                  ),
                  //todo 7 elavated button
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(onPressed: () { Navigator.pop(context,true);}, child: const Text("Sign In")),
                  //todo 8 TextButton sign Up
                  const SizedBox(height: 20,),
                  RichText(text: TextSpan(text: "Belum Punya Akun?",
                  style: const TextStyle(fontSize: 16,color: Colors.deepPurple),
                    children: <TextSpan>[
                      TextSpan(text: "Daftar di sini.",style: const TextStyle(color: Colors.blue,
                      decoration: TextDecoration.underline,
                      fontSize: 16
                      ),
                      recognizer: TapGestureRecognizer()
                      ..onTap=(){Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );}),
                    ],
                  ),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
