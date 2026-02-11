import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/network.dart';
import '../model/picsum_model.dart';
import 'feed_event.dart';
import 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc() : super(FeedInitial()) {
    on<LoadFeed>(_loadFeed);
  }

  int page = 1;
  bool hasReachedMax = false;
  List<PicsumModel> images = [];
  bool isFetching = false;

  static const int limit = 15;

  Future<void> _loadFeed(
      LoadFeed event, Emitter<FeedState> emit) async {
    if (isFetching) return;
    if (hasReachedMax && !event.isRefresh) return;

    isFetching = true;

    if (event.isRefresh) {
      page = 1;
      hasReachedMax = false;
      images.clear();
      emit(FeedLoading());
    }

    try {
      final response =
          await apiService.fetchImages(page, limit);

      final newImages = response
          .map((e) => PicsumModel.fromJson(e))
          .toList();

      if (newImages.isEmpty) {
        hasReachedMax = true;
      } else {
        images.addAll(newImages);
        page++;
      }

      emit(FeedLoaded(
        images: images,
        hasReachedMax: hasReachedMax,
      ));
    } catch (_) {
      emit(FeedError());
    }

    isFetching = false;
  }
}
