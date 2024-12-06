import 'dart:convert';
import 'package:http/http.dart' as http;
import '../objects/imovel.dart';

class ApiService {
  Future<List<Imovel>> fetchImovel() async {
    final response = await http
        .get(Uri.parse('https://arquivos.ectare.com.br/imoveis.json'));

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((item) => Imovel.fromJson(_replaceSpecialCharacters(item)))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Map<String, dynamic> _replaceSpecialCharacters(Map<String, dynamic> json) {
    final Map<String, dynamic> processedData = {};

    json.forEach((key, value) {
      if (value is String) {
        // Substituir caracteres especiais em strings
        processedData[key] = _cleanString(value);
      } else {
        // Manter outros tipos de dados
        processedData[key] = value;
      }
    });

    return processedData;
  }

  /// Função para limpar caracteres especiais de uma string
  String _cleanString(String value) {
    const Map<String, String> replacements = {
      'á': 'a',
      'à': 'a',
      'ã': 'a',
      'â': 'a',
      'é': 'e',
      'è': 'e',
      'ê': 'e',
      'í': 'i',
      'ì': 'i',
      'î': 'i',
      'ó': 'o',
      'ò': 'o',
      'õ': 'o',
      'ô': 'o',
      'ú': 'u',
      'ù': 'u',
      'û': 'u',
      'ç': 'c',
      'Á': 'A',
      'À': 'A',
      'Ã': 'A',
      'Â': 'A',
      'É': 'E',
      'È': 'E',
      'Ê': 'E',
      'Í': 'I',
      'Ì': 'I',
      'Î': 'I',
      'Ó': 'O',
      'Ò': 'O',
      'Õ': 'O',
      'Ô': 'O',
      'Ú': 'U',
      'Ù': 'U',
      'Û': 'U',
      'Ç': 'C',
    };

    // Substituir cada caractere especial pela sua versão limpa
    String cleanedValue = value;
    replacements.forEach((char, replacement) {
      cleanedValue = cleanedValue.replaceAll(char, replacement);
    });

    return cleanedValue;
  }
}
