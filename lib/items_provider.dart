import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tca/api/api.dart';
import 'package:tca/model/bread.dart';

part 'items_provider.g.dart';

@riverpod
class CatStream extends _$CatStream {
  late ApiService _apiService;
  final List<CatBreed> _allItems = [];
  int _currentPage = 1;
  final int _limit = 20;
  bool _hasMore = true;
  bool _isLoading = false;

  @override
  Stream<List<CatBreed>> build() async* {
    _apiService = ApiService();
    yield* _fetchItems();
  }

  Stream<List<CatBreed>> _fetchItems() async* {
    while (_hasMore) {
      if (_isLoading) return;
      _isLoading = true;

      try {
        final result = await _apiService.fetchItems(_currentPage, _limit);
        if (result.isEmpty) {
          _hasMore = false;
        } else {
          _allItems.addAll(result);
          _currentPage++;
          yield List<CatBreed>.from(_allItems);
        }
      } catch (e) {
        yield* Stream.error(e);
      } finally {
        _isLoading = false;
      }
    }
  }

  void loadMore() {
    if (!_isLoading && _hasMore) {
      // Forzar la reconstrucción para cargar más datos
      ref.invalidateSelf();
    }
  }

  bool get hasMore => _hasMore;
}

final selectedCatBreedProvider = StateProvider<CatBreed?>((ref) => null);
