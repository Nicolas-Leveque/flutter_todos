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
    // onToggle(todos) {
    //   reference.child(todos['key']).update({'done': !todos['done']});
    // }

    return Container(
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
                    onChanged: (bool? value) {
                      reference.child(todos['key']).update({'done': value});
                    },
                  ),
                  title: Text(todos['title']),
                  trailing: IconButton(
                    color: Colors.red,
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      reference.child(todos['key']).remove();
                    },
                  ))
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
