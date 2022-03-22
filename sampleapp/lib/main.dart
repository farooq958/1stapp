import 'package:flutter/material.dart';

import 'package:sampleapp/Exploring%20Widgets/Notekkeeping.dart';
//import 'package:sampleapp/Exploring%20Widgets/Simplecalculator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notekeeper App ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // brightness: Brightness.dark,
          primarySwatch: Colors.indigo,
          accentColor: Colors.indigoAccent),
      home: noteslist(),

      /*Scaffold(
          body: getlonglist(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              debugPrint('Fab Clicked');
            },
            child: Icon(Icons.add),
            tooltip: 'Add One More Item',
          )),*/
    );

    //MyFadeTest(
    // title: 'Fade Demo',
    //  key: GlobalKey(),
  }

  void Showsnackbar(BuildContext context, String item) {
    var snackbarr = SnackBar(
      content: Text('You just Tapped The $item'),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {
          debugPrint('Performing Dummy Operation');
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbarr);
  }

  List<String> Listofnumber() {
    var itemss = List<String>.generate(1000, (index) => "Item $index");
    return itemss;
  }

  Widget getlonglist() {
    var listitems = Listofnumber();
    var listttview = ListView.builder(
        itemCount: listitems.length,
        itemBuilder: (context, index) {
          return SizedBox(
            child: ListTile(
              leading: Icon(Icons.arrow_right),
              title: Text(listitems[index]),
              trailing: Icon(Icons.arrow_back_sharp),
              onTap: () {
                Showsnackbar(context, listitems[index]);
              },
            ),
          );
        });
    return listttview;
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

class Favouritecity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _favouritecity();
  }
}

class _favouritecity extends State<Favouritecity> {
  String namecity = "";
  var _currencies = ['Rupees', 'Pound', 'Dollar'];
  String? currentitem = 'Rupees';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Statefull example"),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (String userinput) {
              setState(() {
                namecity = userinput;
              });
            },
          ),
          DropdownButton<String>(
            items: _currencies.map((String dropdownstringitem) {
              return DropdownMenuItem<String>(
                  value: dropdownstringitem, child: Text(dropdownstringitem));
            }).toList(),
            onChanged: (String? NewValue) {
              setState(() {
                this.currentitem = NewValue;
              });
            },
            value: currentitem,
          ),
          Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Your Next city is ' + namecity,
                style: TextStyle(fontSize: 20.0),
              )),
        ],
      ),
    );
  }
}

class MyFadeTest extends StatefulWidget {
  MyFadeTest({required Key key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyFadeTest createState() => _MyFadeTest();
}

class _MyFadeTest extends State<MyFadeTest> with TickerProviderStateMixin {
  late AnimationController controller;
  late CurvedAnimation curve;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    curve = CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Container(
              child: FadeTransition(
                  opacity: curve,
                  child: FlutterLogo(
                    size: 100.0,
                  )))),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Fade',
        child: Icon(Icons.brush),
        onPressed: () {
          controller.forward();
        },
      ),
    );
  }
}
