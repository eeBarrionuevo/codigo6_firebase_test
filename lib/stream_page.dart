import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StreamPage extends StatelessWidget {
  CollectionReference productsReferences =
      FirebaseFirestore.instance.collection("products");

  StreamController<int> myStreamController = StreamController.broadcast();

  int myCounter = 0;

  Stream<int> counter() async* {
    for (int i = 0; i < 10; i++) {
      yield i;
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  Future<int> getNumber() async {
    return Future.delayed(const Duration(seconds: 5), () {
      return 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("Init Stream");
    // Stream<int> myStream = Stream.fromFuture(getNumber());
    // print("Stream creado...");

    // myStreamController.stream.listen((value) {
    //   print("Valor del Stream");
    //   print(value);
    // }, onDone: () {
    //   print("FINALIZADO!!!!!!");
    // }, onError: (error) {
    //   print("ERRRORRRRR");
    // });

    return Scaffold(
      appBar: AppBar(
        title: Text("Stream Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
              stream: myStreamController.stream,
              builder: (BuildContext context, AsyncSnapshot snap) {
                if (snap.hasData) {
                  return Text(
                    snap.data.toString(),
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  );
                }
                return Text(
                  "0",
                  style: TextStyle(
                    fontSize: 40,
                  ),
                );
              },
            ),
            StreamBuilder(
              stream: myStreamController.stream,
              builder: (BuildContext context, AsyncSnapshot snap) {
                if (snap.hasData) {
                  return Text(
                    snap.data.toString(),
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  );
                }
                return Text(
                  "0",
                  style: TextStyle(
                    fontSize: 40,
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text("Emitir"),
              onPressed: () {
                myCounter++;
                myStreamController.add(myCounter);
              },
            ),
          ],
        ),
      ),

      // body: StreamBuilder(
      //   stream: productsReferences.snapshots(),
      //   builder: (BuildContext context, AsyncSnapshot snap) {
      //     if (snap.hasData) {
      //       QuerySnapshot productCollection = snap.data;
      //       print(productCollection.size);
      //     }
      //     return Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   },
      // ),
    );
  }
}
