import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:map_example/model/poeple_list.dart';
import 'package:map_example/people_list/api_provider.dart';
import 'package:map_example/people_list/api_repository.dart';
import 'package:map_example/people_list/app_flow_bloc.dart';
import 'package:map_example/people_list/app_flow_event.dart';
import 'package:map_example/people_list/app_flow_state.dart';
import 'package:map_example/people_list/http_exception.dart';
import 'package:mockito/mockito.dart';

class MockApiRepository extends Mock implements ApiRepository {}

class MockApiProvider extends Mock implements ApiProvider {}

void main() {
  MockApiRepository apiRepository;
  MockApiProvider apiProvider;
  AppFlowBloc appFlowBloc;

  final String testData =
      '[{"_id": "id1","name": {"last": "a","first": "b"},"email": "c@undefined.com","picture": "http://placehold.it/175x244","location": {"latitude": 22.3417661,"longitude": null}},{"_id": "875e27dc-7836-4208-9f5f-87c31d64ba0e","name": {"last": "Diaz","first": "Janice"},"email": "janice.diaz@undefined.us","picture": "http://placehold.it/56x210","location": {"latitude": 22.3557118,"longitude": null}},{"_id": "4488f53c-0d67-4f11-9bff-1b970df2a2e3","name": {"last": "Harrington","first": "Hilda"},"email": "hilda.harrington@undefined.io","picture": "http://placehold.it/180x218","location": {"latitude": 22.3479143,"longitude": 113.698436}}]';

  setUp(() {
    apiRepository = MockApiRepository();
    apiProvider = MockApiProvider();

    appFlowBloc = AppFlowBloc(apiRepository);
  });

  tearDown(() {
    appFlowBloc.close();
  });

  test('test init bloc', () async {
    expect(appFlowBloc.initialState, InitApp());
  });

  test('test fetch people list bloc success', () {
    when(apiRepository.getPeopleList())
        .thenAnswer((_) async => Peoples.fromJson(json.decode(testData)));
    appFlowBloc.add(FetchPeopleList());
    expectLater(appFlowBloc, emitsInOrder([
      InitApp(),
      FetchingPeopleList(),
      PostPeopleListSuccess(Peoples.fromJson(json.decode(testData)))
    ]));
  });

  test('test fetch people list bloc failed', () {
    when(apiRepository.getPeopleList())
        .thenAnswer((_) async => throw HttpException(404, 'message'));
    appFlowBloc.add(FetchPeopleList());
    expectLater(appFlowBloc, emitsInOrder([
      InitApp(),
      FetchingPeopleList(),
      PostPeopleListFailed()
    ]));
  });
}
