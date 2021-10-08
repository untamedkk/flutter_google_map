import 'package:flutter/material.dart';
import 'package:map_example/model/poeple_list.dart';
import 'package:map_example/widgets/card_widget.dart';
import 'package:map_example/widgets/people_mapview_widget.dart';

class PersonDetailsScreen extends StatelessWidget {
  final People people;

  PersonDetailsScreen(this.people);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(people.name.first + ' ' + people.name.last),
      ),
      body: Center(
          child: Stack(
        children: [
          PeopleMapViewWidget(
            [people],
            enableMarkerClick: false,
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Wrap(
                children: [
                  CardWidget(
                    people: people,
                    showEmail: true,
                    onItemClick: () => {
                      /*ignore*/
                    },
                  ),
                ],
              ))
        ],
      )),
    );
  }

  static void open(BuildContext context, People people) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PersonDetailsScreen(people)),
      );
}
