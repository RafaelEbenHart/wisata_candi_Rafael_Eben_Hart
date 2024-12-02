import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata_candi_rafael_eben_hart/screens/sign_up_screen.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

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

  Future<Map<String, String>>_retrivalAnddDecryptDataFrompref(
      Future<SharedPreferences> prefs,
      )async{
    final sharedPreferences = await prefs;
    final encryptedUsername = sharedPreferences.getString('username')??'';
    final encryptedPassword = sharedPreferences.getString('password')??'';
    final KeyString = sharedPreferences.getString('key')??'';
    final ivString = sharedPreferences.getString('iv')??'';

    final encrypt.Key key = encrypt.Key = encrypt.Key.fromBase64(keyString);
    final iv = encrypt.IV.fromBase64(ivString);

    final encrypter = encrypter.Encrypter(encrypt.AES(key));
    final decryptedUsername = encrypter.decrypt64(encryptedUsername,iv:iv);
    final decryptedPassword = encrypter.decrypt64(encryptedPassword,iv:iv);

    return {'username':decrytedUsername, 'password':decryptedPassword};
  }

  void _signin() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String savedUsername = pref.getString('username') ?? '';
    final String savedPassword = pref.getString('password') ?? '';
    final String enteredUsername = _usernameController.text.trim();
    final String enteredPassword = _passwordController.text.trim();

    if (enteredUsername.isEmpty || enteredPassword.isEmpty) {
      setState(() {
        _errorText = "Nama pengguna dan kata sandi harus diisi!";
      });
      return;
    }

    if (savedUsername.isEmpty || savedPassword.isEmpty) {
      setState(() {
        _errorText = "Pengguna belum terdaftar.Silakan daftar terlebih dahulu";
      });
    }

    if (enteredUsername == savedUsername && enteredPassword == savedPassword) {
      setState(() {
        _errorText = "";
        _isSignedIn = true;
        pref.setBool("isSignIn", true);
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/');
      });
    } else {
      setState(() {
        _errorText = "Nama pengguna atau kata sandi salah";
      });
    }
  }

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
                            _obscurePassword = !_obscurePassword;
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
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: const Text("Sign In")),
                  //todo 8 TextButton sign Up
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Belum Punya Akun?",
                      style: const TextStyle(
                          fontSize: 16, color: Colors.deepPurple),
                      children: <TextSpan>[
                        TextSpan(
                            text: "Daftar di sini.",
                            style: const TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                                fontSize: 16),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, '/signup');
                              }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
