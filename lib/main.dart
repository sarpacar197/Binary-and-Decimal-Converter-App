import 'package:flutter/material.dart';

void main() {
  runApp(const BinaryConverterApp());
}

class BinaryConverterApp extends StatelessWidget {
  const BinaryConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Number Systems Converter',
      theme: ThemeData(
        brightness: Brightness.dark, 
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ConverterPage(),
    );
  }
}

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  final TextEditingController _inputController = TextEditingController();
  String _result = "0";
  bool _isBinaryToDecimal = true; // Dönüşüm yönünü tutar

  // Senin yazdığın mantığın Dart versiyonu (Binary to Decimal)
  void _convertToDecimal(String binary) {
    try {
      int decimal = 0;
      int base = 1;
      for (int i = binary.length - 1; i >= 0; i--) {
        if (binary[i] == '1') {
          decimal += base;
        } else if (binary[i] != '0') {
          throw const FormatException("Invalid Binary");
        }
        base *= 2;
      }
      setState(() {
        _result = decimal.toString();
      });
    } catch (e) {
      setState(() {
        _result = "Hatalı Giriş!";
      });
    }
  }

  // Senin yazdığın mantığın Dart versiyonu (Decimal to Binary)
  void _convertToBinary(String decimalStr) {
    try {
      int n = int.parse(decimalStr);
      if (n == 0) {
        setState(() => _result = "0");
        return;
      }
      String binary = "";
      while (n > 0) {
        binary = (n % 2).toString() + binary;
        n = n ~/ 2; 
      }
      setState(() {
        _result = binary;
      });
    } catch (e) {
      setState(() {
        _result = "Hatalı Giriş!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Decimal and Binary Converter"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Dec"),
                Switch(
                  value: _isBinaryToDecimal,
                  onChanged: (value) {
                    setState(() {
                      _isBinaryToDecimal = value;
                      _inputController.clear();
                      _result = "0";
                    });
                  },
                ),
                const Text("Bin"),
              ],
            ),
            const SizedBox(height: 20),
            
            
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: _isBinaryToDecimal ? "Binary Sayı Girin" : "Decimal Sayı Girin",
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.numbers),
              ),
              onChanged: (value) {
                if (value.isEmpty) {
                  setState(() => _result = "0");
                  return;
                }
                if (_isBinaryToDecimal) {
                  _convertToDecimal(value);
                } else {
                  _convertToBinary(value);
                }
              },
            ),
            
            const SizedBox(height: 40),
            
            const Text(
              "SONUÇ:",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            SelectableText(
              _result,
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            
            const SizedBox(height: 50),
            
            Text(
              _isBinaryToDecimal 
                ? "Binary tabandan 10'luk tabana çevriliyor." 
                : "10'luk tabandan Binary tabana çevriliyor.",
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}