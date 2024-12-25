import 'package:flutter/material.dart';
import 'package:wisata_candi_rafael_eben_hart/data/candi_data.dart';
import 'package:wisata_candi_rafael_eben_hart/widgets/item_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Todo 1.appbar
      appBar: AppBar(
        title: const Text("Wisata Candi"),
      ),
      // Todo 2.body gridview.builder
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          padding: const EdgeInsets.all(8),
          itemCount: candiList.length,
          itemBuilder: (context, index) {
            // Todo 3.itemcard
              return ItemCard(candi: candiList[index],
              );
          }),
    );
  }
}
