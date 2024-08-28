import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página inicial'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButtonColumn(context, [
                'ABRIR JANELAS',
                'CONTROLE DE LUZ',
                'LIGAR AR CONDICIONADO'
              ]),
              buildButtonColumn(context, [
                'LIGAR VENTILADOR',
                'COMUNICADOR',
                'ENTRETENIMENTO'
              ]),
              buildButtonColumn(context, [
                'CONFIGURAÇÕES',
                'EMERGENCIA'
              ], isCircular: true, colors: [Colors.blue, Colors.red])
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildButtonColumn(BuildContext context, List<String> labels, {bool isCircular = false, List<Color>? colors}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: labels.asMap().entries.map((entry) {
      int index = entry.key;
      String label = entry.value;
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: isCircular
              ? buildCircularButton(label, context, color: colors?[index] ?? Colors.red)
              : buildButton(label, context),
        ),
      );
    }).toList(),
  );
}

Widget buildButton(String text, BuildContext context, {double width = 400, double height = 75, Color color = Colors.purple}) {
  return SizedBox(
    width: width,
    height: height,
    child: ElevatedButton(
      onPressed: () => handleButtonPress(text, context),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    ),
  );
}


Widget buildCircularButton(String text, BuildContext context, {double diameter = 400, Color color = Colors.red}) {
  return Container(
    width: diameter,
    height: diameter,
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: CircleBorder(),
      ),
      onPressed: () {
        if (text == 'EMERGENCIA') {
          showEmergencyDialog(context);
        }
        // Sempre chama handleButtonPress, mesmo para EMERGENCIA
        handleButtonPress(text, context);
      },
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  );
}

void handleButtonPress(String text, BuildContext context) {
  switch (text) {
    case 'ABRIR JANELAS':
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WindowControlScreen()),
      );
      break;
    case 'COMUNICADOR':
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CommunicatorScreen()),
      );
      break;
    case 'CONFIGURAÇÕES\n' 'COMUNICADOR':
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SettingsScreen()),
      );
      break;
    case 'EMERGENCIA':
      showEmergencyDialog(context);
      break;
    case 'MENSAGENS RÁPIDAS':
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QuickMessagesScreen()),
      );
      break;
    case 'MENSAGENS DE EMERGÊNCIA':
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EmergencyMessagesScreen()),
      );
      break;
    case 'PÁGINA INICIAL':
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    default:
    // Lógica padrão, se necessário
      break;
  }
}


void showEmergencyDialog(BuildContext context) { //caixa de emergencia
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // Define a Future para fechar o diálogo após 2 segundos
      Future.delayed(Duration(seconds: 1), () {
        Navigator.of(context).pop(true);
      });

      return AlertDialog(
        backgroundColor: Colors.purple.withOpacity(0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        content: Container(
          width: double.maxFinite,
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'PEDIDO DE AJUDA',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'ENVIADO',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class CommunicatorScreen extends StatelessWidget { //tela do comunicador
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comunicador'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButtonColumn(context, [
                'ESTOU BEM',
                'ESTOU COM FOME',
                'ESTOU COM DOR'
              ]),
              buildButtonColumn(context, [
                'CHAMAR AJUDA',
                'PRECISO DE COMPANHIA',
                'PRECISO DE MEDICAMENTO'
              ]),
              buildButtonColumn(context, [
                'PÁGINA INICIAL',
                'CONFIGURAÇÕES\n'
                'COMUNICADOR',
                'EMERGENCIA'
              ], isCircular: true, colors: [Colors.yellow, Colors.blue, Colors.red])
            ],
          ),
        ),
      ),
    );
  }
}


class WindowControlScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Janelas'),
          backgroundColor: Colors.deepOrange,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildButtonColumn(context, [
                      'ABRIR JANELA SALA',
                      'FECHAR JANELA COZINHA',
                      'FECHAR JANELA QUARTO 1',
                      'ABRIR JANELA QUARTO 2'
                    ]),
                    buildButtonColumn(context, [
                      'ABRIR JANELA QUARTO 3',
                      'ABRIR LAVANDERIA'
                    ]),
                    buildButtonColumn(context, [
                      'PÁGINA INICIAL',
                      'CONFIGURAÇÕES',
                      'EMERGENCIA',
                    ], isCircular: true, colors: [Colors.yellow, Colors.blue, Colors.red])
                  ],
                ),
          ),
        ),
      );
    }
  }

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações do Comunicador'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButtonColumn(context, [
                'MENSAGENS RÁPIDAS'
              ]),
              buildButtonColumn(context, [
                'MENSAGENS DE EMERGÊNCIA'
              ]),
              buildButtonColumn(context, [
                'PÁGINA INICIAL',
                'EMERGENCIA'
              ], isCircular: true, colors: [Colors.yellow, Colors.red])
            ],
          ),
        ),
      ),
    );
  }
}

class QuickMessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mensagens Rápidas'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Text('Conteúdo de Mensagens Rápidas'),
      ),
    );
  }
}

class EmergencyMessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mensagens de Emergência'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Text('Conteúdo de Mensagens de Emergência'),
      ),
    );
  }
}