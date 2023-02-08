import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class FetchData extends StatefulWidget {
  const FetchData({Key? key}) : super(key: key);

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  Query dbRef = FirebaseDatabase.instance.ref().child('todos');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('todos');

  Widget listItem({required Map todos}) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        backgroundColor: Colors.red, textStyle: const TextStyle(fontSize: 20));

    final buttonText = 'Delete';
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: 110,
        color: Colors.black,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                  leading: Checkbox(
                    value: todos['done'],
                    onChanged: null,
                  ),
                  title: Text(todos['title']),
                  trailing: ElevatedButton(
                    onPressed: null,
                    style: style,
                    child: const Text('Delete'),
                  ))
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
            query: dbRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map todos = snapshot.value as Map;
              todos['key'] = snapshot.key;
              return listItem(todos: todos);
            }));
  }
}
