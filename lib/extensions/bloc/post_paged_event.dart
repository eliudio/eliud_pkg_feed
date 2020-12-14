import 'package:equatable/equatable.dart';

abstract class PostPagedEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PostPagedFetched extends PostPagedEvent {}
