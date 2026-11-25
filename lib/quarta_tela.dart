
import 'package:flutter/material.dart';
import 'tela_inicial.dart';

class QuartaTela extends StatelessWidget {
  final String organizador;
  final int times;
  final int dias;
  final int jogadoresPorTime;
  final int totalJogadores;
  final double premiacaoPorTime;
  final double custoDiario;
  final double infraestrutura;
  final double custoPremiacao;
  final double alimentacao;
  final double custoBruto;
  final double arrecadacao;
  final double taxaBanda;
  final double saldo;
  final double estresse;
  final bool riscoAlto;

  const QuartaTela({
    super.key,
    required this.organizador,
    required this.times,
    required this.dias,
    required this.jogadoresPorTime,
    required this.totalJogadores,
    required this.premiacaoPorTime,
    required this.custoDiario,
    required this.infraestrutura,
    required this.custoPremiacao,
    required this.alimentacao,
    required this.custoBruto,
    required this.arrecadacao,
    required this.taxaBanda,
    required this.saldo,
    required this.estresse,
    required this.riscoAlto,
  });

  // Método para iniciar um novo campeonato
  void novoCampeonato(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => TelaInicial(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    String resultado;

    if (saldo >= 0 && taxaBanda <= 85) {
      resultado =
          "Evento de Sucesso Absoluto (Sem Lag e Com Lucro)";
    } else if (saldo >= 0 && taxaBanda > 85) {
      resultado =
          "Lucrativo, mas com Instabilidade de Rede";
    } else {
      resultado =
          "Evento Prejudicial (Prejuízo Financeiro)";
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Relatório Final"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Organizador: $organizador"),
              Text("Quantidade de times: $times"),
              Text("Dias de evento: $dias"),
              Text("Jogadores por time: $jogadoresPorTime"),
              Text("Total de jogadores: $totalJogadores"),

              const SizedBox(height: 15),

              const Text(
                "DISCRIMINAÇÃO DOS CUSTOS",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              Text(
                "Infraestrutura: R\$ ${infraestrutura.toStringAsFixed(2)}",
              ),
              Text(
                "Premiação: R\$ ${custoPremiacao.toStringAsFixed(2)}",
              ),
              Text(
                "Alimentação: R\$ ${alimentacao.toStringAsFixed(2)}",
              ),
              Text(
                "Custo bruto: R\$ ${custoBruto.toStringAsFixed(2)}",
              ),

              const SizedBox(height: 15),

              const Text(
                "RESULTADO FINANCEIRO",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              Text(
                "Arrecadação: R\$ ${arrecadacao.toStringAsFixed(2)}",
              ),
              Text(
                "Saldo: R\$ ${saldo.toStringAsFixed(2)}",
                style: TextStyle(
                  color: saldo < 0 ? Colors.red : Colors.green,
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                "ANÁLISE DA REDE",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              Text(
                "Estresse da rede: ${estresse.toStringAsFixed(2)}",
              ),
              Text("Taxa de banda: $taxaBanda"),
              Text("Risco de lag: ${riscoAlto ? "Alto" : "Baixo"}"),

              const SizedBox(height: 15),

              const Text(
                "STATUS FINAL",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              Text(
                resultado,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              ElevatedButton(
                onPressed: () {
                  novoCampeonato(context);
                },
                child: const Text("Novo Campeonato"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
