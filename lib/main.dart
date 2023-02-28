import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 1;
  List<String> utensilios = [
    'Abridor de latas e garrafas',
    'Chaleira',
    'Coador de café',
    'Conjunto de medidores',
    'Conjunto de panelas',
    'Descanso de panelas',
    'Escorredor de macarrão',
    'Faqueiro',
    'Fouet',
    'Frigideira antiaderente',
    'Funil',
    'Leiteira',
    'Panela de pressão',
    'Ralador',
    'Saca rolhas',
    'Tábua de corte de carnes (madeira ou vidro)',
    'Tesoura',
  ];

  TextEditingController _controller = TextEditingController();

  List<String> _utensiliosFiltrados = [];

  int _randomNumber = 0;
  String _guessNumber = '';
  String _resultText = '';
  Color _color = Colors.blue;
  double _size = 100.0;

  void _change() {
    setState(() {
      final random = Random();
      _color = Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1.0,
      );
      _size = random.nextDouble() * 200.0 + 50.0;
    });
  }

  @override
  void initState() {
    super.initState();
    _generateRandomNumber();
    _utensiliosFiltrados = utensilios;
  }

  void _filtrarUtensilios(String texto) {
    setState(() {
      _utensiliosFiltrados = utensilios
          .where((utensilio) =>
              utensilio.toLowerCase().contains(texto.toLowerCase()))
          .toList();
    });
  }

  void _generateRandomNumber() {
    final random = Random();
    _randomNumber = random.nextInt(6);
  }

  void _checkGuess() {
    int guessNumber = int.parse(_guessNumber);

    if (guessNumber == null || guessNumber < 0 || guessNumber > 5) {
      setState(() {
        _resultText = 'Please enter a number between 0 and 5';
      });
    } else if (guessNumber == _randomNumber) {
      setState(() {
        _resultText = 'You guessed right!';
      });
      _generateRandomNumber();
    } else {
      setState(() {
        _resultText = 'You guessed wrong. Try again!';
      });
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Guess a number between 0 and 5',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _guessNumber = value;
              },
              onSubmitted: (value) {
                _checkGuess();
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: new Text('Guess'),
              onPressed: () {
                _checkGuess();
              },
            ),
            SizedBox(height: 16.0),
            Text(
              _resultText,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Woolha',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ' dot ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'com',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: _change,
              child: AnimatedContainer(
                margin: EdgeInsets.all(30),
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                width: _size,
                height: _size,
                color: _color,
              ),
            ),
            Container(
              width: 200,
              height: 200,
              color: Colors.grey[200],
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Digite o nome do utensílio',
                ),
                onChanged: (texto) {
                  _filtrarUtensilios(texto);
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _utensiliosFiltrados.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(_utensiliosFiltrados[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
