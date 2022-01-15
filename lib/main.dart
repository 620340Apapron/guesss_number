import 'package:flutter/material.dart';
import 'game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final _controller = TextEditingController();
  var game = Game();
  bool isCorrect = false;
  String? _input;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GUESS THE NUMBER'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.green.shade100,
                offset: const Offset(5.0, 5.0),
                spreadRadius: 2.0,
                blurRadius: 5.0,
              )
            ],
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/guess_logo.png', width: 90.0),
                    const SizedBox(width: 8.0),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('GUESS',
                            style: TextStyle(
                                fontSize: 36.0, color: Colors.green.shade200)),
                        Text(
                          'THE NUMBER',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.green.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: _controller,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.7),
                            border: const OutlineInputBorder(),
                            hintText: 'ทายเลขตั้งแต่ 1 ถึง 100',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ElevatedButton(
                  child: const Text('GUESS'),
                  onPressed: () {
                    _input = _controller.text;
                    int? guess = int.tryParse(_input!);
                    if (guess != null) {
                      var count = game.doGuess(guess);
                      var sum = game.guessCount;
                      if (count == 0) {
                        isCorrect = true;
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Result'),
                                content: Text(
                                    '$guess เป็นคำตอบที่ถูกต้อง เก่งมาก กล้ามาก ขอบใจ🎉\n คุณทายทั้งหมด $sum ครั้ง'),
                              );
                            });
                        _controller.clear();
                      } else if (count == 1) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Result'),
                                content: Text('$guess มากกว่าคำตอบ'),
                              );
                            });
                        _controller.clear();
                      } else if (count == -1) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Result'),
                                content: Text('$guess น้อยกว่าคำตอบ'),
                              );
                            });
                        _controller.clear();
                      }
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Error!'),
                              content: Text('โปรดกรอกตัวเลขเท่านั้น!!!'),
                            );
                          });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
