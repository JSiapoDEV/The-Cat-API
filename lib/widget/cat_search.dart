import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tca/api/api.dart';
import 'package:tca/items_provider.dart';
import 'package:tca/model/bread.dart';

class CatSearchDelegate extends SearchDelegate<Future<CatBreed?>?> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // return const Text('Search Results');
    if (query.length >= 2) {
      return Consumer(
        builder: (context, ref, child) => FutureBuilder<List<CatBreed>>(
          future: ApiService().searchItems(query),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error al buscar'),
              );
            }
            if (snapshot.hasData) {
              return snapshot.data == null
                  ? const Center(
                      child: Text('No se encontraron resultados'),
                    )
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        final item = snapshot.data![index];
                        return ListTile(
                          title: Text(item.name ?? ''),
                          onTap: () {
                            ref.read(selectedCatBreedProvider.notifier).state =
                                item;
                                Navigator.of(context).pushNamed('/detail');
                            // close(context, Future.value(item));
                          },
                        );
                      },
                      itemCount: snapshot.data!.length,
                    );
            }
            return const Center(
              child: Text('No se encontraron resultados'),
            );
          },
        ),
      );
    }
    return const Center(
      child: Text('Por favor, ingresa al menos 2 caracteres para buscar'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox();
  }
}
