import 'package:flutter/material.dart';
import 'game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  HomePage createState() => HomePage();
}

class HomePage extends State<MyApp> {
  final _controller = TextEditingController();
  String? _input;
  var game = Game();
  bool newGame = false;

  void _showMaterialDialog1(String title, String feed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title,
              style: const TextStyle(
                fontSize: 18.0,
              )),
          content: Text(feed,
              style: const TextStyle(
                fontSize: 18.0,
              )),
          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title,
              style: const TextStyle(
                fontSize: 18.0,
              )),
          content: Text(msg,
              style: const TextStyle(
                fontSize: 18.0,
              )),
          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    game = Game();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                        newGame = true;
                        _showMaterialDialog("RESULT",
                            '$_input ถูกต้องแล้วครับ 🎉\nคุณทายทั้งหมด $sum ครั้ง');
                        _controller.clear();
                      } else if (count == 1) {
                        _showMaterialDialog1(
                            "RESULT", '$_input มากเกินไป กรุณาลองใหม่');
                        _controller.clear();
                      } else {
                        _showMaterialDialog1(
                            "RESULT", '$_input น้อยเกินไป กรุณาลองใหม่');
                        _controller.clear();
                      }
                    } else {
                      _showMaterialDialog('Error',
                          'กรอกข้อมูลไม่ถูกต้อง ให้กรอกเฉพาะตัวเลขเท่านั้น');
                      _controller.clear();
                      newGame = false;
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
  //
  // Widget _buildMainContent() {
  //   if (_input == null) {
  //     return Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [],
  //     );
  //   } else {
  //     return Column(
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: Text(_input!,
  //               style: const TextStyle(
  //                 fontSize: 18.0,
  //               )),
  //         ),
  //         if (newGame)
  //           TextButton(
  //             onPressed: () {
  //               setState(() {
  //                 game = Game();
  //                 newGame = false;
  //                 _input = null;
  //               });
  //             },
  //             child: Padding(
  //                 padding: const EdgeInsets.all(16.0),
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                     color: Colors.teal,
  //                     //borderRadius: BorderRadius.circular(.0),
  //                     border: Border.all(width: 1.0),
  //                   ),
  //                   child: const Padding(
  //                     padding: EdgeInsets.all(10.0),
  //                     child: Text(
  //                       'NEW GAME',
  //                       style: TextStyle(
  //                         fontSize: 18.0,
  //                       ),
  //                     ),
  //                   ),
  //                 )),
  //           ),
  //       ],
  //     );
  //   }
  // }
}
