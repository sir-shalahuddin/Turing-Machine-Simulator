import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Pembagian extends StatefulWidget {
  @override
  _PembagianState createState() => _PembagianState();
}

class Tape {
  String value;
  bool isHead;

  Tape(this.value, this.isHead);
}

class _PembagianState extends State<Pembagian> {
  var _formKey = GlobalKey<FormState>();
  int bil1 = 0;
  int bil2 = 0;
  int hasil = 0;
  List<Tape> tape = [];
  bool isNext;
  bool isEnable = false;
  bool pauseButton;
  bool isStart;
  int pil;
  int head;
  int counter = 0;
  ScrollController controller;
  final itemSize = 50.0;
  Timer rep;

  _enableButton() {
    isEnable = true;
  }

  void _submit() {
    isStart = false;
    pil = 0;
    head = 1;
    counter = 0;
    tape.clear();
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    hasil = bil1 % bil2;

    if (hasil == 0) {
      double tes = bil1 / bil2;
      int item = bil1 + bil2 + 4 + tes.toInt();
      for (int i = 0; i < item; i++) {
        if (i == 0 || i == item - 1 - tes)
          tape.add(Tape('b', false));
        else if (i == bil2 + 1)
          tape.add(Tape('1', false));
        else if (i == item - 2 - tes)
          tape.add(Tape('1', false));
        else if (i >= item - tes)
          tape.add(Tape('b', false));
        else
          tape.add(Tape('0', false));
      }
    }
    setState(() {});
  }

  state0() {
    if (tape[head].value == '0') {
      tape[head].value = 'b';
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 1;
    } else if (tape[head].value == '1') {
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      isNext = false;
      pil = 4;
    }
  }

  state1() {
    if (tape[head].value == '0') {
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 1;
    } else if (tape[head].value == '1') {
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 2;
    }
  }

  state2() {
    if (tape[head].value == 'x') {
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 2;
    } else if (tape[head].value == '1') {
      tape[head].value = 'b';
      tape[head].isHead = false;
      tape[head - 1].isHead = true;
      head = head - 1;
      pil = 7;
    } else if (tape[head].value == '0') {
      tape[head].value = 'x';
      tape[head].isHead = false;
      tape[head - 1].isHead = true;
      head = head - 1;
      pil = 3;
    }
  }

  state3() {
    if (tape[head].value == 'x') {
      tape[head].isHead = false;
      tape[head - 1].isHead = true;
      head = head - 1;
      pil = 3;
    } else if (tape[head].value == '1') {
      tape[head].isHead = false;
      tape[head - 1].isHead = true;
      head = head - 1;
      pil = 3;
    } else if (tape[head].value == '0') {
      tape[head].isHead = false;
      tape[head - 1].isHead = true;
      head = head - 1;
      pil = 3;
    } else if (tape[head].value == 'b') {
      tape[head].value = '0';
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 0;
    }
  }

  state4() {
    if (tape[head].value == 'x') {
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 4;
    } else if (tape[head].value == '0') {
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 4;
    } else if (tape[head].value == '1') {
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 5;
    }
  }

  state5() {
    if (tape[head].value == 'b') {
      tape[head].value = '0';
      tape[head].isHead = false;
      tape[head - 1].isHead = true;
      head = head - 1;
      pil = 6;
    } else if (tape[head].value == '0') {
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 5;
    }
  }

  state6() {
    if (tape[head].value == 'x') {
      tape[head].isHead = false;
      tape[head - 1].isHead = true;
      head = head - 1;
      pil = 6;
    } else if (tape[head].value == '1') {
      tape[head].isHead = false;
      tape[head - 1].isHead = true;
      head = head - 1;
      pil = 6;
    } else if (tape[head].value == '0') {
      tape[head].isHead = false;
      tape[head - 1].isHead = true;
      head = head - 1;
      pil = 6;
    } else if (tape[head].value == 'b') {
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 0;
    }
  }

  state7() {
    if (tape[head].value == 'x') {
      tape[head].value = 'b';
      tape[head].isHead = false;
      tape[head - 1].isHead = true;
      head = head - 1;
      pil = 7;
    } else if (tape[head].value == '1') {
      tape[head].value = 'b';
      tape[head].isHead = false;
      tape[head - 1].isHead = true;
      head = head - 1;
      pil = 7;
    } else if (tape[head].value == '0') {
      tape[head].value = 'b';
      tape[head].isHead = false;
      tape[head - 1].isHead = true;
      head = head - 1;
      pil = 7;
    }
  }

  void nextState() {
    controller.animateTo((head - 3) * itemSize,
        duration: Duration(milliseconds: 400), curve: Curves.linear);
    switch (pil) {
      case 0:
        state0();
        break;
      case 1:
        state1();
        break;
      case 2:
        state2();
        break;
      case 3:
        state3();
        break;
      case 4:
        state4();
        break;
      case 5:
        state5();
        break;
      case 6:
        state6();
        break;
      case 7:
        counter++;
        state7();
        break;
    }
    setState(() {});
  }

  void start() {
    isEnable = false;
    tape[head].isHead = true;
    setState(() {});
  }

  void autoStart() {
    pauseButton = true;
    isStart = true;
    isEnable = false;
    tape[head].isHead = true;
    setState(() {});
    rep = Timer.periodic(Duration(milliseconds: 400), (rep) {
      nextState();
      if (counter == bil1 + bil2) {
        setState(() {
          rep.cancel();
        });
      }
    });
  }

  void pause() {
    pauseButton = false;
    setState(() {
      rep.cancel();
    });
  }

  void unPause() {
    pauseButton = true;
    rep = Timer.periodic(Duration(milliseconds: 400), (rep) {
      nextState();
      if (counter == bil1 + bil2) {
        setState(() {
          rep.cancel();
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pembagian'),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(8),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text('X / Y'),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration:
                          InputDecoration(labelText: 'Masukkan bilangan X'),
                      onSaved: (String value) {
                        bil1 = int.parse(value);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Harus diisi';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        decoration:
                            InputDecoration(labelText: 'Masukkan bilangan Y'),
                        onSaved: (String value) {
                          bil2 = int.parse(value);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Harus diisi';
                          }
                          return null;
                        }),
                    ElevatedButton(
                        onPressed: () {
                          _enableButton();
                          _submit();
                          setState(() {});
                        },
                        child: Text('Process')),
                    if (hasil != 0) Text('Not Applicable'),
                    if (hasil == 0) Text('${bil1 / bil2}'),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Container(height: 50, child: _buildListView()),
              ElevatedButton(
                  onPressed: isEnable == false && counter != bil1 + bil2
                      ? nextState
                      : null,
                  child: Text('NextState')),
              ElevatedButton(
                  onPressed: isEnable == true ? start : null,
                  child: Text('Start')),
              ElevatedButton(
                  onPressed: isEnable == true ? autoStart : null,
                  child: Text('AutoStart')),
              if (isStart == true && counter != bil1 + bil2)
                ElevatedButton(
                    onPressed: pauseButton == true ? pause : unPause,
                    child:
                        pauseButton == true ? Text('Stop') : Text('Continue')),
              if (counter == bil1 + bil2) Text('Done!'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
        controller: controller,
        itemExtent: itemSize,
        scrollDirection: Axis.horizontal,
        itemCount: tape.length,
        itemBuilder: (context, index) {
          return Container(
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  color: tape[index].isHead == true ? Colors.red : Colors.green,
                ),
                alignment: Alignment.center,
                child: Text('${tape[index].value}')),
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
}
