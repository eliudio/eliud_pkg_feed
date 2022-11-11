import 'feed_package.dart';

FeedPackage getFeedPackage() => FeedWebPackage();

class FeedWebPackage extends FeedPackage {
  @override
  void init() {
    super.init();
  }

  @override
  List<Object?> get props => [
  ];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is FeedWebPackage &&
              runtimeType == other.runtimeType;
}
