import 'package:flutter/material.dart';

class AtAGlance extends StatefulWidget {
  @override
  _AtAGlanceState createState() => _AtAGlanceState();
}

class _AtAGlanceState extends State<AtAGlance> {
  final title = 'Mixed List';
  List<ListItem> items;

  //List<String> events = [];

  @override
  void initState() {
    // TODO: implement initState

    items = List<ListItem>.generate(
      3,
          (i) => i == 0
          ? HeadingItem("Coming next (coming soon)")
          : MessageItem("Event $i", "Event body $i"),
    );

    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        //physics: const AlwaysScrollableScrollPhysics(),
        //scrollDirection: Axis.vertical,
        shrinkWrap: true,
        // Let the ListView know how many items it needs to build.
        itemCount: items.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          final item = items[index];

          return ListTile(
            title: item.buildTitle(context),
            subtitle: item.buildSubtitle(context),
          );
        },
      ),
    );
  }
}


/////////////////////


/// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);
}

/// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.headline5,
    );
  }

  Widget buildSubtitle(BuildContext context) => null;
}

/// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);

  Widget buildTitle(BuildContext context) {
    return Text(
      sender,
      //style: Theme.of(context).textTheme.headline6,
    );
  }

  Widget buildSubtitle(BuildContext context) => Text(body);
}
