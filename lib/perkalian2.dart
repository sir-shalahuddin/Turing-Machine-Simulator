import 'dart:async';
import 'package:flutter/material.dart';
import 'tape.dart';

class Perkalian2 extends StatefulWidget {
  @override
  _Perkalian2State createState() => _Perkalian2State();
}

class _Perkalian2State extends State<Perkalian2> {
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
    bil1new = bil1.abs();
    bil2new = bil2.abs();
    int hasil = (bil1 * bil2).abs();
    int item = bil1new + bil2new + 6 + hasil;
    for (int i = 0; i < item; i++) {
      if (i == 0 || i >= bil1new + bil2new + 4)
        tape.add(Tape('B', false));
      else if (i == 1)
        bil1 > 0 ? tape.add(Tape('+', false)) : tape.add(Tape('-', false));
      else if (i == bil1new + 3)
        bil2 > 0 ? tape.add(Tape('+', false)) : tape.add(Tape('-', false));
      else if (i >= 2 && i <= bil1new + 1)
        tape.add(Tape('1', false));
      else if (i >= bil1new + 3 && i < bil1new + bil2new + 6)
        tape.add(Tape('1', false));
    }
  }

  state0() {
    if (tape[head].value == '-') {
      transition(1, 'B', 'R');
    } else if (tape[head].value == '+') {
      transition(4, 'B', 'R');
    }
  }

  state1() {
    if (tape[head].value == '-') {
      transition(5, 'C', 'R');
    } else if (tape[head].value == '+') {
      transition(2, 'C', 'R');
    } else if (tape[head].value == '1') {
      transition(1, tape[head].value, 'R');
    }
  }

  state2() {
    if (tape[head].value == 'B') {
      transition(3, '-', 'L');
      sign = '-';
    } else if (tape[head].value == '1') {
      transition(2, tape[head].value, 'R');
    }
  }

  state3() {
    if (tape[head].value == 'B') {
      transition(6, 'B', 'R');
    } else if (tape[head].value == '1' || tape[head].value == 'C') {
      transition(3, tape[head].value, 'L');
    }
  }

  state4() {
    if (tape[head].value == '+') {
      transition(5, 'C', 'R');
    } else if (tape[head].value == '-') {
      transition(2, 'C', 'R');
    } else if (tape[head].value == '1') {
      transition(4, tape[head].value, 'R');
    }
  }

  state5() {
    if (tape[head].value == 'B') {
      transition(3, '+', 'L');
      sign = '+';
    } else if (tape[head].value == '1') {
      transition(5, tape[head].value, 'R');
    }
  }

  state6() {
    if (tape[head].value == '1') {
      transition(7, 'B', 'R');
    } else if (tape[head].value == 'C') {
      transition(12, 'B', 'R');
    }
  }

  state7() {
    if (tape[head].value == '1' ) {
      transition(7, tape[head].value, 'R');
    } else if (tape[head].value == 'C') {
      transition(8, 'C', 'R');
    }
  }

  state8() {
    if (tape[head].value == '1') {
      transition(9, 'Y', 'R');
    } else if (tape[head].value == '+' || tape[head].value == '-') {
      transition(11, tape[head].value, 'L');
    }
  }

  state9() {
    if (tape[head].value == '+' ||
        tape[head].value == '-' ||
        tape[head].value == '1' ) {
      transition(9, tape[head].value, 'R');
    } else if (tape[head].value == 'B') {
      transition(10, '1', 'L');
    }
  }

  state10() {
    if (tape[head].value == '+' ||
        tape[head].value == '-' ||
        tape[head].value == '1') {
      transition(10, tape[head].value, 'L');
    } else if (tape[head].value == 'Y') {
      transition(8, 'Y', 'R');
    }
  }

  state11() {
    if (tape[head].value == 'Y' || tape[head].value == '1') {
      if (tape[head].value == 'Y') ans++;
      transition(11, '1', 'L');
    } else if (tape[head].value == 'C') {
      transition(11, 'C', 'L');
    } else if (tape[head].value == 'B') {
      transition(6, 'B', 'R');
    }
  }

  state12() {
    if (tape[head].value == '1' ) {
      transition(12, 'B', 'R');
    } else if (tape[head].value == '+' || tape[head].value == '-') {
      transition(13,tape[head].value , 'R');
    }
  }

  state13() {
    if (tape[head].value == '1' ) {
      transition(13, tape[head].value, 'R');
    } else if (tape[head].value == 'B') {
      transition(14, 'B', 'L');
    }
  }

  state14() {
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
        title: Text('Perkalian'),
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
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                        "Format Input : (X+Y)1\u1d2c(X+Y)1\u1d2e , dengan X = + & Y = -"),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 10,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: 'Bilangan Pertama (A)'),
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
                        ),
                        Flexible(
                          flex: 1,
                          child: Text("      "),
                        ),
                        Flexible(
                          flex: 1,
                          child: Text(
                            " * ",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Text("      "),
                        ),
                        Flexible(
                          flex: 10,
                          child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: 'Bilangan Kedua (B)'),
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
                    if (hasil != 0) Text('Not Applicable'),
                    if (hasil == 0 && isDone == true) Text('The Result : $sign$ans'),
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
