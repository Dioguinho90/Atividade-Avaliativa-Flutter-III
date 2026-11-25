import 'package:flutter/material.dart';
import 'quarta_tela.dart';

class TerceiraTela extends StatefulWidget {
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

  const TerceiraTela({
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
  });

  @override
  State<TerceiraTela> createState() => _TerceiraTelaState();
}

class _TerceiraTelaState extends State<TerceiraTela> {
  final arrecadacao = TextEditingController();
  final banda = TextEditingController();

  double saldo = 0;
  double estresse = 0;
  double taxaBanda = 0;

  bool calculado = false;
  bool riscoAlto = false;

  // Método para calcular o saldo
  void calcularSaldo(BuildContext context) {
    try {
      double valorArrecadacao = double.parse(arrecadacao.text);
      taxaBanda = double.parse(banda.text);

      if (valorArrecadacao <= 0 || taxaBanda < 1 || taxaBanda > 100) {
        mostrarErro(context, "Informe valores válidos. A banda deve ser de 1 a 100.");
      } else {
        setState(() {
          saldo = valorArrecadacao - widget.custoBruto;

          estresse = (taxaBanda / 10) * widget.dias;

          riscoAlto = taxaBanda > 85;

          calculado = true;
        });
      }
    } catch (e) {
      mostrarErro(context, "Digite valores numéricos válidos.");
    }
  }

  // Método para abrir a quarta tela
  void abrirQuartaTela(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuartaTela(
          organizador: widget.organizador,
          times: widget.times,
          dias: widget.dias,
          jogadoresPorTime: widget.jogadoresPorTime,
          totalJogadores: widget.totalJogadores,
          premiacaoPorTime: widget.premiacaoPorTime,
          custoDiario: widget.custoDiario,
          infraestrutura: widget.infraestrutura,
          custoPremiacao: widget.custoPremiacao,
          alimentacao: widget.alimentacao,
          custoBruto: widget.custoBruto,
          arrecadacao: double.parse(arrecadacao.text),
          taxaBanda: taxaBanda,
          saldo: saldo,
          estresse: estresse,
          riscoAlto: riscoAlto,
        ),
      ),
    );
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
        title: const Text("Arrecadação e Rede"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Custo total: R\$ ${widget.custoBruto.toStringAsFixed(2)}"),

            TextField(
              controller: arrecadacao,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Arrecadação do campeonato",
              ),
            ),
            TextField(
              controller: banda,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Taxa de banda (1 a 100)",
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                calcularSaldo(context);
              },
              child: const Text("Calcular saldo"),
            ),

            if (calculado) ...[
              const SizedBox(height: 20),
              Text(
                "Saldo: R\$ ${saldo.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 20,
                  color: saldo < 0 ? Colors.red : Colors.green,
                ),
              ),
              Text("Estresse da rede: ${estresse.toStringAsFixed(2)}"),
              if (saldo < 0)
                const Text(
                  "Atenção: Deficit Financeiro Detectado!",
                  style: TextStyle(color: Colors.red),
                ),
              if (riscoAlto)
                const Text(
                  "Atenção: Alto risco de lag!",
                  style: TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  abrirQuartaTela(context);
                },
                child: const Text("Gerar relatório"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}