import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tca/items_provider.dart';
import 'package:tca/model/bread.dart';
import 'package:tca/widget/cat_card.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCat = ref.watch(selectedCatBreedProvider);
    if (selectedCat == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedCat.name ?? ""),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ShimmerImage(
              imageUrl:
                  "https://cdn2.thecatapi.com/images/${selectedCat.referenceImageId}.jpg",
              height: 300,
              tag: selectedCat.id ?? "",
            ),
            Expanded(child: ListOfDetails(info: selectedCat)),
            // ListOfDetails(info: selectedCat),
          ],
        ),
      ),
    );
  }
}

class ListOfDetails extends StatelessWidget {
  final CatBreed info;
  const ListOfDetails({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return ListView(physics: const BouncingScrollPhysics(), children: [
      ListTile(
        title: const Text("Nombre"),
        subtitle: Text(info.name ?? ""),
      ),
      ListTile(
        title: const Text("Origen"),
        subtitle: Text(info.origin ?? ""),
      ),
      ListTile(
        title: const Text("Esperanza de vida"),
        subtitle: Text(info.lifeSpan ?? ""),
      ),
      ListTile(
        title: const Text("Descripción"),
        subtitle: Text(info.description ?? ""),
      ),
      ListTile(
        title: const Text("Temperamento"),
        subtitle: Text(info.temperament ?? ""),
      ),
      ListTile(
        title: const Text("Peso"),
        subtitle: Text(info.weight?.metric ?? ""),
      ),
      ListTile(
        title: const Text("Altura"),
        subtitle: Text(info.weight?.imperial ?? ""),
      ),

      ListTile(
        title: const Text("País"),
        subtitle: Text(info.origin ?? ""),
      ),
      
    ]);
  }
}
