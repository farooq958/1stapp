import 'package:flutter/material.dart';

class simplecalc extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => simplecal();
}

class simplecal extends State<simplecalc> {
  var _currencies = ['Rupees', 'Pound', 'Dollar'];
  final minimumpadding = 5.0;
  String? currentitem = 'Rupees';
  TextEditingController principalcontroller = TextEditingController();
  TextEditingController roicontroller = TextEditingController();
  TextEditingController Termcontroller = TextEditingController();
  String displayresult = '';
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Simple Interest Calculator"),
      ),
      body: Form(
        key: formkey,
        child: Padding(
          padding: EdgeInsets.all(minimumpadding * 2),
          child: ListView(
            children: <Widget>[
              getimageassest(),
              TextFormField(
                validator: (String? value) {
                  if (value == "") {
                    return "Please enter a valid amount";
                  }
                },
                controller: principalcontroller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.yellowAccent),
                    hintText: 'Enter A princpal Amount',
                    labelText: 'Principal',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
              SizedBox(
                width: minimumpadding,
                height: minimumpadding,
              ),
              TextField(
                controller: roicontroller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'In Percent',
                    labelText: 'Rate Of Interest',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
              SizedBox(
                width: minimumpadding,
                height: minimumpadding,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: TextField(
                    controller: Termcontroller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'Time In Years',
                        labelText: 'Term',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
                  SizedBox(width: minimumpadding * 5),
                  Expanded(
                      child: DropdownButton<String>(
                    items: _currencies.map((String dropdownstringitem) {
                      return DropdownMenuItem<String>(
                          value: dropdownstringitem,
                          child: Text(dropdownstringitem));
                    }).toList(),
                    onChanged: (String? NewValue) {
                      setState(() {
                        this.currentitem = NewValue;
                      });
                    },
                    value: currentitem,
                  )),
                  SizedBox(
                    width: minimumpadding,
                    height: minimumpadding,
                  ),
                ],
              ),
              Row(children: [
                Expanded(
                    child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.indigoAccent),
                      textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                          color: Theme.of(context).primaryColorDark))),
                  onPressed: () {
                    setState(() {
                      if (formkey.currentState!.validate()) {
                        displayresult = calculateinterest();
                      }
                    });
                  },
                  child: Text("Calculate"),
                )),
                SizedBox(
                  width: minimumpadding,
                ),
                Expanded(
                    child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                          color: Theme.of(context).primaryColorLight))),
                  onPressed: () {
                    setState(() {
                      reste();
                    });
                  },
                  child: Text("Reset"),
                ))
              ]),
              SizedBox(
                width: minimumpadding * 2,
                height: minimumpadding * 2,
              ),
              Text(
                displayresult,
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getimageassest() {
    AssetImage assetImage = AssetImage('images/money1.jpg');
    Image image = Image(image: assetImage, width: 150.0, height: 150.0);
    return Container(
      child: image,
      margin: EdgeInsets.all(minimumpadding * 10),
    );
  }

  String calculateinterest() {
    double principle = double.parse(principalcontroller.text);
    double roii = double.parse(roicontroller.text);
    double terrm = double.parse(Termcontroller.text);
    double fcalculate = principle + (principle * roii * terrm) / 100;
    String result =
        'After $terrm Your Investment will be worth of $fcalculate $currentitem';
    return result;
  }

  void reste() {
    principalcontroller.text = '';
    roicontroller.text = '';
    Termcontroller.text = '';
    displayresult = '';
    currentitem = _currencies[0];
  }
}
