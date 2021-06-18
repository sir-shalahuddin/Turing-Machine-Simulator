import 'dart:async';
import 'package:flutter/material.dart';
import 'tape.dart';

class Faktorial extends StatefulWidget {
  @override
  _FaktorialState createState() => _FaktorialState();
}

class _FaktorialState extends State<Faktorial> {
  var _formKey = GlobalKey<FormState>();
  int ans = 0;
  int bil1 = 0 ;
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
    else if (move == 'L')
      moves = -1;
    else if (move == 'S') moves = 0;
    tape[head].value = output;
    tape[head].isHead = false;
    tape[head + moves].isHead = true;
    head = head + moves;
    pil = next;
  }

  _enableButton() {
    isEnable = true;
  }

  factorial(int no) {
    if (no == 1) {
      return 1;
    }
    return no * factorial(no - 1);
  }

  void _submit() {

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


    if(bil1>0) {
    ans=factorial(bil1);
      int item = bil1 + 3 * (factorial(bil1) + 1)-1;
      for (int i = 0; i < item; i++) {
        if (i == 0 || i >= bil1 + 1)
          tape.add(Tape('b', false));
        else
          tape.add(Tape('0', false));
      }
    }
    else {
      isEnable=false;
      isAuto=false;
    }


  }

  state0() {
    if (tape[head].value == '0') {
      transition(0, tape[head].value, 'R');
    } else if (tape[head].value == 'b') {
      transition(1, '1', 'S');
    }
  }

  state1() {

    if (tape[head].value == '1' || tape[head].value == '0') {
      transition(1, tape[head].value, 'L');
    } else if (tape[head].value == 'b') {
      transition(2, tape[head].value, 'R');
    }
  }

  state2() {

    if (tape[head].value == '0') {
      transition(3, 'x', 'R');
    } else if (tape[head].value == '1') {
      transition(5, tape[head].value, 'R');
    }
  }

  state3() {

    if (tape[head].value == '1' || tape[head].value == '0') {
      transition(3, tape[head].value, 'R');
    } else if (tape[head].value == 'b') {
      transition(4, '0', 'S');
    }
  }

  state4() {

    if (tape[head].value == '0' || tape[head].value == '1') {
      transition(4, tape[head].value, 'L');
    } else if (tape[head].value == 'x') {
      transition(2, tape[head].value, 'R');
    }
  }

  state5() {

    if (tape[head].value == '0') {
      transition(5, tape[head].value, 'R');
    } else if (tape[head].value == 'b') {
      transition(7, '1', 'L');
    }
  }

  state6() {

    if (tape[head].value == '1' ||
        tape[head].value == '0' ||
        tape[head].value == 'x') {
      transition(6, tape[head].value, 'L');
    } else if (tape[head].value == 'b') {
      transition(16, tape[head].value, 'R');
    }
  }

  state7() {

    if (tape[head].value == '1' || tape[head].value == '0') {
      transition(7, tape[head].value, 'L');
    } else if (tape[head].value == 'x') {
      transition(7, '0', 'L');
    } else if (tape[head].value == 'b') {
      transition(8, tape[head].value, 'R');
    }
  }

  state8() {
    if (tape[head].value == '0') {
      transition(9, 'b', 'R');
    }
  }

  state9() {
    if (tape[head].value == '1') {
      transition(6, tape[head].value, 'L');
    } else if (tape[head].value == '0') {
      transition(10, 'x', 'R');
    }
  }

  state10() {
    if (tape[head].value == '0') {
      transition(10, tape[head].value, 'R');
    } else if (tape[head].value == '1') {
      transition(11, tape[head].value, 'R');
    }
  }

  state11() {
    if (tape[head].value == '0') {
      transition(12, 'x', 'R');
    } else if (tape[head].value == '1') {
      transition(14, tape[head].value, 'L');
    }
  }

  state12() {
    if (tape[head].value == '1' || tape[head].value == '0') {
      transition(12, tape[head].value, 'R');
    } else if (tape[head].value == 'b') {
      transition(13, '0', 'S');
    }
  }

  state13() {
    if (tape[head].value == '1' || tape[head].value == '0') {
      transition(13, tape[head].value, 'L');
    } else if (tape[head].value == 'x') {
      transition(11, tape[head].value, 'R');
    }
  }

  state14() {
    if (tape[head].value == 'x') {
      transition(14, '0', 'L');
    } else if (tape[head].value == '1') {
      transition(15, tape[head].value, 'L');
    }
  }

  state15() {
    if (tape[head].value == '1') {
      transition(15, '0', 'L');
    } else if (tape[head].value == '0') {
      transition(15, tape[head].value, 'L');
    } else if (tape[head].value == 'x') {
      transition(9, tape[head].value, 'R');
    }
  }

  state16() {
    if (tape[head].value == 'x') {
      transition(17, 'b', 'R');
    } else if (tape[head].value == '1') {
      transition(25, 'b', 'R');
    }
  }

  state17() {
    if (tape[head].value == 'x') {
      transition(19, tape[head].value, 'R');
    } else if (tape[head].value == '1' || tape[head].value == '0') {
      transition(18, 'b', 'R');
    }
  }

  state18() {
    if (tape[head].value == '0') {
      transition(18, 'b', 'R');
    } else if (tape[head].value == 'x') {
      transition(22, tape[head].value, 'R');
    } else if (tape[head].value == '1') {
      transition(24, 'b', 'S');
    }
  }

  state19() {
    if (tape[head].value == '0' || tape[head].value == 'x') {
      transition(19, tape[head].value, 'R');
    } else if (tape[head].value == '1') {
      transition(20, tape[head].value, 'R');
    }
  }

  state20() {
    if (tape[head].value == 'x' || tape[head].value == '0') {
      transition(20, tape[head].value, 'R');
    } else if (tape[head].value == '1') {
      transition(21, tape[head].value, 'L');
    }
  }

  state21() {
    if (tape[head].value == 'x') {
      transition(21, tape[head].value, 'L');
    } else if (tape[head].value == '0' || tape[head].value == '1') {
      transition(6, 'x', 'L');
    }
  }

  state22() {
    if (tape[head].value == 'x' ||
        tape[head].value == '1' ||
        tape[head].value == '0') {
      transition(22, tape[head].value, 'R');
    } else if (tape[head].value == 'b') {
      transition(23, '1', 'L');
    }
  }

  state23() {
    if (tape[head].value == '1' || tape[head].value == '0') {
      transition(23, tape[head].value, 'L');
    } else if (tape[head].value == 'x') {
      transition(23, '0', 'R');
    } else if (tape[head].value == 'b') {
      transition(9, tape[head].value, 'R');
    }
  }

  state24() {
    isDone = true;
  }

  state25() {
    if (tape[head].value == '0') {
      transition(25, tape[head].value, 'R');
    } else if (tape[head].value == '1') {
      transition(25, 'b', 'R');
    } else if (tape[head].value == 'b') {
      transition(24, tape[head].value, 'S');
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
        state13();
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
      case 21:
        state21();
        break;
      case 22:
        state22();
        break;
      case 23:
        state23();
        break;
      case 24:
        state24();
        break;
      case 25:
        state25();
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
        title: Text('Faktorial'),
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
              Text("Format Input : 0\u1d3a"),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Center(
                      child: Row(
                        children: [
                          Flexible(
                            flex:1,
                            child: Container(

                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: 'Bilangan (N)'),
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
                          // Flexible(
                          //   flex: 1,
                          //   child: SizedBox(
                          //     width: 20,
                          //   ),
                          // ),
                          Flexible(
                              flex: 1,
                              child: Text(
                                ' ! ',
                                style: TextStyle(fontSize: 20),
                              )),
                        ],
                      ),
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
                    if (bil1 <= 0 && isStart==false ) Text('Not Applicable'),
                    if (isDone == true) Text('The Result : $ans'),
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
