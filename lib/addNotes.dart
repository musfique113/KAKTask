import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddNotes extends StatefulWidget {
  final Map? todo;
  const AddNotes({super.key,this.todo});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();
  bool isEdit  = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.todo != null){
      isEdit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit? "Edit Note" :
          'KAKTask Add note here',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade900, Colors.blue.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(14),
        children: [
          TextField(
            controller: textEditingController,
            decoration: InputDecoration(hintText: "Task title"),
          ),
          SizedBox(
            height: 25,
          ),
          TextField(
            controller: descriptionEditingController,
            decoration: InputDecoration(hintText: "Task Description"),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 10,
          ),
          SizedBox(
            height: 25,
          ),
          ElevatedButton(onPressed: isEdit ? updateData : submitData, child: Text(
              isEdit ? 'Update' : "Confirm"))
        ],
      ),
    );
  }

  Future<void> updateData() async {}

  Future<void> submitData() async {
    final title = textEditingController.text;
    final description = descriptionEditingController.text;
    //getting data from API
    final body = {
      "title": title,
      "description": description,
      "is_completed": false
    };
    final url = "https://api.nstack.in/v1/todos";
    final uri = Uri.parse(url);
    final response = await http.post(uri,
        body: jsonEncode(body), headers: {"Content-Type": "application/json"});

    if (response.statusCode == 201) {
      textEditingController.text = "";
      descriptionEditingController.text = "";
      print("Request send successfully");
      showStatusMessageIfSuccess("Request send successfully");
    } else {
      print("Request send failure");
      showStatusMessageIfFailed("Request send failure");
      print(response.statusCode);
    }
  }

  //let user notify about the process status
  void showStatusMessageIfSuccess(String status){
    final snackBar = SnackBar(content: Text(status, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      backgroundColor: Colors.green,);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  void showStatusMessageIfFailed(String status){
    final snackBar = SnackBar(content: Text(status, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
    backgroundColor: Colors.redAccent,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


}
