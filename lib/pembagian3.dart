import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'tape.dart';

class Pembagian3 extends StatefulWidget {
  @override
  _Pembagian3State createState() => _Pembagian3State();
}

class _Pembagian3State extends State<Pembagian3> {
  var _formKey = GlobalKey<FormState>();
  String sign;
  int ans = 0;
  int bil1 = 0;
  int bil2 = 0;
  int bil1new = 0;
  int bil2new = 0;
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
  int counter = 0;
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
      isEnable=false;
      isAuto=false;
      return;
    }
    _formKey.currentState.save();
    hasil = bil1 % bil2;

    if (hasil == 0) {
      double tes = bil1 / bil2;
      print(tes);
      int item = bil1 + bil2 + 5 + tes.toInt();
      for (int i = 0; i < item; i++) {
        if (i == 0 || i == item - 1 - tes)
          tape.add(Tape('b', false));
        else if (i == 1)
          bil2new < 0 ? tape.add(Tape('-', false)) : tape.add(Tape('+', false));
        else if (i == bil2 + 2)
          bil1new < 0 ? tape.add(Tape('-', false)) : tape.add(Tape('+', false));
        else if (i >= item - 2 - tes)
          tape.add(Tape('b', false));
        else
          tape.add(Tape('0', false));
      }
    }
    else {
      isEnable=false;
      isAuto=false;
    }

    setState(() {});
  }

  state0() {
    print(0);
    if (tape[head].value == '-') {
      transition(1, 'b', 'R');
    } else if (tape[head].value == '+') {
      transition(4, 'b', 'R');
    }
  }

  state1() {
    print(1);
    if (tape[head].value == '-') {
      transition(5, '1', 'R');
    } else if (tape[head].value == '+') {
      transition(2, '1', 'R');
    } else if (tape[head].value == '0') {
      transition(1, tape[head].value, 'R');
    }
  }

  state2() {
    print(2);
    if (tape[head].value == 'b') {
      transition(3, '-', 'L');
      sign = '-';
    } else if (tape[head].value == '0') {
      transition(2, tape[head].value, 'R');
    }
  }

  state3() {
    print(3);
    if (tape[head].value == 'b') {
      transition(6, 'b', 'R');
    } else if (tape[head].value == '0' ||
        tape[head].value == '1' ||
        tape[head].value == '-' ||
        tape[head].value == '+') {
      transition(3, tape[head].value, 'L');
    }
  }

  state4() {
    print(4);
    if (tape[head].value == '+') {
      transition(5, '1', 'R');
    } else if (tape[head].value == '-') {
      transition(2, '1', 'R');
    } else if (tape[head].value == '0') {
      transition(4, tape[head].value, 'R');
    }
  }

  state5() {
    print(5);
    if (tape[head].value == 'b') {
      transition(3, '+', 'L');
      sign = '+';
    } else if (tape[head].value == '0') {
      transition(5, tape[head].value, 'R');
    }
  }

  state6() {
    print(6);
    if (tape[head].value == '0') {
      transition(7, 'b', 'R');
    } else if (tape[head].value == '1') {
      transition(10, '1', 'R');
    }
  }

  state7() {
    print(7);
    if (tape[head].value == '0') {
      transition(7, tape[head].value, 'R');
    } else if (tape[head].value == '1') {
      transition(8, '1', 'R');
    }
  }

  state8() {
    print(8);
    if (tape[head].value == 'x') {
      transition(8, tape[head].value, 'R');
    } else if (tape[head].value == '-' || tape[head].value == '+') {
      transition(13, tape[head].value, 'L');
    } else if (tape[head].value == '0') {
      transition(9, 'x', 'L');
    }
  }

  state9() {
    print(9);
    if (tape[head].value == 'x' ||
        tape[head].value == '1' ||
        tape[head].value == '0') {
      transition(9, tape[head].value, 'L');
    } else if (tape[head].value == 'b') {
      transition(6, '0', 'R');
    }
  }

  state10() {
    print(10);
    if (tape[head].value == 'x' || tape[head].value == '0') {
      pil = 10;
      transition(10, tape[head].value, 'R');
    } else if (tape[head].value == '-' || tape[head].value == '+') {
      transition(11, tape[head].value, 'R');
    }
  }

  state11() {
    print(11);
    if (tape[head].value == 'b') {
      transition(12, '0', 'L');
      ans++;
    } else if (tape[head].value == '0' ) {
      transition(11, tape[head].value, 'R');
    }
  }

  state12() {
    print(12);
    if (tape[head].value == 'x' ||
        tape[head].value == '-' ||
        tape[head].value == '+' ||
        tape[head].value == '1' ||
        tape[head].value == '0') {
      transition(12, tape[head].value, 'L');
    } else if (tape[head].value == 'b') {
      transition(6, 'b', 'R');
    }
  }

  state13() {
    print(13);
    if (tape[head].value == 'x' ||
        tape[head].value == '-' ||
        tape[head].value == '+' ||
        tape[head].value == '1' ||
        tape[head].value == '0') {
      transition(13, 'b', 'L');
    } else if (tape[head].value == 'b') {
      transition(14, 'b', 'R');
    }
  }

  state14() {
    print(14);
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
      case 9:
        state9();
        break;
      case 10:
        state10();
        break;
      case 11:
        state11();
        break;
      case 12:
        state12();
        break;
      case 13:
        state13();
        break;
      case 14:
        state14();
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
        title: Text('Pembagian'),
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
              Text("Format Input : (X+Y)0\u1d2e(X+Y)0\u1d2c , dengan X = + & Y = -"),
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
                            InputDecoration(labelText: 'Masukkan bilangan A'),
                            onSaved: (String value) {
                              bil1new = int.parse(value);
                              bil1 = bil1new.abs();
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
                            Text(" / ",style: TextStyle(fontSize: 20),),
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
                              InputDecoration(labelText: 'Masukkan bilangan B'),
                              onSaved: (String value) {
                                bil2new = int.parse(value);
                                bil2 = bil2new.abs();
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
                    if (hasil != 0) Text('Not Applicable'),
                    if (hasil == 0 && isDone == true)
                      Text('The Result : $sign$ans'),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Text("Format Output : (X+Y)0\u1d3a , dengan X = + & Y = -"),
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
