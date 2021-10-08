import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_example/model/poeple_list.dart';
import 'package:map_example/people_list/api_provider.dart';
import 'package:map_example/people_list/api_repository.dart';
import 'package:map_example/people_list/app_flow_bloc.dart';
import 'package:map_example/people_list/app_flow_state.dart';

import '../widgets/people_listview_widget.dart';
import '../widgets/people_mapview_widget.dart';
import 'app_flow_event.dart';

class PeopleListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PeopleListScreenState();
}

class _PeopleListScreenState extends State<PeopleListScreen> {
  final String _title = 'Google Map Example';

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ApiRepository>(
      create: (context) {
        return ApiRepository(ApiProvider());
      },
      child: BlocProvider<AppFlowBloc>(
        create: (context) {
          final _apiRepository = RepositoryProvider.of<ApiRepository>(context);
          return AppFlowBloc(_apiRepository)..add(FetchPeopleList());
        },
        child: BlocConsumer<AppFlowBloc, AppFlowState>(
          listener: (context, state) {
            if (state is PostPeopleListFailed) {
              _showErrorDialog(context);
            }
          },
          builder: (context, state) {
            return _getBodyWidget(state);
          },
        ),
      ),
    );
  }

  Widget _getBodyWidget(AppFlowState state) => Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: (state is PostPeopleListSuccess)
          ? _getChildren(state.peopleList)
          : _getLoadingWidget(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.list),
            label: 'List View',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.map),
            label: 'Map View',
          ),
        ],
      ));

  Widget _getLoadingWidget() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [CircularProgressIndicator()])
        ]);
  }

  Widget _getChildren(Peoples peoples) => _selectedIndex == 0
      ? PeopleListViewWidget(peoples)
      : PeopleMapViewWidget(peoples.peoples);

  void _onTabTapped(int index) => setState(() {
        _selectedIndex = index;
      });

  void _showErrorDialog(BuildContext _context) {
    final fontFamily = DefaultTextStyle.of(_context).style.fontFamily;
    final style = TextStyle(fontFamily: fontFamily);
    showDialog(
      barrierDismissible: false,
      context: _context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Something went wrong!',
              style: Theme.of(_context).textTheme.subtitle1.copyWith(
                    color: Color(0xFF000000),
                  )),
          content: Text('Please tap on retry in order to refresh the data.',
              style: Theme.of(_context).textTheme.bodyText2.copyWith(
                    color: Color(0xFF000000),
                  )),
          actions: [
            CupertinoDialogAction(
                child: Text('Retry', style: style),
                isDefaultAction: true,
                onPressed: () {
                  BlocProvider.of<AppFlowBloc>(_context).add(FetchPeopleList());
                  Navigator.of(context).pop();
                })
          ],
        );
      },
    );
  }
}
