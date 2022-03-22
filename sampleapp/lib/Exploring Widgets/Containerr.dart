import 'package:flutter/material.dart';

class containerr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            color: Colors.blueGrey,
            margin: EdgeInsets.all(20),
            child: Text(
              "Checking the Ui offlutter ",
              textAlign: TextAlign.start,
              style: TextStyle(
                  backgroundColor: Colors.transparent,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  decoration: TextDecoration.none),
            ),
          ),
          containerr(),
          Container(
              alignment: Alignment.center,
              color: Colors.blueGrey,
              margin: EdgeInsets.all(20),
              child: Text(
                "Checking the Ui 2 ",
                textAlign: TextAlign.start,
                style: TextStyle(
                    backgroundColor: Colors.transparent,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    decoration: TextDecoration.none),
              )),
          Container(
              alignment: Alignment.center,
              color: Colors.blueGrey,
              margin: EdgeInsets.all(20),
              child: ElevatedButton(
                child: Text("Book Your Flight"),
                onPressed: () {
                  bookflight(context);
                },
              )),
          Text(
            "List View Check ",
            textAlign: TextAlign.start,
            style: TextStyle(
                backgroundColor: Colors.transparent,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                fontSize: 20,
                decoration: TextDecoration.none),
          ),
        ],
      ),
    );
  }

  void bookflight(BuildContext context) {
    var alertdialog = AlertDialog(
      title: Text("Success"),
      content: Text("Have save flight "),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertdialog;
        });
  }

  Widget getlistview() {
    var listview = ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.landscape),
          title: Text("Landscape"),
          subtitle: Text("Beautiful scenoric beauty"),
          trailing: Icon(Icons.wb_cloudy),
        ),
        ListTile(
          leading: Icon(Icons.window),
          title: Text("Phone"),
          subtitle: Text("Beautiful scenoric beauty"),
          trailing: Icon(Icons.wb_cloudy),
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text("Window"),
          subtitle: Text("Beautiful scenoric beauty"),
          trailing: Icon(Icons.wb_cloudy),
        ),
      ],
    );

    return listview;
  }
}
