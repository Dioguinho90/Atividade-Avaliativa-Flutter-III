
import 'package:flutter/material.dart';
import 'terceira_tela.dart';

class SegundaTela extends StatelessWidget {
  final String organizador;
  final int times;
  final int dias;

  SegundaTela({
    super.key,
    required this.organizador,
    required this.times,
    required this.dias,
  });

  final jogadores = TextEditingController();
  final premiacao = TextEditingController();
  final custoDiario = TextEditingController();

  // Método para abrir a terceira tela
  void abrirTerceiraTela(BuildContext context) {
    try {
      int jogadoresPorTime = int.parse(jogadores.text);
      double premiacaoPorTime = double.parse(premiacao.text);
      double custoPorDia = double.parse(custoDiario.text);

      if (jogadoresPorTime <= 0 ||
          premiacaoPorTime <= 0 ||
          custoPorDia <= 0) {
        mostrarErro(context, "Todos os valores devem ser maiores que zero.");
      } else {
        int totalJogadores = times * jogadoresPorTime;

        double infraestrutura = totalJogadores * custoPorDia * dias;

        double custoPremiacao = times * premiacaoPorTime;

        double alimentacao = totalJogadores * dias * 40.00;

        double custoBruto =
            infraestrutura + custoPremiacao + alimentacao;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TerceiraTela(
              organizador: organizador,
              times: times,
              dias: dias,
              jogadoresPorTime: jogadoresPorTime,
              totalJogadores: totalJogadores,
              premiacaoPorTime: premiacaoPorTime,
              custoDiario: custoPorDia,
              infraestrutura: infraestrutura,
              custoPremiacao: custoPremiacao,
              alimentacao: alimentacao,
              custoBruto: custoBruto,
            ),
          ),
        );
      }
    } catch (e) {
      mostrarErro(context, "Digite valores numéricos válidos.");
    }
  }

  // Método para mostrar erro
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
        title: const Text("Custos do Campeonato"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Organizador: $organizador"),
            Text("Times: $times"),
            Text("Dias: $dias"),
            const SizedBox(height: 15),

            TextField(
              controller: jogadores,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Jogadores por time",
              ),
            ),
            TextField(
              controller: premiacao,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: "Premiação por time",
              ),
            ),
            TextField(
              controller: custoDiario,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: "Custo diário por jogador",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                abrirTerceiraTela(context);
              },
              child: const Text("Calcular custos"),
            ),
          ],
        ),
      ),
    );
  }
}
