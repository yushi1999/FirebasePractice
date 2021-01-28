import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyFirestorePage(),
    );
  }
}

class MyFirestorePage extends StatefulWidget {
  @override
  _MyFirestorePageState createState() => _MyFirestorePageState();
}

class _MyFirestorePageState extends State<MyFirestorePage> {
  List<DocumentSnapshot> documentList = [];
  String orderDocumentInfo = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('コレクション＋ドキュメント作成'),
              onPressed: () async {
                // ドキュメント作成
                await Firestore.instance
                    .collection('users') // コレクションID
                    .document('id_abc') // ドキュメントID
                    .setData({'name': '鈴木', 'age': 40}); // データ
              },
            ),
            RaisedButton(
              child: Text('サブコレクション＋ドキュメント作成'),
              onPressed: () async {
                // サブコレクション内にドキュメント作成
                await Firestore.instance
                    .collection('users') // コレクションID
                    .document('id_abc') // ドキュメントID << usersコレクション内のドキュメント
                    .collection('orders') // サブコレクションID
                    .document('id_123') // ドキュメントID << サブコレクション内のドキュメント
                    .setData({'price': 600, 'date': '9/13'}); // データ
              },
            ),
            RaisedButton(
              child: Text('ドキュメント一覧取得'),
              onPressed: () async {
                //コレクション内のドキュメント一覧を取得
                final snapshot =
                    await Firestore.instance.collection('users').getDocuments();
                //取得したドキュメント一覧をUIに反映
                setState(() {
                  documentList = snapshot.documents;
                });
              },
            ),
            //コレクション内のドキュメント一覧を表示
            Column(
              children: documentList.map((document) {
                return ListTile(
                  title: Text("${document["name"]}さん"),
                  subtitle: Text("${document["age"]}歳"),
                );
              }).toList(),
            ),
            RaisedButton(
              child: Text('ドキュメントを指定して取得'),
              onPressed: () async {
                //コレクションIDとドキュメントIDを指定して取得
                final document = await Firestore.instance
                    .collection('users')
                    .document('id_abc')
                    .collection('orders')
                    .document('id_123')
                    .get();
                //取得したドキュメントの情報をUIに反映
                setState(() {
                  orderDocumentInfo =
                      '${document['date']}${document['price']}円';
                });
              },
            ),
            //ドキュメントの情報を表示
            ListTile(title: Text(orderDocumentInfo)),
            RaisedButton(
                child: Text('ドキュメント更新'),
                onPressed: () async {
                  //ドキュメント更新
                  await Firestore.instance
                      .collection('users')
                      .document("id_abc")
                      .updateData({'age': 41});
                })
          ],
        ),
      ),
    );
  }
}
