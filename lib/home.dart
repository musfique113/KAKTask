import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kaktask/addNotes.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List items = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KAKTask',
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
      body: Visibility(
        visible: isLoading,
        child: Center(
          child: CircularProgressIndicator(),
        ),
        replacement: RefreshIndicator(
          onRefresh: fetchTodo,
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index] as Map;
                final id = item['_id']as String;
                return ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text(item["title"]),
                  subtitle: Text(item["description"]),
                  trailing:PopupMenuButton(
                    onSelected: (value){
                      if(value == 'edit'){


                      }else if (value == 'delete'){
                        deleteById(id);

                      }
                    },
                    itemBuilder: (context){
                      return[
                        PopupMenuItem(child: Text("Edit"),value: 'edit',
                        ),
                        PopupMenuItem(child: Text("Delete"),value: 'delete',)
                      ];
                    },
                  ),
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddNotes()));

            //Navigator.push(context,MaterialPageRoute(builder: (context) =>Category(About: navBarItem[index]))
          },
          label: Text("Add Task")),
    );
  }

  // void navigateAddNotePage() {
  // }

  Future<void> fetchTodo() async {
    final url = "https://api.nstack.in/v1/todos?page=1&limit=10";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'];
      setState(() {
        items = result;
      });
    } else {}

    setState(() {
      isLoading = false;
    });
  }

  Future<void>  deleteById(String id) async{
    final url  = "https://api.nstack.in/v1/todos/$id";
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if(response.statusCode == 200){
      items =

    }else{

    }


  }

}
