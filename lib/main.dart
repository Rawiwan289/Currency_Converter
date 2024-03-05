import 'DropDown.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ExchangeRate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My App",
      home: const MyHomePage(),
      theme: ThemeData(primarySwatch: Colors.brown,scaffoldBackgroundColor: Color.fromARGB(255, 155, 255, 140)),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ExchangeRate? _myRate;
  Text answer = Text('');
  void getExchangeRate({String? input1, String? input2, String? amount}) async {
    // print("getting exchange rate");
    var params = {'from': input1, 'to': input2, 'amount': amount};
    var uri =
        Uri.https('currency-converter-pro1.p.rapidapi.com', '/convert', params);
    var response = await http.get(uri, headers: <String, String>{
      'X-RapidAPI-Key': '0016ac5723msh29092793431ed70p19d97ajsnf47a361e3aa7',
      'X-RapidAPI-Host': 'currency-converter-pro1.p.rapidapi.com'
    });
    setState(() {
      _myRate = exchangeRateFromJson(response.body);
      answer = Text(
        "${amount} ${input1} = ${_myRate?.result?.toString() ?? '...'} ${input2}",
        style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    print("เริ่มการทำงาน build");
    String input1 = 'USD';
    String input2 = 'THB';
    Dropdown dropdown1 = new Dropdown(input: input1);
    Dropdown dropdown2 = new Dropdown(input: input2);
    final amountController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 255, 8),
        title: const Text(
          "Currency Exchange",
          style: TextStyle(fontSize: 40, fontStyle: FontStyle.italic),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            SizedBox(
              width: 300,
              child: TextFormField(
                decoration: const InputDecoration(label: Text("Amount"),fillColor: Colors.white,filled: true),
                keyboardType: TextInputType.number,
                validator: (value) {
                  try {
                    if (value!.isNotEmpty) {
                      if (double.parse(value) >= 0) {
                        return null;
                      }
                    }
                    throw ();
                  } catch (e) {
                    return "Fill Amount";
                  }
                },
                controller: amountController,
              ),
            ),
            SizedBox(height: 30),
            Text("From",
                style: TextStyle(fontSize: 40, fontStyle: FontStyle.italic)),
            SizedBox(height: 30),
            dropdown1,
            SizedBox(height: 30),
            Text(
              "To",
              style: TextStyle(fontSize: 40, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 30),
            dropdown2,
            SizedBox(height: 30),
            answer
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getExchangeRate(
            input1: dropdown1.getInput().toString(),
            input2: dropdown2.getInput().toString(),
            amount: amountController.text.toString(),
          );
        },
        tooltip: "Press to exhange",
        child: const Icon(
          Icons.circle_rounded,
          color: Colors.green,
          size: 50,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
