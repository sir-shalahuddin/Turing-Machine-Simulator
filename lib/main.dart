import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tm/pembagian.dart';
import 'package:tm/perkalian.dart';

import 'modulo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Turing Machine Simulator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 30),
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            Text(
              'Pilih Jenis Turing Machine',
            ),
            SizedBox(
              height: 20,
            ),
            Flexible(
                flex: 1,
                child: Row(
                  children: [
                    Flexible(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 10, top: 10, right: 5, bottom: 5),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(500, 500),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            onPressed: () {},
                            child: Text('Penjumlahan'),
                          ),
                        )),
                    Flexible(
                        flex: 1,
                        child: Container(
                            margin: EdgeInsets.only(
                                left: 5, top: 10, right: 10, bottom: 5),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(500, 500),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              onPressed: () {},
                              child: Text('Pengurangan'),
                            )))
                  ],
                )),
            Flexible(
                flex: 1,
                child: Row(
                  children: [
                    Flexible(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 10, top: 10, right: 5, bottom: 5),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(500, 500),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Perkalian()));
                            },
                            child: Text('Perkalian'),
                          ),
                        )),
                    Flexible(
                        flex: 1,
                        child: Container(
                            margin: EdgeInsets.only(
                                left: 5, top: 10, right: 10, bottom: 5),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(500, 500),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Pembagian()));
                              },
                              child: Text('Pembagian'),
                            )))
                  ],
                )),
            Flexible(
                flex: 1,
                child: Row(
                  children: [
                    Flexible(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 10, top: 10, right: 5, bottom: 5),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(500, 500),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            onPressed: () {},
                            child: Text('Faktorial'),
                          ),
                        )),
                    Flexible(
                        flex: 1,
                        child: Container(
                            margin: EdgeInsets.only(
                                left: 5, top: 10, right: 10, bottom: 5),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(500, 500),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Modulo()));
                              },
                              child: Text('Modulo'),
                            )))
                  ],
                )),
            Flexible(
                flex: 1,
                child: Row(
                  children: [
                    Flexible(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 10, top: 10, right: 5, bottom: 5),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(500, 500),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            onPressed: () {},
                            child: Text('Pangkat'),
                          ),
                        )),
                    Flexible(
                        flex: 1,
                        child: Container(
                            margin: EdgeInsets.only(
                                left: 5, top: 10, right: 10, bottom: 5),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(500, 500),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              onPressed: () {},
                              child: Text('Logaritma biner'),
                            )))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
