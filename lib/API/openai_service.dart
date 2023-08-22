import 'dart:convert';

import 'package:assist/Pages/secrets.dart';
import 'package:http/http.dart' as http;

class OpenAIService {
  Future<String> isArtPromptAPI(String prompt) async {
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIApiKey'
        },
        body: jsonEncode(
          {
            'model': 'gpt-3.5-turbo',
            'messages': [
              {
                'role': 'user',
                'content':
                    'Does this message want to generate AI picture, Image, Art or something similar? $prompt . Simply answer with Yes or No',
              }
            ],
          },
        ),
      );
      print(res.body);
      if (res.statusCode == 200) {
        print('yay');
      }
      return 'AI';
    } catch (e) {
      return (e).toString();
    }
  }

  Future<String> isChatGPTAPI(String prompt) async {
    return "Chat GPT";
  }

  Future<String> isDallEAPI(String prompt) async {
    return "DallE";
  }
}
