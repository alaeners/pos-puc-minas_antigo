import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController numPessoasController = TextEditingController();
  String numPessoas = '0';

  TextEditingController valorTotalController = TextEditingController();
  String valorTotal = '0';

  TextEditingController porcentagemController = TextEditingController();
  String porcentagem = '0';
  num pagamento = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Divide Conta do Bar'),
            backgroundColor: Colors.red,
          ),
          body: Center(
              child: Column(children: <Widget>[
            Container(
                margin: const EdgeInsets.only(
                    top: 20, left: 5, right: 5, bottom: 5),
                child: TextField(
                  controller: numPessoasController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Número de Pessoas:',
                  ),
                  onChanged: (quantidade) {
                    setState(() {
                      numPessoas = quantidade;
                    });
                  },
                )),
            Container(
                margin: const EdgeInsets.all(5),
                child: TextField(
                  controller: valorTotalController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Valor Total da Conta:',
                  ),
                  onChanged: (total) {
                    setState(() {
                      valorTotal = total;
                    });
                  },
                )),
            Container(
                margin: const EdgeInsets.all(5),
                child: TextField(
                  controller: porcentagemController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Porcentagem do Garçom:',
                  ),
                  onChanged: (percent) {
                    setState(() {
                      porcentagem = limitPercent(percent);
                    });
                  },
                )),
            Container(
                margin: const EdgeInsets.all(16),
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      elevation: 15,
                      shadowColor: Colors.green),
                  child: const Text(
                    'Calcular Conta',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: calculoConta,
                )),
            Container(
              margin: const EdgeInsets.all(20),
              child: Text('BRL ' + pagamento.toString()),
            )
          ]))),
    );
  }

  String limitPercent(String text) {
    num value = num.parse(text);
    if (value > -1 && value < 101) {
      return text;
    }
    // ignore: avoid_print
    print('Os Valores Permitidos para a porcentagem é de 0 a 100');
    return 'Os valores inseridos são inválidos';
  }

  calculoConta() {
    num percentage = (num.parse(porcentagem) / 100);
    num newValue = num.parse(valorTotal) + (num.parse(valorTotal) * percentage);
    setState(() {
      pagamento = (newValue / num.parse(numPessoas));
    });
  }
}
