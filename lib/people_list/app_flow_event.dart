import 'package:equatable/equatable.dart';

class AppFlowEvent extends Equatable {
  @override
  List<Object> get props => [];
}


class StartAppFlow extends AppFlowEvent {}

class FetchPeopleList extends AppFlowEvent {}
