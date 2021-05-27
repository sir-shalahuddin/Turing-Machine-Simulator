import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'tape.dart';

class Pembagian2 extends StatefulWidget {
  @override
  _Pembagian2State createState() => _Pembagian2State();
}

class _Pembagian2State extends State<Pembagian2> {
  var _formKey = GlobalKey<FormState>();
  int bil1 = 0;
  int bil2 = 0;
  int bil1new=0;
  int bil2new=0;
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
      print(tes);
      int item = bil1 + bil2 + 7 + tes.toInt();
      for (int i = 0; i < item; i++) {
        if (i == 0 || i == item - 1 - tes)
          tape.add(Tape('b', false));
        else if (i == bil2+1)
          bil1new < 0 ? tape.add(Tape('-', false)) : tape.add(Tape('+', false));
        else if (i == bil2 + 3)
          bil2new < 0 ? tape.add(Tape('-', false)) : tape.add(Tape('+', false));
        else if (i == bil2 + 2)
          tape.add(Tape('1', false));
        else if (i == item - 3 - tes)
          tape.add(Tape('1', false));
        else if (i >= item - 2 - tes)
          tape.add(Tape('b', false));
        else
          tape.add(Tape('0', false));
      }
    }


    setState(() {});
  }

  state0() {
    print(0);
    if (tape[head].value == '-') {
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 1;
    }
    else if (tape[head].value == '0') {
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 0;
    }
    else if (tape[head].value == '+') {
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      // isNext = false;
      pil = 4;
    }
  }

  state1() {
    print(1);
    if (tape[head].value == '-') {
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 5;
    } else if (tape[head].value == '+') {
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      // isNext = false;
      pil = 2;
    } else if (tape[head].value == '0' || tape[head].value == '1') {
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 1;
    }
  }

  state2() {
    print(2);
    if (tape[head].value == 'b') {
      tape[head].value = '-';
      tape[head].isHead = false;
      tape[head - 1].isHead = true;
      head = head - 1;
      pil = 3;
    } else if (tape[head].value == '0' || tape[head].value == '1') {
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 2;
    }
  }

  state3() {
    print(3);
    if (tape[head].value == 'b') {
      tape[head].value = 'b';
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 6;
    } else if (tape[head].value == '0' ||
        tape[head].value == '1' ||
        tape[head].value == '-' ||
        tape[head].value == '+') {
      tape[head].isHead = false;
      tape[head - 1].isHead = true;
      head = head - 1;
      pil = 3;
    }
  }

  state4() {
    print(4);
    if (tape[head].value == '+') {
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 5;
    } else if (tape[head].value == '-') {
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      // isNext = false;
      pil = 3;
    } else if (tape[head].value == '0' || tape[head].value == '1') {
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 4;
    }
  }

  state5() {
    print(5);
    if (tape[head].value == 'b') {
      tape[head].value = '+';
      tape[head].isHead = false;
      tape[head - 1].isHead = true;
      head = head - 1;
      pil = 3;
    } else if (tape[head].value == '0' || tape[head].value == '1') {
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 5;
    }
  }

  state6() {
    print(6);
    if (tape[head].value == '0') {
      tape[head].value = 'b';
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 7;
    } else if (tape[head].value == '-' || tape[head].value == '+') {
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      // isNext = false;
      pil = 6;
    } else if (tape[head].value == '1') {
      tape[head].value = '1';
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 10;
    }
  }

  state7() {
    print(7);
    if (tape[head].value == '0' ||
        tape[head].value == '-' ||
        tape[head].value == '+') {
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 7;
    } else if (tape[head].value == '1') {
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 8;
    }
  }

  state8() {
    print(8);
    if (tape[head].value == 'x' ||
        tape[head].value == '-' ||
        tape[head].value == '+') {
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 8;
    } else if (tape[head].value == '1') {
      tape[head].value = 'b';
      tape[head].isHead = false;
      tape[head - 1].isHead = true;
      head = head - 1;
      pil = 13;
    } else if (tape[head].value == '0') {
      tape[head].value = 'x';
      tape[head].isHead = false;
      tape[head - 1].isHead = true;
      head = head - 1;
      pil = 9;
    }
  }

  state9() {
    print(9);
    if (tape[head].value == 'x' ||
        tape[head].value == '-' ||
        tape[head].value == '+' ||
        tape[head].value == '1' ||
        tape[head].value == '0') {
      tape[head].isHead = false;
      tape[head - 1].isHead = true;
      head = head - 1;
      pil = 9;
    } else if (tape[head].value == 'b') {
      tape[head].value = '0';
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 6;
    }
  }

  state10() {
    print(10);
    if (tape[head].value == 'x' ||
        tape[head].value == '0' ||
        tape[head].value == '-' ||
        tape[head].value == '+') {
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 10;
    } else if (tape[head].value == '1') {
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 11;
    }
  }

  state11() {
    print(11);
    if (tape[head].value == 'b') {
      tape[head].value = '0';
      tape[head].isHead = false;
      tape[head - 1].isHead = true;
      head = head - 1;
      pil = 12;
    } else if (tape[head].value == '0' ||
        tape[head].value == '-' ||
        tape[head].value == '+') {
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 11;
    }
  }

  state12() {
    print(12);
    if (tape[head].value == 'x' ||
        tape[head].value == '-' ||
        tape[head].value == '+' ||
        tape[head].value == '1' ||
        tape[head].value == '0') {
      tape[head].isHead = false;
      tape[head - 1].isHead = true;
      head = head - 1;
      pil = 12;
    } else if (tape[head].value == 'b') {
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 6;
    }
  }

  state13() {
    print(13);
    if (tape[head].value == 'x' ||
        tape[head].value == '-' ||
        tape[head].value == '+' ||
        tape[head].value == '1' ||
        tape[head].value == '0') {
      tape[head].value = 'b';
      tape[head].isHead = false;
      tape[head - 1].isHead = true;
      head = head - 1;
      pil = 13;
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
        counter++;
        state13();
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
      if (counter == bil1 + bil2 + 3) {
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
      if (counter == bil1 + bil2 + 3) {
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
                        bil1new = int.parse(value);
                        bil1= bil1new.abs();
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
                          bil2new = int.parse(value);
                          bil2=bil2new.abs();
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
                    if (hasil == 0) Text('format input 0^Y (plus + minus)1(plus + minus)0^X 1'),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Container(height: 50, child: _buildListView()),
              ElevatedButton(
                  onPressed: isEnable == false && counter != bil1 + bil2 +3
                      ? nextState
                      : null,
                  child: Text('NextState')),
              ElevatedButton(
                  onPressed: isEnable == true ? start : null,
                  child: Text('Start')),
              ElevatedButton(
                  onPressed: isEnable == true ? autoStart : null,
                  child: Text('AutoStart')),
              if (isStart == true && counter != bil1 + bil2 +3)
                ElevatedButton(
                    onPressed: pauseButton == true ? pause : unPause,
                    child:
                        pauseButton == true ? Text('Stop') : Text('Continue')),
              if (counter == bil1 + bil2 + 3) Text('Done!'),
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