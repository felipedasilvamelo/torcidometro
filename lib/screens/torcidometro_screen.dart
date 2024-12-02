import 'package:flutter/material.dart';
import 'package:torcidometro/components/graph_and_buttons.dart'; 


class TorcidometroScreen extends StatefulWidget {
  // Define a tela principal do Torcidômetro, que pode ter estado (stateful).
  const TorcidometroScreen({super.key});

  @override
  State<TorcidometroScreen> createState() => _TorcidometroScreenState();
  // Cria e gerencia o estado do widget.
}

class _TorcidometroScreenState extends State<TorcidometroScreen> {
  // Define a classe de estado para a tela.

  // Mapa para armazenar os votos de cada opção (time ou empate).
  Map<String, int> votos = {
    'Time A': 0, 
    'Time B': 0, 
    'Empate': 0, 
  };

  bool mostrarGrafico = true; 
  // Variável para alternar entre o gráfico de barras e a visualização alternativa.

  void adicionarVoto(String time) {
    // Função para adicionar um voto a uma opção específica.
    setState(() {
      // Atualiza o estado do widget para refletir as mudanças.
      votos[time] = (votos[time] ?? 0) + 1; 
      // Incrementa o valor correspondente à chave no mapa.
    });
  }

  void limparVotacao() {
    // Função para zerar todos os votos.
    setState(() {
      // Atualiza o estado para limpar os votos.
      votos = votos.map((key, value) => MapEntry(key, 0));
      // Cria um novo mapa com os mesmos times, mas todos os valores igual a 0.
    });
  }

  void editarVotos(String time) async {
    // Função para editar manualmente o número de votos de um time específico.
    TextEditingController controller = TextEditingController(); 
    // Controlador para capturar o valor digitado no campo de texto.

    await showDialog(
      // Mostra uma caixa de diálogo para o usuário.
      context: context,
      builder: (context) => AlertDialog(
        // Define o conteúdo da caixa de diálogo.
        title: Text('Editar votos - $time'), 
        // Título exibido no diálogo, mostrando qual time está sendo editado.
        content: TextField(
          controller: controller, 
          // Associa o controlador ao campo de texto.
          keyboardType: TextInputType.number, 
          // Define que o teclado deve ser numérico.
          decoration: const InputDecoration(
            labelText: 'Novo número de votos', 
            // Texto de ajuda dentro do campo de texto.
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            // Fecha o diálogo sem salvar as alterações.
            child: const Text('Cancelar'), 
            // Texto do botão de cancelar.
          ),
          TextButton(
            onPressed: () {
              int? novoValor = int.tryParse(controller.text); 
              // Tenta converter o valor digitado em um número inteiro.
              if (novoValor != null) {
                // Verifica se o valor é válido.
                setState(() {
                  votos[time] = novoValor; 
                  // Atualiza o número de votos no mapa.
                });
              }
              Navigator.pop(context); 
              // Fecha o diálogo após salvar.
            },
            child: const Text('Salvar'), 
            // Texto do botão de salvar.
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Função que constrói a interface da tela.

    // Calcula o total de votos somando os valores do mapa.
    int totalVotos = votos.values.fold(0, (soma, elemento) => soma + elemento);

    return Scaffold(
    
      appBar: AppBar(
        
        title: const Text('Torcidômetro'), 
      
        backgroundColor: const Color.fromARGB(255, 63, 145, 66), 
     
        centerTitle: true, 
      
        titleTextStyle: const TextStyle(
          color: Colors.white, 
         
          fontSize: 30, 
        
        ),
      ),
      body: Column(
        
        children: [
          const SizedBox(height: 20), 
          

          Row(
            // Linha para organizar o texto e o botão `Switch`.
            mainAxisAlignment: MainAxisAlignment.center, 
          
            children: [
              const Text('Mostrar Gráfico:'), 
              
              Switch(
                value: mostrarGrafico, 
                // Estado do `Switch`.
                onChanged: (valor) {
                  // Função chamada quando o `Switch` é alternado.
                  setState(() {
                    mostrarGrafico = valor; 
                    // Atualiza o estado para refletir a mudança.
                  });
                },
              ),
            ],
          ),

          mostrarGrafico 
              // Verifica se o gráfico deve ser exibido.
              ? GraphWidget(votos: votos, totalVotos: totalVotos) 
              // Exibe o widget do gráfico, passando os votos e o total.
              : Expanded(
                  // Exibe a lista com os resultados em um formato alternativo.
                  child: Padding(
                    padding: const EdgeInsets.all(16.0), 
                    
                    child: ListView(
                      // Lista para exibir os resultados.
                      children: votos.entries.map((entry) {
                        // Percorre as entradas do mapa.
                        return ListTile(
                          
                          title: Text(
                            entry.key, 
                            // Nome do time.
                            style: const TextStyle(fontSize: 18), 
                            // Estilo do texto do título.
                          ),
                          trailing: Text(
                            '${entry.value} votos', 
                            // Número de votos ao lado direito.
                            style: const TextStyle(
                              fontWeight: FontWeight.bold, 
                             
                              fontSize: 16, 
                              
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

          const Divider(), 
        

          ButtonsWidget(
            
            votos: votos, 
            // Passa o mapa de votos.
            adicionarVoto: adicionarVoto, 
            // Passa a função para adicionar votos.
            limparVotacao: limparVotacao, 
            // Passa a função para limpar os votos.
            editarVotos: editarVotos, 
            // Passa a função para editar votos.
          ),
        ],
      ),
    );
  }
}
