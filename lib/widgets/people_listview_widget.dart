import 'package:flutter/material.dart';
import 'package:map_example/model/poeple_list.dart';
import 'package:map_example/person_details/person_details_screen.dart';

import 'card_widget.dart';

class PeopleListViewWidget extends StatelessWidget {
  final Peoples peoples;

  PeopleListViewWidget(this.peoples);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.peoples.peoples.length,
      itemBuilder: (context, index) {
        return CardWidget(
          people: this.peoples.peoples[index],
          onItemClick: () =>
              PersonDetailsScreen.open(context, this.peoples.peoples[index]),
        );
      },
    );
  }
}
