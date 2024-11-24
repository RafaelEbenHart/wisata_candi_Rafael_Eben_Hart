import 'package:flutter/material.dart';
import '../data/candi_data.dart';
import '../models/candi.dart';
import '../screens/detail_screens.dart';

class ItemCard extends StatelessWidget {

  final Candi candi;

  const ItemCard({super.key, required this.candi});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(candi: candi)));
      },
      child: Card(
          //todo 2.parameter shape,margin,elavation
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          margin: const EdgeInsets.all(4),
          elevation: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //todo 3.Image
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    candi.imageAsset,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              //todo 4.Text
              Padding(
                padding: const EdgeInsets.only(left: 16,top: 8),
                child: Text(candi.name,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              ),
              //todo 5.Text
              Padding(
                padding: const EdgeInsets.only(left: 16,top: 8),
                child: Text(candi.type,style: const TextStyle(fontSize: 12),),
              )
            ],
          ),
        ),
    );
  }
}
