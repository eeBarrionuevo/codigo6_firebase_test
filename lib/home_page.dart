import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoesapp/list_page.dart';

class HomePage extends StatelessWidget {
  CollectionReference productsReferences =
      FirebaseFirestore.instance.collection("products");

  @override
  Widget build(BuildContext context) {
    //print(productsReferences.id);
    //print(productsReferences.path);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                productsReferences.get().then((QuerySnapshot value) {
                  QuerySnapshot productCollection = value;
                  List<QueryDocumentSnapshot> docs = productCollection.docs;
                  docs.forEach((QueryDocumentSnapshot element) {
                    print(element.id);
                    print(element.data());
                  });
                });
              },
              child: Text("Obtener data"),
            ),
            ElevatedButton(
              onPressed: () {
                productsReferences.add(
                  {
                    "description": "New Balance 23",
                    "price": 566.30,
                    "type": "Running",
                    "state": true,
                  },
                ).then((DocumentReference value) {
                  print(value.id);
                });
              },
              child: Text(
                "Agregar",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                productsReferences
                    .doc("Hola0001")
                    .set(
                      {
                        "description": "Adidas Zoom x",
                        "price": 600.00,
                      },
                    )
                    .then((value) {})
                    .catchError((error) {});
              },
              child: Text(
                "Agregar 2",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                productsReferences.doc("BZRacdsS6YRaEzGVhsui").update(
                  {
                    "description": "New Balance SDE",
                    "price": 700,
                    "status": true
                  },
                );
              },
              child: Text("Actualizar"),
            ),
            ElevatedButton(
              onPressed: () {
                productsReferences.doc("Hola0001").delete();
              },
              child: Text("Eliminar"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ListPage()));
              },
              child: Text("Ver Lista"),
            ),
          ],
        ),
      ),
    );
  }
}
