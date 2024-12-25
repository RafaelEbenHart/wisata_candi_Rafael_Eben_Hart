import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // TODO: 1. Deklarasikan variabel
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  String _errorText = '';


  bool _obscurePassword = true;

  Future<Map<String, String>> _retrieveAndDecryptDataFromPrefs(
      SharedPreferences prefs)
  async{
    final sharedPreferences = prefs;
    final encryptedUsername = sharedPreferences.getString('username')?? '';
    final encryptedPassword = sharedPreferences.getString('password')?? '';
    final keyString = sharedPreferences.getString('key')?? '';
    final ivString = sharedPreferences.getString('iv')?? '';
    final encrypt.Key key = encrypt.Key.fromBase64(keyString);
    final iv = encrypt.IV.fromBase64(ivString);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final decrytedUsername = encrypter.decrypt64(encryptedUsername, iv: iv);
    final decryptedPassword = encrypter.decrypt64(encryptedPassword, iv: iv);
    //mengembalikan data terdekripsi
    return{'username': decrytedUsername, 'password':decryptedPassword};
  }
  void _signIn() async {
    try{
      final Future<SharedPreferences> prefsFuture = SharedPreferences.getInstance();
      final String username = _usernameController.text;
      final String password = _passwordController.text;
      if (username.isNotEmpty && password.isNotEmpty) {
        final SharedPreferences prefs = await prefsFuture;
        final data = await _retrieveAndDecryptDataFromPrefs(prefs);
        if (data.isNotEmpty) {
          final decryptedUsername = data['username'];
          final decryptedPassword = data['password'];
          if (username == decryptedUsername && password == decryptedPassword) {
            _errorText = '';
            prefs.setBool('isSignedIn', true);
            // pemanggil untuk menghapus semua halaman dalam tumpukan navigasi
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).popUntil((route) => route.isFirst);
            });
            //sign in berhasil, navigasikan ke layar utama
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, '/');
            });
          } else {
          }
        } else {
        }
      }else{
      }
    }catch(e){
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: 2. Pasang AppBar
      appBar: AppBar(title: const Text('Sign In')),
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
                    // TODO: 5. Pasang TextFormField Nama Pengguna
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: "Nama Pengguna",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    // TODO: 6. Pasang TextFormField Kata Sandi
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
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                      obscureText: _obscurePassword,
                    ),
                    // TODO: 7. Pasang ElevatedButton Sign In
                    const SizedBox(height: 20),
                    ElevatedButton(onPressed: () {_signIn();}, child: const Text('Sign In')),
                    // TODO: 8.Pasang TextButton Sign Up
                    const SizedBox(height: 10),
                    // TextButton(
                    //     onPressed: (){},
                    //     child: Text('Belum punya akun? Daftar di sini')),
                    RichText(
                        text: TextSpan(
                            text: 'Belum punya akun?',
                            style:
                            const TextStyle(fontSize: 16, color: Colors.deepPurple),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Daftar di sini.',
                                style: const TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                    fontSize: 16),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, '/signup');
                                  },
                              )
                            ]))
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
