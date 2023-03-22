import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  CollectionReference productReference =
      FirebaseFirestore.instance.collection("products");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista general"),
      ),
      body: FutureBuilder(
        future: productReference.get(),
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.hasData) {
            QuerySnapshot productCollection = snap.data;
            List<QueryDocumentSnapshot> docs = productCollection.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> myDoc =
                    docs[index].data() as Map<String, dynamic>;
                myDoc["id"] = docs[index].id;
                return ListTile(
                  title: Text(myDoc["description"]),
                  subtitle: Text(myDoc["id"]),
                );
              },
            );
          } else if (snap.hasError) {
            return Text(snap.error.toString());
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
