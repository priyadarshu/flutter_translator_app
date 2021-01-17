import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Translator',
      theme: ThemeData(
          primaryColor: Colors.grey,
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textEditingController = TextEditingController();
  GoogleTranslator translator = GoogleTranslator();
  var output;
  String dropdownValue;

  static const Map<String, String> lang = {
    "Hindi": "hi",
    "English": "en",
    "Urdu": "ur",
    "Russian": "ru",
    "Arabic": "ar",
    "French": "fr",
    "German": "de",
  };

  void trans() {
    translator
        .translate(textEditingController.text, to: "$dropdownValue")
        .then((value) {
      setState(() {
        output = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Multi Language Translator",
          style: TextStyle(
            color: Colors.white,
            backgroundColor: Colors.grey,
            fontSize: 23.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              style: TextStyle(fontSize: 24, color: Colors.blueGrey),
              controller: textEditingController,
              onTap: () {
                trans();
              },
              decoration: InputDecoration(
                labelText: 'Type Here',
                labelStyle: TextStyle(fontSize: 15),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Select Language here =>",
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w500),
              ),
              DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(Icons.arrow_drop_down_rounded),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.blueGrey),
                underline: Container(
                  height: 2,
                  color: Colors.blueGrey,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                    trans();
                  });
                },
                items: lang
                    .map((string, value) {
                      return MapEntry(
                        string,
                        DropdownMenuItem<String>(
                          value: value,
                          child: Text(string),
                        ),
                      );
                    })
                    .values
                    .toList(),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            'Translated Text',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            output == null ? "Please Select Language" : output.toString(),
            style: GoogleFonts.niconne(
              textStyle: TextStyle(
                  fontSize: 30,
                  color: Colors.purpleAccent,
                  //fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
