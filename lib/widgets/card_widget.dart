import 'package:flutter/material.dart';
import 'package:map_example/model/poeple_list.dart';

class CardWidget extends StatelessWidget {
  final People people;
  final VoidCallback onItemClick;
  final bool showEmail;

  CardWidget({this.people, this.onItemClick, this.showEmail = false});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        child: InkWell(
            onTap: () => onItemClick(),
            child: Container(
                child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundImage: NetworkImage(this.people.picture),
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 8, 0)),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              this.people.name.first +
                                  ' ' +
                                  this.people.name.last,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                            Text(showEmail ? this.people.email : ''),
                          ],
                        ),
                      ],
                    )))));
  }
}
