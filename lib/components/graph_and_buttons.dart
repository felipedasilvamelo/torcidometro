import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
//colocar ícone do perfil do time em cima da barrinha. 

// Widget do gráfico.
class GraphWidget extends StatelessWidget {
  final Map<String, int> votos; // Dados de votos.
  final int totalVotos; // Total de votos.

  const GraphWidget({
    super.key,
    required this.votos,
    required this.totalVotos,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0), // Adiciona espaçamento horizontal ao gráfico.
        child: BarChart(
          BarChartData(
            // Define o valor máximo do eixo Y como o total de votos (ou 1, se não houver votos).
            maxY: totalVotos > 0 ? totalVotos.toDouble() : 1,
            barGroups: votos.entries.map((entry) {
              final time = entry.key; // Nome do time (chave do mapa).
              final count = entry.value; // Número de votos (valor do mapa).
              return BarChartGroupData(
                x: votos.keys.toList().indexOf(time), // Índice do time.
                barRods: [
                  BarChartRodData(
                    toY: count.toDouble(), // Altura da barra.
                    width: 20, // Largura da barra.
                    color: Colors.teal, // Cor da barra.
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 2.0, // Borda da barra.
                    ),
                  ),
                ],
                showingTooltipIndicators: [0], // Exibe o tooltip no índice 0.
              );
            }).toList(),
            titlesData: FlTitlesData(
              // Remove os números do lado esquerdo (eixo Y).
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false, // Oculta o eixo Y.
                ),
              ),
              // Personaliza os títulos abaixo das barras (eixo X).
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true, // Exibe os títulos no eixo X.
                  getTitlesWidget: (value, meta) {
                    // Verifica se o índice está dentro do range de votos.
                    if (value.toInt() < votos.keys.length) {
                      return Text(
                        votos.keys.elementAt(value.toInt()), // Nome do time.
                        style: const TextStyle(fontSize: 12), // Estilo do texto.
                      );
                    }
                    return const Text('');
                  },
                  reservedSize: 20, // Ajusta o espaço reservado para os rótulos no eixo X. (Correção aplicada)
                ),
              ),
            ),
            gridData: const FlGridData(
              show: true, // Remove as linhas de grade do gráfico.
            ),
          ),
        ),
      ),
    );
  }
}

// Widget dos botões.
class ButtonsWidget extends StatelessWidget {
  final Map<String, int> votos; // Dados de votos.
  final Function(String) adicionarVoto; // Função para adicionar votos.
  final VoidCallback limparVotacao; // Função para limpar a votação.
  final Function(String) editarVotos; // Função para editar votos.

  const ButtonsWidget({
    super.key,
    required this.votos,
    required this.adicionarVoto,
    required this.limparVotacao,
    required this.editarVotos,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          // Botões para votar.
          ...votos.keys.map((time) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Adiciona espaçamento ao redor dos botões.
              child: ElevatedButton(
                onPressed: () => adicionarVoto(time), // Adiciona um voto ao time.
                child: Text(
                  'Votar no $time', // Texto do botão exibindo o nome do time.
                  style: const TextStyle(color: Colors.black), // Define a cor do texto do botão.
                ),
              ),
            );
          }),

          // Botões para editar votos.
          ...votos.keys.map((time) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0), // Define o espaçamento entre os botões.
              child: OutlinedButton(
                onPressed: () => editarVotos(time), // Chama a função para editar votos.
                child: Text('Editar votos de $time'), // Texto do botão.
              ),
            );
          }),

          // Botão para limpar os votos.
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Define espaçamento ao redor do botão.
            child: ElevatedButton(
              onPressed: limparVotacao, // Chama a função para limpar os votos.
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red), // Estilo do botão.
              child: const Text(
                'Limpar votação', // Texto do botão.
                style: TextStyle(
                  color: Colors.white, // Cor do texto do botão.
                  fontSize: 20, // Tamanho da fonte do botão.
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
