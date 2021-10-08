import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:map_example/people_list/api_repository.dart';
import 'package:map_example/people_list/app_flow_event.dart';
import 'package:map_example/people_list/app_flow_state.dart';

class AppFlowBloc extends Bloc<AppFlowEvent, AppFlowState> {
  final ApiRepository _apiRepository;

  AppFlowBloc(this._apiRepository);

  @override
  AppFlowState get initialState => InitApp();

  @override
  Stream<AppFlowState> mapEventToState(AppFlowEvent event) async* {
    if (event is FetchPeopleList) {
      yield FetchingPeopleList();
      try {
        var response = await _apiRepository.getPeopleList();
        yield PostPeopleListSuccess(response);
      } catch (err) {
        debugPrint('Unable to fetch the data.');
        yield PostPeopleListFailed();
      }
    }
  }
}
