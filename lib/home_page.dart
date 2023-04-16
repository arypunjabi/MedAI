import 'package:cancer_detection/camera.dart';
import 'package:cancer_detection/openai_service.dart';
import 'package:cancer_detection/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final speechToText = SpeechToText();
  final flutterTts = FlutterTts();
  String lastWords = "";
  String txt = "Good morning. What task may I do for you today";
  String inputText = "";
  final OpenAIService openAIService = OpenAIService();
  String? generatedContent;
  String? generatedImageUrl;
  bool firstText = true;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    Color col = Pallete.firstSuggestionBoxColor;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Medical Emergency"),
        leading: InkWell(
          child: const Icon(Icons.camera_alt),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const camera()),
            );
          },
        ),
      ),
      body: ListView(
        children: [
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
          //chat bubble

          Visibility(
            visible:
                (generatedContent != null || firstText == true) ? true : false,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              margin: const EdgeInsets.only(left: 10, top: 30, right: 40),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Pallete.borderColor,
                  ),
                  borderRadius:
                      BorderRadius.circular(20).copyWith(topLeft: Radius.zero)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  (generatedContent == null)
                      ? "Hello. What can I help you with today?"
                      : generatedContent!,
                  style: TextStyle(
                      color: Pallete.mainFontColor,
                      fontSize: (generatedContent == null) ? 18 : 15,
                      fontFamily: 'Cera Pro'),
                ),
              ),
            ),
          ),
          if (generatedImageUrl != null)
            Padding(
                padding: EdgeInsets.all(50),
                child: Image.network(generatedImageUrl!)),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 30,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ).add(
            const EdgeInsets.all(12.0),
          ),
          child: OverflowBar(
            overflowAlignment: OverflowBarAlignment.center,
            alignment: MainAxisAlignment.center,
            overflowSpacing: 5.0,
            children: [
              Row(
                children: [
                  SizedBox(width: 5),
                  FloatingActionButton(
                    backgroundColor: col,
                    onPressed: () async {
                      if (await speechToText.hasPermission &&
                          speechToText.isNotListening) {
                        await startListening();
                      } else if (speechToText.isListening) {
                        final speech =
                            await openAIService.isArtPromptAPI(lastWords);
                        await stopListening();
                        if (speech.contains('https')) {
                          generatedImageUrl = speech;
                          generatedContent = null;
                          setState(() {});
                        } else {
                          generatedImageUrl = null;
                          generatedContent = speech;
                          setState(() {});
                          await systemSpeak(speech);
                        }
                        firstText = false;
                      } else {
                        initSpeechToText();
                      }
                    },
                    child: const Icon(Icons.mic),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 280,
                    child: TextField(
                      controller: textEditingController,
                      onSubmitted: (String val) async {
                        inputText = val;
                        textEditingController.clear();
                        final speech =
                            await openAIService.isArtPromptAPI(inputText);
                        if (speech.contains('https')) {
                          generatedImageUrl = speech;
                          generatedContent = null;
                          setState(() {});
                        } else {
                          generatedImageUrl = null;
                          generatedContent = speech;
                          setState(() {});
                          await systemSpeak(speech);
                        }
                        firstText = false;
                      },
                      obscureText: false,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Input"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
