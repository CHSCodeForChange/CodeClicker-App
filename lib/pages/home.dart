import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {

    @override
    HomeState createState() => new HomeState();

}

class HomeState extends State<Home> {

  int clicks = 0;
  String imageURL = "https://media.licdn.com/dms/image/C4E0BAQF_pghHQ-Iz7A/company-logo_200_200/0?e=2159024400&v=beta&t=uQaKql0dQ11cx5HvgB2vCNuK-87FevNh1RpBMI3pWfU";

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.white,
      child: new Card(
        color: Colors.cyan,
        margin: EdgeInsets.all(20.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            new Container(
              child: new Text(
                'Code For Change',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 35.0, fontWeight: FontWeight.bold),
              )
            ),

            
            new Container(
              child: new StreamBuilder(
                stream: Firestore.instance.collection('clicks').snapshots(),
                builder: (context, snapshot) {
                  return new GestureDetector(
                    onTap: () {
                      if (snapshot.hasData) {
                        DocumentSnapshot doc =  snapshot.data.documents[0];
                        doc.reference.updateData({
                          'clicks': doc['clicks'] + 1
                        });
                        // Firestore.instance.runTransaction((transaction) async {
                        //   DocumentSnapshot freshSnap = await transaction.get(snapshot.data.documents[0].reference);
                        //   await transaction.update(freshSnap.reference, {
                        //     'clicks': freshSnap['clicks'] + 1
                        //   });
                        // });
                      }
                    },
                    child: Image.network(
                      imageURL,
                      fit: BoxFit.fitHeight,
                      height: 300.0,

                    ),
                  );
                },
              )
            ),
            new Container(
              child: StreamBuilder(
                stream: Firestore.instance.collection('clicks').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Text(
                    'Loading...', 
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
                  );
                  return new Text(
                    'Clicks: ' + snapshot.data.documents[0]['clicks'].toString(),
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
                  );
                }
              )
            )
          ],
        ),
      )
    );
  }
}