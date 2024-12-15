import 'package:flutter/material.dart';
import 'package:wisata_candi_rafael_eben_hart/screens/favorite_screen.dart';
import 'package:wisata_candi_rafael_eben_hart/screens/home_screen.dart';
import 'package:wisata_candi_rafael_eben_hart/screens/profile_screen.dart';
import 'package:wisata_candi_rafael_eben_hart/screens/search_screen.dart';
import 'package:wisata_candi_rafael_eben_hart/screens/sign_in_screen.dart';
import 'package:wisata_candi_rafael_eben_hart/screens/sign_up_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wisata Candi',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.deepPurple),
          titleTextStyle: TextStyle(
            color: Colors.deepPurple,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(),
      initialRoute: '/',
      routes: {
        '/homescreen': (context) => const HomeScreen(),
        '/signin' : (context) => const SignInScreen(),
        '/signup' : (context) => SignUpScreen(),
      },
      //home: ProfileScreen(),
      //home: DetailScreen(candi: candiList[0]),
      //home: SignInScreen(),
      //home: SignUpScreen(),
      //home: SearchScreen(),
      //home: HomeScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //Todo: 1.Deklarasi variabel
  int _currentIndex = 0;
  final List<Widget> _children = [
    const HomeScreen(),
    const SearchScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Todo: 2.body
      body: _children[_currentIndex],
      //todo: 3.BottomNavigatorBar
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.deepPurple[50]),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex=index;
              });
            },
            //Todo: 4.data child theme
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Colors.deepPurple,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                    color: Colors.deepPurple,
                  ),
                  label: "Search"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.deepPurple,
                  ),
                  label: "Favorite"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    color: Colors.deepPurple,
                  ),
                  label: "Person"),
            ],
            selectedItemColor: Colors.deepPurple,
            unselectedItemColor: Colors.deepPurple[100],
            showSelectedLabels: true,
          )),
    );
  }
}

