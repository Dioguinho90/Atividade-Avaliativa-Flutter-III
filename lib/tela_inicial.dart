import 'package:flutter/material.dart';
import 'segunda_tela.dart';

class TelaInicial extends StatelessWidget {
  TelaInicial({super.key});

  final organizador = TextEditingController();
  final times = TextEditingController();
  final dias = TextEditingController();

  // Método para abrir a segunda tela
  void abrirSegundaTela(BuildContext context) {
    try {
      int quantidadeTimes = int.parse(times.text);
      int quantidadeDias = int.parse(dias.text);

      if (organizador.text.isEmpty ||
          quantidadeTimes <= 0 ||
          quantidadeDias <= 0) {
        mostrarErro(context, "Preencha todos os campos corretamente.");
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SegundaTela(
              organizador: organizador.text,
              times: quantidadeTimes,
              dias: quantidadeDias,
            ),
          ),
        );
      }
    } catch (e) {
      mostrarErro(context, "Digite números válidos nos campos.");
    }
  }

  // Método para mostrar mensagem de erro
  void mostrarErro(BuildContext context, String mensagem) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Atenção"),
        content: Text(mensagem),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Organização do Campeonato"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: organizador,
              decoration: const InputDecoration(
                labelText: "Nome do organizador",
              ),
            ),
            TextField(
              controller: times,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Quantidade de times",
              ),
            ),
            TextField(
              controller: dias,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Quantidade de dias",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                abrirSegundaTela(context);
              },
              child: const Text("Continuar"),
            ),
          ],
        ),
      ),
    );
  }
}