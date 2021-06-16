import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'tape.dart';

class Pengurangan extends StatefulWidget {
  @override
  _PenguranganState createState() => _PenguranganState();
}

class _PenguranganState extends State<Pengurangan> {
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

    setState(() {
      hasil = bil1 - bil2;
    });
  }

  state0(){
    if (tape[head].value == '0'){
      tape[head].value = 'b';
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 1;
    } else if(tape[head].value == '1'){
      tape[head].value = 'b';
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head +1;
      pil = 5;
    }
  }

  state1(){
    if(tape[head].value == 'b'){
      tape[head].isHead = false;
      tape[head - 1].isHead = true;
      head = head - 1;
      pil = 2;
    } else if(tape[head].value == '0' || tape[head].value == '1'){
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 1;
    }
  }

  state2(){
    if(tape[head].value == '1'){
      tape[head].value = '0';
      tape[head].isHead = false;
      tape[head - 1].isHead = true;
      head = head - 1;
      pil = 4;
    } else if(tape[head].value == '0'){
      tape[head].value = 'b';
      tape[head].isHead = false;
      tape[head - 1].isHead = true;
      head = head - 1;
      pil = 3;
    }
  }

  state3(){
    if(tape[head].value == 'b'){
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 0;
    } else if(tape[head].value == '0' || tape[head].value == '1'){
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 3;
    }
  }

  state4(){
    isDone = true;
  }

  state5(){
    if(tape[head].value == 'b'){
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 5;
    } else if(tape[head].value == '0'){
      tape[head].value = 'b';
      tape[head].isHead = false;
      tape[head + 1].isHead = true;
      head = head + 1;
      pil = 6;
    }
  }

  state6(){
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
                    if (hasil == 0 && isDone == true) Text('The Result : $ans'),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Container(height: 50, child: _buildListView()),
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

@override
  Widget build(BuildContext context) {
    return Container();
  }
}