import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool? _genero;
  var _txtAltura = TextEditingController();
  var _txtPeso = TextEditingController();
  final String _mj = ''' 
Tabla del IMC para mujeres

Edad	  IMC ideal	
16-17	  19-24	
18-18	    19-24	
19-24	  19-24	
25-34	  20-25	
35-44	  21-26	
45-54	  22-27	
55-64	  23-28	
65-90	  25-30
  ''';

  final String _hb = ''' 
Tabla del IMC para hombres

Edad	  IMC ideal	
16-16	    19-24	
17-17	    20-25	
18-18	    20-25	
19-24	  21-26	
25-34	  22-27	
35-54	  23-38	
55-64	  24-29	
65-90	  25-30
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calcular IMC"),
        actions: [
          IconButton(
            onPressed: () {
              _genero = null;
              _txtAltura.clear();
              _txtPeso.clear();
              setState(() {});
            },
            icon: Icon(Icons.delete_forever),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Ingrese sus datos para calcular el IMC"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.female,
                    color: _genero == false ? Colors.indigo : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _genero = false;
                    });
                  },
                ),
                VerticalDivider(),
                IconButton(
                  icon: Icon(
                    Icons.male,
                    color: _genero == true ? Colors.indigo : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _genero = true;
                    });
                  },
                ),
              ],
            ),
            TextField(
              controller: _txtAltura,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                icon: Icon(Icons.square_foot),
                labelText: "Ingresar altura (Metros)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _txtPeso,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                icon: Icon(Icons.monitor_weight),
                labelText: "Ingresar peso (KG)",
                border: OutlineInputBorder(),
              ),
            ),
            MaterialButton(
              child: Text("Calcular"),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Tu IMC: ${_imc().toStringAsFixed(2)}"),
                      content: Text("${_genero! ? _hb : _mj}"),
                      actions: [
                        MaterialButton(
                          child: Text("Aceptar"),
                          onPressed: () => Navigator.of(context).pop(),
                        )
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  double _imc() {
    double peso = double.parse(_txtPeso.text);
    double altura = double.parse(_txtAltura.text);

    return (peso / (altura * altura));
  }
}
