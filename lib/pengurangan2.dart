import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'tape.dart';

class Pengurangan2 extends StatefulWidget {
  @override
  _Pengurangan2State createState() => _Pengurangan2State();
}

class _Pengurangan2State extends State<Pengurangan2> {
  var _formKey = GlobalKey<FormState>();
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
  int item = 0;
  ScrollController controller;
  final itemSize = 50.0;
  Timer rep;

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
    hasil = (bil1 - bil2).abs();
    bil1new = bil1.abs();
    bil2new = bil2.abs();
    int item = bil1new + bil2new + 4 + hasil;
    for (int i = 0; i < item; i++) {
      if (i == 0 || i >= bil1new + bil2new + 3)
        tape.add(Tape('B', false));
      else if (i == bil1new + 1 || i == bil1new + bil2new + 2)
        tape.add(Tape('C', false));
      else if (bil1 > 0 && i >= 1 && i <= bil1new)
        tape.add(Tape('1', false));
      else if (bil1 < 0 && i >= 1 && i <= bil1new)
        tape.add(Tape('0', false));
      else if (bil2 > 0 && i >= bil1new + 2 && i < bil1new + bil2new + 3)
        tape.add(Tape('1', false));
      else if (bil2 < 0 && i >= bil1new + 2 && i < bil1new + bil2new + 3)
        tape.add(Tape('0', false));
    }

  }

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

  state0() {
    if (tape[head].value == '1') {
      transition(1, 'X', 'R');
    } else if (tape[head].value == 'X') {
      transition(0, 'X', 'R');
    } else if (tape[head].value == 'C') {
      transition(7, 'C', 'R');
    } else if (tape[head].value == '0') {
      transition(16, 'X', 'R');
    }
  }

  state1() {
    if (tape[head].value == '1') {
      transition(1, '1', 'R');
    } else if (tape[head].value == 'C') {
      transition(2, 'C', 'R');
    }
  }

  state2() {
    if (tape[head].value == '0') {
      transition(3, 'X', 'R');
    } else if (tape[head].value == '1') {
      transition(13, 'X', 'L');
    } else if (tape[head].value == 'X') {
      transition(2, 'X', 'R');
    } else if (tape[head].value == 'C') {
      transition(10, 'C', 'R');
    }
  }

  state3() {
    if (tape[head].value == 'C') {
      transition(4, tape[head].value, 'R');
    } else if (tape[head].value == '0') {
      transition(3, '0', 'R');
    }
  }

  state4() {
    if (tape[head].value == 'B') {
      transition(5, '1', 'R');
      ans++;
    } else if (tape[head].value == '1') {
      transition(4, '1', 'R');
    }
  }

  state5() {
    if (tape[head].value == 'B') {
      transition(6, '1', 'L');
      ans++;
    }
  }

  state6() {
    if (tape[head].value == '1' ||
        tape[head].value == '0' ||
        tape[head].value == 'X' ||
        tape[head].value == 'C') {
      transition(6, tape[head].value, 'L');
    } else if (tape[head].value == 'B') {
      transition(0, 'B', 'R');
    }
  }

  state7() {
    if (tape[head].value == 'X') {
      transition(7, tape[head].value, 'R');
    } else if (tape[head].value == 'C') {
      transition(8, 'B', 'L');
    } else if (tape[head].value == '0') {
      transition(12, 'X', 'R');
    }
    else if (tape[head].value == '1') {
      transition(15, 'X', 'R');
    }
  }

  state8() {
    if (tape[head].value == '1' ||
        tape[head].value == 'X' ||
        tape[head].value == 'C') {
      transition(8, 'B', 'L');
    } else if (tape[head].value == 'B') {
      transition(9, 'B', 'R');
    }
  }

  state9() {
    isDone = true;
  }

  state10() {
    if (tape[head].value == '1') {
      transition(10, tape[head].value, 'R');
    } else if (tape[head].value == 'B') {
      transition(11, '1', 'L');
      ans++;
    }
  }

  state11() {
    if (tape[head].value == '1') {
      transition(11, tape[head].value, 'L');
    } else if (tape[head].value == 'C') {
      transition(6, 'C', 'L');
    }
  }

  state12() {
    if (tape[head].value == 'C' || tape[head].value == '1') {
      transition(12, tape[head].value, 'R');
    } else if (tape[head].value == 'B') {
      transition(6, '1', 'L');
      ans++;
    }
  }

  state13() {
    if (tape[head].value == 'C') {
      transition(14, tape[head].value, 'L');
    }
    else if (tape[head].value == 'X') {
      transition(13, 'X', 'L');
    }
  }

  state14() {
    if (tape[head].value == 'X') {
      transition(0, 'X', 'R');
    }else if (tape[head].value == '1' ||tape[head].value=='0' ) {
      transition(14, tape[head].value, 'L');
    }

  }

  state15() {
    if (tape[head].value == 'C' || tape[head].value == '0') {
      transition(15, tape[head].value, 'R');
    } else if (tape[head].value == 'B') {
      transition(6, '0', 'L');
      ans--;
    }
  }

  state16(){
    if (tape[head].value == '0') {
      transition(16, '0', 'R');
    } else if (tape[head].value == 'C') {
      transition(17, 'C', 'R');
    }
  }

  state17(){
    if (tape[head].value == '1') {
      transition(18, 'X', 'R');
    } else if (tape[head].value == '0') {
      transition(13, 'X', 'L');
    } else if (tape[head].value == 'X') {
      transition(17, 'X', 'R');
    } else if (tape[head].value == 'C') {
      transition(20, 'C', 'R');
    }
  }

  state18() {
    if (tape[head].value == 'C') {
      transition(19, tape[head].value, 'R');
    } else if (tape[head].value == '1') {
      transition(18, '1', 'R');
    }
  }

  state19(){
    if (tape[head].value == 'B') {
      transition(20, '0', 'R');
      ans--;
    } else if (tape[head].value == '0') {
      transition(19, '0', 'R');
    }
  }

  state20() {
    if (tape[head].value == 'B') {
      transition(6, '0', 'L');
      ans--;
    }
    else if (tape[head].value == '0') {
      transition(20, tape[head].value, 'R');
    }
  }

  void nextState() {
    setState(() {
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
        case 15:
          state15();
          break;
        case 16:
          state16();
          break;
        case 17:
          state17();
          break;
        case 18:
          state18();
          break;
        case 19:
          state19();
          break;
        case 20:
          state20();
          break;
      }
    });
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
        title: Text('Pengurangan'),
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
                    Text("Format Input : (0+1)\u1d2cc(0+1)\u1d2ec "),
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
                            " - ",
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
                    if (hasil < 0) Text('Not Applicable'),
                    if (hasil >= 0 && isDone == true) Text('The Result : $ans'),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Text("Format Output : (0+1)\u1d3a"),
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
        shrinkWrap: true,
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
