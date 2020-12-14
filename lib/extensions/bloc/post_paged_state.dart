import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:equatable/equatable.dart';

enum PostPagedStatus { initial, success, failure }

class PostPagedState extends Equatable {
  const PostPagedState({
    this.status = PostPagedStatus.initial,
    this.values = const <PostModel>[],
    this.hasReachedMax = false,
    this.lastRowFetched
  });

  final PostPagedStatus status;
  final List<PostModel> values;
  final bool hasReachedMax;
  final Object lastRowFetched;

  PostPagedState copyWith({
    PostPagedStatus status,
    List<PostModel> values,
    bool hasReachedMax,
    Object lastRowFetched,
  }) {
    return PostPagedState(
      status: status ?? this.status,
      values: values ?? this.values,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      lastRowFetched: lastRowFetched?? this.lastRowFetched,
    );
  }

  @override
  List<Object> get props => [status, values, hasReachedMax, lastRowFetched];
}
