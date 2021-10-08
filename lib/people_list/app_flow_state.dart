import 'package:equatable/equatable.dart';
import 'package:map_example/model/poeple_list.dart';

class AppFlowState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitApp extends AppFlowState {}

class FetchingPeopleList extends AppFlowState {}

class PostPeopleListSuccess extends AppFlowState {
  final Peoples peopleList;

  PostPeopleListSuccess(this.peopleList);
}

class PostPeopleListFailed extends AppFlowState {
  PostPeopleListFailed();
}
