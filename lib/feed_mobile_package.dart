import 'feed_package.dart';

FeedPackage getFeedPackage() => FeedMobilePackage();

class FeedMobilePackage extends FeedPackage {
  @override
  List<Object?> get props => [];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedMobilePackage && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}
