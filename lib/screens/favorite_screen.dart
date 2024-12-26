import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wisata_candi_rafael_eben_hart/data/candi_data.dart';
import '../models/candi.dart';
import '../screens/detail_screens.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  bool isSignedIn = false;
  List<Candi> favoriteCandis = [];

  @override
  void initState() {
    super.initState();
    _checkSignInStatus();
  }

  void _checkSignInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool signedIn = prefs.getBool('isSignedIn') ?? false;
    setState(() {
      isSignedIn = signedIn;
    });
    if (signedIn) {
      _loadFavoriteItems();
    }
  }
  
  void _loadFavoriteItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedCandis = prefs.getStringList('favorites') ?? [];
    setState(() {
      favoriteCandis = candiList.where(
            (candi) => savedCandis.contains(candi.name),
      ).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Candi Favorit"),
      ),
      body: isSignedIn
          ? (favoriteCandis.isEmpty
          ? const Center(
        child: Text(
          "Belum Ada Candi Favorit",
          style: TextStyle(
            color: Colors.deepPurple,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      )
          : Column(
        children: [
          const SizedBox(height: 10),
          SizedBox(
            height: 535,
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: favoriteCandis.length,
              itemBuilder: (context, index) {
                Candi candi = favoriteCandis[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(
                          candi: candi,
                        ),
                      ),
                    ).then((_) {
                      _loadFavoriteItems();
                    });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: candi.imageUrls[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ))
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Sign in terlebih dahulu",
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signin');
              },
              child: const Text(
                "Klik Disini",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
