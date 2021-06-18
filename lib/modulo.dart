import 'dart:async';
import 'package:flutter/material.dart';
import 'tape.dart';

class Modulo extends StatefulWidget {
  @override
  _ModuloState createState() => _ModuloState();
}

class _ModuloState extends State<Modulo> {
  var _formKey = GlobalKey<FormState>();
  int ans = 0;
  int bil1 = 0;
  int bil2 = 0;
  int hasil = 0;
  List<Tape> tape = [];
  bool isNext;
  bool isEnable = false;
  bool pauseButton;
  bool isStart;
  bool isDone;
  bool isAuto;
  int pil;
  int head;
  ScrollController controller;
  final itemSize = 50.0;
  Timer rep;

  transition(int next, String output, String move) {
    int moves = 0;
    if (move == 'R')
      moves = 1;
    else if (move == 'L') moves = -1;
    tape[head].value = output;
    tape[head].isHead = false;
    tape[head + moves].isHead = true;
    head = head + moves;
    pil = next;
  }

  _enableButton() {
    isEnable = true;
  }

  void _submit() {
    ans = 0;
    isNext = false;
    isStart = false;
    isAuto = true;
    pil = 0;
    head = 1;
    isDone = false;
    tape.clear();
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();

    if(bil1>0 && bil2>0) {
      int item = bil1 + bil2 + 4;
      for (int i = 0; i < item; i++) {
        if (i == 0 || i == item - 1)
          tape.add(Tape('b', false));
        else if (i == bil2 + 1)
          tape.add(Tape('1', false));
        else if (i == item - 2)
          tape.add(Tape('1', false));
        else
          tape.add(Tape('0', false));
      }
    }
    else {
      isEnable=false;
      isAuto=false;
    }
    setState(() {
      hasil = bil1 % bil2;
    });
  }

  state0() {
    if (tape[head].value == '0') {
      transition(1, 'b', 'R');
    } else if (tape[head].value == '1') {
      transition(4, tape[head].value, 'R');
    }
  }

  state1() {
    if (tape[head].value == '0') {
      transition(1, tape[head].value, 'R');
    } else if (tape[head].value == '1') {
      transition(2, tape[head].value, 'R');
    }
  }

  state2() {
    if (tape[head].value == 'x') {
      transition(2, tape[head].value, 'R');
    } else if (tape[head].value == '1') {
      transition(7, 'b', 'L');
    } else if (tape[head].value == '0') {
      transition(3, 'x', 'L');
    }
  }

  state3() {
    if (tape[head].value == 'x' ||
        tape[head].value == '1' ||
        tape[head].value == '0') {
      transition(3, tape[head].value, 'L');
    } else if (tape[head].value == 'b') {
      transition(0, '0', 'R');
      ans++;
    }
  }

  state4() {
    if (tape[head].value == 'x' || tape[head].value == '0') {
      transition(4, tape[head].value, 'R');
    } else if (tape[head].value == '1') {
      transition(5, tape[head].value, 'R');
    }
  }

  state5() {
    if (tape[head].value == 'b') {
      transition(6, tape[head].value, 'L');
    }
  }

  state6() {
    if (tape[head].value == 'x' ||
        tape[head].value == '1' ||
        tape[head].value == '0') {
      transition(6, tape[head].value, 'L');
    } else if (tape[head].value == 'b') {
      transition(0, tape[head].value, 'R');
      ans = 0;
    }
  }

  state7() {
    if (tape[head].value == 'x' ||
        tape[head].value == '0' ||
        tape[head].value == '1') {
      transition(7, 'b', 'L');
    } else if (tape[head].value == 'b') {
      transition(8, 'b', 'R');
    }
  }

  state8() {
    isDone = true;
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
        state7();
        break;
      case 8:
        state8();
        break;
    }
    setState(() {});
  }

  void start() {
    isNext = true;
    isEnable = false;
    tape[head].isHead = true;
    setState(() {});
  }

  void autoStart() {
    isAuto = false;
    pauseButton = true;
    isNext = false;
    isStart = true;
    isEnable = false;
    tape[head].isHead = true;
    setState(() {});
    rep = Timer.periodic(Duration(milliseconds: 400), (rep) {
      nextState();
      if (isDone == true) {
        setState(() {
          rep.cancel();
        });
      }
    });
  }

  void pause() {
    isNext = true;
    pauseButton = false;
    setState(() {
      rep.cancel();
    });
  }

  void unPause() {
    pauseButton = true;
    rep = Timer.periodic(Duration(milliseconds: 400), (rep) {
      nextState();
      if (isDone == true) {
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
        title: Text('Modulo'),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text("Format Input : 0\u1d2e10\u1d2c1"),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex:10,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration:
                            InputDecoration(labelText: 'Bilangan Pertama (A)'),
                            onSaved: (String value) {
                              bil1= int.parse(value);

                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Harus diisi';
                              }
                              return null;
                            },
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Text("      "),
                        ),
                        Flexible(
                          flex: 1,
                          child:
                          Text(" % ",style: TextStyle(fontSize: 20),),
                        ),
                        Flexible(
                          flex: 1,
                          child: Text("      "),
                        ),
                        Flexible(
                          flex:10,
                          child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration:
                              InputDecoration(labelText: 'Bilangan Kedua (B)'),
                              onSaved: (String value) {
                                bil2 = int.parse(value);

                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Harus diisi';
                                }
                                return null;
                              }),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _enableButton();
                          _submit();
                          setState(() {});
                        },
                        child: Text('Process')),
                    SizedBox(
                      height: 20,
                    ),
                    if (bil1 <0 || bil2<0 ) Text('Not Applicable'),
                    if (isDone == true) Text('The Result : $hasil'),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Text("Format Output : 0\u1d3a"),
              SizedBox(
                height: 20,
              ),
              Container(height: 50, child: _buildListView()),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed:
                      isNext == true && isDone != true ? nextState : null,
                  child: Text('NextState')),
              ElevatedButton(
                  onPressed: isEnable == true ? start : null,
                  child: Text('Start')),
              ElevatedButton(
                  onPressed: isAuto == true ? autoStart : null,
                  child: Text('AutoStart')),
              if (isStart == true && isDone != true)
                ElevatedButton(
                    onPressed: pauseButton == true ? pause : unPause,
                    child:
                        pauseButton == true ? Text('Stop') : Text('Continue')),
              if (isDone == true) Text('Done!'),
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
