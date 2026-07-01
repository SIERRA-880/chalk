import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class MistralAgentService {
  MistralAgentService({required this.apiKey, http.Client? client})
      : _client = client ?? http.Client();

  final String apiKey;
  final http.Client _client;

  static const _endpoint = 'https://api.mistral.ai/v1/chat/completions';
  static const _model = 'mistral-small-latest';
  static const _timeout = Duration(seconds: 60);
  static const _systemPrompt =
      'Tu es un coach sportif expert en musculation. '
      'Réponds STRICTEMENT en JSON valide au schéma {"summary": "<markdown>"}. '
      'Le champ summary contient du markdown lisible (titres, listes) qui '
      'analyse l\'ACWR, les records 1RM, l\'historique et propose des '
      'conseils actionnables.';

  Future<Map<String, dynamic>> getAdvice(Map<String, dynamic> payload) async {
    final http.Response res;
    try {
      res = await _client
          .post(
            Uri.parse(_endpoint),
            headers: {
              'Authorization': 'Bearer $apiKey',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'model': _model,
              'response_format': {'type': 'json_object'},
              'messages': [
                {'role': 'system', 'content': _systemPrompt},
                {'role': 'user', 'content': jsonEncode(payload)},
              ],
            }),
          )
          .timeout(_timeout);
    } on TimeoutException {
      throw Exception('Délai dépassé (${_timeout.inSeconds} s). Réessaie.');
    }
    if (res.statusCode != 200) {
      throw Exception('Mistral ${res.statusCode}: ${res.body}');
    }
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    final content =
        (body['choices'] as List).first['message']['content'] as String;
    return jsonDecode(content) as Map<String, dynamic>;
  }
}
