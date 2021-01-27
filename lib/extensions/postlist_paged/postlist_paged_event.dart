import 'package:eliud_pkg_feed/model/post_model.dart';
import 'package:equatable/equatable.dart';

abstract class PostPagedEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PostListPagedFetched extends PostPagedEvent {
  PostListPagedFetched();
}

class DeletePostPaged extends PostPagedEvent {
  final PostModel value;

  DeletePostPaged({ this.value });

  @override
  List<Object> get props => [ value ];
}