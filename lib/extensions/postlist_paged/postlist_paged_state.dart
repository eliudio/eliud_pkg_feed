import 'package:eliud_pkg_post/model/post_model.dart';
import 'package:equatable/equatable.dart';

enum PostListPagedStatus { initial, success, failure }

class PostListPagedState extends Equatable {
  const PostListPagedState({
    this.status = PostListPagedStatus.initial,
    this.values = const <PostModel>[],
    this.hasReachedMax = false,
    this.lastRowFetched
  });

  final PostListPagedStatus status;
  final List<PostModel?> values;
  final bool hasReachedMax;
  final Object? lastRowFetched;

  PostListPagedState copyWith({
    PostListPagedStatus? status,
    List<PostModel?>? values,
    bool? hasReachedMax,
    Object? lastRowFetched,
  }) {
    return PostListPagedState(
      status: status ?? this.status,
      values: values ?? this.values,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      lastRowFetched: lastRowFetched?? this.lastRowFetched,
    );
  }

  @override
  List<Object?> get props => [status, values, hasReachedMax, lastRowFetched];
}
