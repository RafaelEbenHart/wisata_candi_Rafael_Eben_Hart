import 'package:flutter/material.dart';
import 'package:wisata_candi_rafael_eben_hart/data/candi_data.dart';
import '../models/candi.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  //todo 1.deklarasi variabel
  List<Candi> _filteredcandis = candiList;
  String _seaarchQuer = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //todo 2.appbar pencarian candi
      appBar: AppBar(
        title: const Text("pencarian Candi"),
      ),
      //todo 3.body & column
      body: Column(
        children: [
          //todo 4.textfeild
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.deepPurple),
              child: const TextField(
                autofocus: false,
                decoration: InputDecoration(
                  hintText: "Cari Candi",
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
          ),
          //todo 5.listview
          Expanded(
            child: ListView.builder(
                itemCount: _filteredcandis.length,
                itemBuilder: (context, index) {
                  final candi = _filteredcandis[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          width: 100,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                            candi.imageAsset,
                            fit: BoxFit.cover,
                          ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(candi.name,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                              const SizedBox(height: 4,),
                              Text(candi.location),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
