import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Split The Bill',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Split The Bill'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double result = 0;
  double remaining = 0;
  int divider = 3;
  int dividerMinus1 = 1;
  double cost = 10;
  String resultText = "-";
  late TextEditingController _costcontroller;
  late TextEditingController _dividercontroller;

  @override
  void initState() {
    super.initState();
    _costcontroller = TextEditingController();
  }

  void _incrementCounter() {
    setState(() {
      cost = double.parse(_costcontroller.text.toString());
      result = cost / divider;
      //Color buttonColor = const Color(0xffb74093);
      var resultSections = result.toString().split('.');
      if (resultSections[1].length > 2) {
        remaining = result -
            double.parse(resultSections[0] + '.' + resultSections[1][0]);
        result = result - remaining;
        remaining = (remaining * divider) + result;
        dividerMinus1 = divider - 1;
      } else {
        remaining = 0;
        dividerMinus1 = divider;
      }
      resultText = '$result x $dividerMinus1 + ' + remaining.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _costcontroller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Bill Cost',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onPressedSub,
                      child: const Text(
                        '-1',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "$divider",
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onPressedAdd,
                      child: const Text(
                        '+1',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              resultText,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.check),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void onPressedSub() {
    setState(() {
      divider -= 1;
    });
  }

  onPressedAdd() {
    setState(() {
      divider += 1;
    });
  }
}
