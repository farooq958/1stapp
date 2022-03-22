

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sampleapp/Model/Note.dart';
import 'package:sampleapp/Utilities/database_helper.dart';


class notedetails extends StatefulWidget {
  final String? apptitle;
  final Note note;
  notedetails( this.note,this.apptitle);
  
  @override
  State<StatefulWidget> createState() {
    return notedetailsstate(this.note,this.apptitle);
  }
}

class notedetailsstate extends State<notedetails> {
  var priorities = ['High', 'Low'];
  var Titlecontroller = TextEditingController();
  var DescriptionController = TextEditingController();
  DatabaseHelper helper = DatabaseHelper();

final String? apptitle;
final Note note;
  notedetailsstate(this.note,this.apptitle);
 

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme.headline6;
  
   return WillPopScope(
      onWillPop:  () async
      {
        bool? rest = await movetolastscreenonwil();
       // if(rest == true )
       // {
       //   Navigator.pop(context);
       // }
       print('from will');
        return rest!;
        //return movetolastscreenonwil()
      },
    child : Scaffold(
      appBar: AppBar(
        title: Text(apptitle!),
        leading :IconButton(icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          return movetolastscreen();
        },)
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: [
            ListTile(
              title: DropdownButton(
                items: priorities.map((String dropdownitems) {
                  return DropdownMenuItem<String>(
                    child: Text(dropdownitems),
                    value: dropdownitems,
                  );
                }).toList(),
                style: theme,
                value: getPriorityAsString(note.priority),
                onChanged: (valueselectedbyuser) {
                  setState(() {
                    print('User selected $valueselectedbyuser');
                    updatePriorityAsInt(valueselectedbyuser.toString());
                  });
                },
              ),
            ),
            SizedBox(
              width: 15.0,
              height: 15.0,
            ),
            TextField(
              controller: Titlecontroller,
              decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.yellowAccent),
                  labelText: 'Title',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              onChanged: (value) {
                print('something change i.e $value');
               setState(() {
                  updateTitle();
               });
               
              },
            ),
            SizedBox(
              width: 10,
              height: 10,
            ),
            TextField(
              controller: DescriptionController,
              decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter the detail description',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              onChanged: (value) {
                print('something change in description field i.e $value');
               setState(() {
                  updateDescription();
               });
               
              },
            ),
            SizedBox(
              height: 10,
              width: 10,
            ),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                  child: Text('Save'),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.deepPurple),
                      textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                          color: Theme.of(context).primaryColorDark))),
                  onPressed: () {
                    setState(() {
                      print('save button');
                    save();
                    });
                  },
                )),
                SizedBox(
                  width: 10,
                  height: 10,
                ),
                Expanded(
                    child: ElevatedButton(
                  child: Text('Delete'),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                          color: Theme.of(context).primaryColorLight))),
                  onPressed: () {
                    setState(() {
                      print('Delte button');
                      _delete();
                    });
                  },
                ))
              ],
            )
          ],
        ),
      ),
    ));
  }

  
void  movetolastscreen() {
    Navigator.pop(context,true);


  }

  Future<bool>? movetolastscreenonwil() async {

Navigator.of(context).pop(true);

return true;
}
// Convert the String priority in the form of integer before saving it to Database
	void updatePriorityAsInt(String value) {
		switch (value) {
			case 'High':
				note.priority = 1;
				break;
			case 'Low':
				note.priority = 2;
				break;
		}
	}

	// Convert int priority to String priority and display it to user in DropDown
	String getPriorityAsString(int value) {
		String priority='';
		switch (value) {
			case 1:
				priority = priorities[0];  // 'High'
				break;
			case 2:
				priority = priorities[1];  // 'Low'
				break;
		}
		return priority;
	}

 void updateTitle(){
    note.title = Titlecontroller.text;
  }

	// Update the description of Note object
	void updateDescription() {
		note.description = DescriptionController.text;
	}

	// Save data to database
	void save() async {

		

		note.date = DateFormat.yMMMd().format(DateTime.now());
		int result;
  
  print(note.id.toString() + ' id');
   movetolastscreen();
  
  
		if (note.title == 'Add Note' ) {  // Case 1: Update operation
	result = await helper.insertNote(note);
//return;
		} 
    else { // Case 2: Insert Operation
					result = await helper.updateNote(note);
    }
    print(result);
	
		if (result != 0) {  // Success
			_showAlertDialog('Status', 'Note Saved Successfully');
	
    } else {  // Failure
			_showAlertDialog('Status', 'Problem Saving Note');
	
    }
   

	}
  void _showAlertDialog(String title, String message) {

		AlertDialog alertDialog = AlertDialog(
			title: Text(title),
			content: Text(message),
		);
		showDialog(
				context: context,
				builder: (_) => alertDialog
		);
	}
  void _delete() async {

	

		// Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
		// the detail page by pressing the FAB of NoteList page.
		if (note.id == 0) {
			_showAlertDialog('Status', 'No Note was deleted');
			return;
		}

		// Case 2: User is trying to delete the old note that already has a valid ID.
		int result = await helper.deleteNote(note.id);
		if (result != 0) {
			_showAlertDialog('Status', 'Note Deleted Successfully');
		} else {
			_showAlertDialog('Status', 'Error Occured while Deleting Note');
		}	
    movetolastscreen();
	}

}
