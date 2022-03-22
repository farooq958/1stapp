import 'package:flutter/material.dart';
import 'package:sampleapp/Exploring%20Widgets/Notedetails.dart';
import 'package:sampleapp/Model/Note.dart';
import 'package:sampleapp/Utilities/database_helper.dart';
import 'package:sqflite/sqlite_api.dart';



class noteslist extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Noteliststate();
  }
}


class Noteliststate extends State<noteslist> {
  DatabaseHelper databaseHelper = DatabaseHelper();
	    List<Note> noteList=[];
  var count = 0;



  
  @override
  Widget build(BuildContext context) {
 // if(noteList == null)
			
			    updateListView();

    
		
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: getnoteslistview(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("check");
        navigateTodetail(Note('Add Note', '', 1), 'Add Note');
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget getnoteslistview() {
    var theme = Theme.of(context).textTheme.subtitle1;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getPriorityColor(this.noteList[index].priority),
							child: getPriorityIcon(this.noteList[index].priority),
            ),
            title:  Text(this.noteList[index].title, style: theme,),
            subtitle:Text(this.noteList[index].date),
            trailing:GestureDetector(
							child: Icon(Icons.delete, color: Colors.grey,),
							onTap: () {
								delete(context, noteList[index]);
							},
						),
            onTap: ()
            {
              navigateTodetail(this.noteList[index],"Edit Note");
              print(this.noteList[index]);
            },
          ),
        );
      },
    );
  }

 void navigateTodetail(Note note, String title) async {
	  bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
		  return notedetails(note, title);
	  }));

	  if (result == true) {
	  	updateListView();
	  }
  }
  Color getPriorityColor(int priority) {
		switch (priority) {
			case 1:
				return Colors.red;
				
			case 2:
				return Colors.yellow;
				

			default:
				return Colors.yellow;
		}
	}
  // Returns the priority icon
	Icon getPriorityIcon(int priority) {
		switch (priority) {
			case 1:
				return Icon(Icons.play_arrow);
				
			case 2:
				return Icon(Icons.keyboard_arrow_right);
				
			default:
				return Icon(Icons.keyboard_arrow_right);
		}
	}
  void showSnackBar(BuildContext context, String message) {

		var snackBar = SnackBar(content: Text(message));
		ScaffoldMessenger.of(context).showSnackBar(snackBar);
	}
  void delete(BuildContext context, Note note) async {

		int result = await databaseHelper.deleteNote(note.id);
		if (result != 0) {
			showSnackBar(context, 'Note Deleted Successfully');
			updateListView();
		}
	}

  void updateListView() {
final Future<Database> dbFuture = databaseHelper.initializeDatabase();
	
  	dbFuture.then((database) {

			Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
		
    	noteListFuture.then((noteList) {
				setState(() {
				  this.noteList = noteList;
        
				  this.count = noteList.length; 
           //print(count);
				});
			});
		});



  }
}
