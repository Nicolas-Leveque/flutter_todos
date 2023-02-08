import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Todos extends StatefulWidget {
  const Todos({super.key});

  @override
  State<Todos> createState() => _TodosState();
}

class _TodosState extends State<Todos> {
  final Stream<QuerySnapshot> _todosStream =
      FirebaseFirestore.instance.collection('todos').snapshots();

  deleteTodo(DocumentSnapshot doc) async {
    await FirebaseFirestore.instance
        .collection('todos')
        .doc(doc.id)
        .delete()
        .then((doc) => print('Document deleted'),
            onError: (e) => print('Error updatin db $e'));
  }

  updateTodo(String id, bool isDone) async {
    await FirebaseFirestore.instance
        .collection('todos')
        .doc(id)
        .update({'done': !isDone});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _todosStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return ListTile(
                leading: Checkbox(
                  value: data['done'],
                  onChanged: null,
                ),
                title: Text(data['title']),
                trailing: ElevatedButton(
                    onPressed: null, child: const Text('Delete')),
              );
            }).toList(),
          );
        });
  }
}
