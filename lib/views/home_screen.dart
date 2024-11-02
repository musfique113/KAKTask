import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kaktask/addNotes.dart';
import 'package:http/http.dart' as http;
import 'package:kaktask/application/services/network_services/network_executor.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.name}) : super(key: key);

  final String name;

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
        title: const Text(
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
        child: const Center(
          child: CircularProgressIndicator(),
        ),
        replacement: RefreshIndicator(
          onRefresh: fetchTodo,
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(
              child: Text(
                "No Task Available ${widget.name}",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            child: ListView.builder(
                itemCount: items.length,
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  final item = items[index] as Map;
                  final id = item['_id'] as String;
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(child: Text('${index + 1}')),
                      title: Text(item["title"]),
                      subtitle: Text(item["description"]),
                      trailing: PopupMenuButton(
                        onSelected: (value) {
                          if (value == 'edit') {
                            navigateEditNotePage(item);
                          } else if (value == 'delete') {
                            deleteById(id);
                          }
                        },
                        itemBuilder: (context) {
                          return [
                            const PopupMenuItem(
                              child: Text("Edit"),
                              value: 'edit',
                            ),
                            const PopupMenuItem(
                              child: Text("Delete"),
                              value: 'delete',
                            )
                          ];
                        },
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: navigateAddNotePage, label: const Text("Add Task")),
    );
  }

  Future<void> navigateEditNotePage(Map item) async {
    final route = MaterialPageRoute(builder: (context) => AddNotes(todo: item));
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> navigateAddNotePage() async {
    final route = MaterialPageRoute(
      builder: (context) => const AddNotes(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> fetchTodo() async {
    NetworkExecutor networkExecutor = NetworkExecutor();

    final url = "https://api.nstack.in/v1/todos?page=1&limit=10";

    final response = await networkExecutor.getRequest(url: url);
    if (response.statusCode == 200) {
      print('Data: ${response.body}');
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

  Future<void> deleteById(String id) async {
    final url = "https://api.nstack.in/v1/todos/$id";
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      final filteredItems =
          items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filteredItems;
      });
    } else {
      showStatusMessageIfFailed('Cannot delete');
    }
  }

  void showStatusMessageIfFailed(String status) {
    final snackBar = SnackBar(
      content: Text(
        status,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.redAccent,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
