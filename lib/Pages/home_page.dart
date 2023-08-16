import 'package:assist/Pages/feature_box.dart';
import 'package:assist/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final speechToText = SpeechToText();
  String lastWords = '';
  @override
  void initState() {
    super.initState();
    initSpeechToText();
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Isharab'),
        centerTitle: true,
        leading: const Icon(Icons.menu),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // virtual assistane picture part
            Stack(
              children: [
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    margin: const EdgeInsets.only(top: 4),
                    decoration: const BoxDecoration(
                      color: Pallete.assistantCircleColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Container(
                  height: 123,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/virtualAssistant.png'),
                    ),
                  ),
                )
              ],
            ),
            // chat bubble part
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: const EdgeInsets.symmetric(
                horizontal: 40,
              ).copyWith(top: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20).copyWith(
                  topLeft: const Radius.circular(0),
                ),
                border: Border.all(
                  color: Pallete.borderColor,
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Good Morning, What task should i assist you with?',
                  style: TextStyle(
                    fontFamily: 'Cera Pro',
                    color: Pallete.mainFontColor,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            // text field part
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(
                left: 10,
                top: 20,
              ),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Here are a few suggestions',
                style: TextStyle(
                  fontFamily: 'Cera Pro',
                  color: Pallete.mainFontColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // features list part
            const Column(
              children: [
                FeatureBox(
                  color: Pallete.firstSuggestionBoxColor,
                  headerText: 'ChatGPT',
                  bodyText:
                      'A smarter way to stay organized and informed with ChatGPT.',
                ),
                FeatureBox(
                  color: Pallete.secondSuggestionBoxColor,
                  headerText: 'DALL-E',
                  bodyText:
                      'Get inspired and stay creative with your personal assistat powerd by Dall-E.',
                ),
                FeatureBox(
                  color: Pallete.thirdSuggestionBoxColor,
                  headerText: 'Smart Voice Assistant',
                  bodyText:
                      'Get the best of both worlds with voice assistant powered by Dall-E and ChatGPT.',
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Pallete.firstSuggestionBoxColor,
        onPressed: () async {
          if (await speechToText.hasPermission && speechToText.isNotListening) {
            startListening();
          } else if (speechToText.isListening) {
            stopListening();
          } else {
            initSpeechToText();
          }
        },
        child: const Icon(Icons.mic),
      ),
    );
  }
}
