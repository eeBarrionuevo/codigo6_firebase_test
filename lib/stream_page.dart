import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StreamPage extends StatelessWidget {
  CollectionReference productsReferences =
      FirebaseFirestore.instance.collection("products");

  Stream<int> counter() async* {
    for (int i = 0; i < 10; i++) {
      yield i;
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  Future<int> getNumber() async {
    return 10;
  }

  @override
  Widget build(BuildContext context) {
    // getNumber().then((value) {
    //   print(value);
    // });
    // counter().listen((value) {
    //   print(value);
    // });

    return Scaffold(
      appBar: AppBar(
        title: Text("Stream Page"),
      ),
      // body: FutureBuilder(
      //   future: getNumber(),
      //   builder: (BuildContext context, AsyncSnapshot snap) {
      //     if (snap.hasData) {
      //       return Text(snap.data.toString());
      //     }
      //     return Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   },
      // ),

      // body: StreamBuilder(
      //   stream: counter(),
      //   builder: (BuildContext context, AsyncSnapshot snap) {
      //     if (snap.hasData) {
      //       return Center(
      //         child: Text(
      //           snap.data.toString(),
      //           style: TextStyle(
      //             fontSize: 30.0,
      //           ),
      //         ),
      //       );
      //     }
      //     return Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   },
      // ),

      body: StreamBuilder(
        stream: productsReferences.snapshots(),
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.hasData) {
            QuerySnapshot productCollection = snap.data;
            print(productCollection.size);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
