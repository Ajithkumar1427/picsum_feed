abstract class FeedEvent {}

class LoadFeed extends FeedEvent {
  final bool isRefresh;

  LoadFeed({this.isRefresh = false});
}
