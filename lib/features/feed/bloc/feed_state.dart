import '../model/picsum_model.dart';

abstract class FeedState {}

class FeedInitial extends FeedState {}

class FeedLoading extends FeedState {}

class FeedLoaded extends FeedState {
  final List<PicsumModel> images;
  final bool hasReachedMax;

  FeedLoaded({
    required this.images,
    required this.hasReachedMax,
  });
}

class FeedError extends FeedState {}
