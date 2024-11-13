import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tca/items_provider.dart';
import 'package:tca/widget/cat_card.dart';
import 'package:tca/widget/cat_search.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  late ScrollController _scrollController;
  late CatStream catStreamNotifier;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    catStreamNotifier = ref.read(catStreamProvider.notifier);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      catStreamNotifier.loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final catStream = ref.watch(catStreamProvider);

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Cat Breeds'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: CatSearchDelegate());
                  // showSearch(context: context, delegate: CatSearchDelegate());
                },
              ),
            ],
          ),
          body: catStream.when(
            data: (items) {
              return ListView.builder(
                shrinkWrap: true,
                controller: _scrollController,
                itemCount: items.length + (catStreamNotifier.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < items.length) {
                    return GestureDetector(
                        onTap: () {
                          ref.read(selectedCatBreedProvider.notifier).state =
                              items[index];
                          Navigator.of(context).pushNamed('/detail');
                        },
                        child: CatCard(catBreed: items[index]));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
          )),
    );
  }
}
