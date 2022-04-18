import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late FocusNode myFocusNode;
  final _outputTextController = TextEditingController();
  final _inputTextController = TextEditingController();
  final translator = GoogleTranslator();
  late String inputText;
  dynamic outputText;
  String languageCode = "en";
  String dropdownValue = 'English - en';
  void translation(String input, String code) async {
    await translator.translate(input, to: code).then((value) {
      setState(() {
        outputText = value;
        _outputTextController.text = outputText.toString();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Machine Translation"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(25),
              child: Column(
                children: [
                  const Text(
                    "Translator",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _inputTextController,
                    decoration: const InputDecoration(
                      hintText: "Enter text to translate",
                      labelText: "Text to Translate",
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 5,
                    onChanged: (value) {
                      setState(() {
                        inputText = value;
                      });
                    },
                    focusNode: myFocusNode,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Select Language: ",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownButton(
                          value: dropdownValue,
                          items: [
                            "English - en",
                            "Hindi - hi",
                            "Marathi - mr",
                            "Gujarati - gu",
                            "French - fr",
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                              languageCode =
                                  newValue.substring(newValue.length - 2);
                              myFocusNode.unfocus();
                            });
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        myFocusNode.unfocus();
                        translation(inputText, languageCode);
                      });
                    },
                    child: const Text("Translate"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _outputTextController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: "Translated Text",
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _outputTextController.clear();
                        _inputTextController.clear();
                        dropdownValue = "English - en";
                      });
                    },
                    child: const Text("Clear"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
