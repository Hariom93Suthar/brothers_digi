import 'dart:convert';
import 'package:brothers_digi/Backend/Chatbot/appD_chatbot.dart';
import 'package:brothers_digi/utils/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];
  List<String> suggestions = [
    "About Brothers Digi",
    "What's Your Services",
    "App Development",
    "Digital Marketing",
    "Information"
  ];
  //final String apiUrl = 'http://localhost:3000/chat';  // Replace with your local IP
  final String apiUrl = 'http://192.168.1.17:3000/chat';  // Use your local machine IP

  @override
  void initState() {
    super.initState();
    // Send a welcome message when the screen loads
    sendMessage('Hii ChatBot', 'general');
  }
  void addNewSuggestions() {
    setState(() {
      suggestions.addAll([
        "about you",
        "How does Firebase Authentication work?",
        "Can you explain Dart null safety?",
      ]);
    });
  }

  Future<void> sendMessage(String userMessage, String category) async {
    setState(() {
      messages.add({'user': userMessage, 'bot': '', 'isLoading': true});
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'category': category, 'question': userMessage}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          messages[messages.length - 1] = {
            'user': userMessage,
            'bot': data['reply'],
            'isLoading': false,
          };
        });
      } else {
        setState(() {
          messages[messages.length - 1] = {
            'user': userMessage,
            'bot': 'Failed to get response.',
            'isLoading': false,
          };
        });
      }
    } catch (e) {
      setState(() {
        messages[messages.length - 1] = {
          'user': userMessage,
          'bot': 'Error: $e',
          'isLoading': false,
        };
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading:false,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          toolbarHeight: 50,
          backgroundColor:CustomColor.primaryColor,
          title: Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.width*.30,),
              Lottie.asset("assets/lottie/Animation - 1734084167850.json",
                height: 50,
                width: 50,
              ),
              SizedBox(width: 5,),
              Text('ChatBot',style: TextStyle(
                  color: CustomColor.whitecolor
              ),),
            ],
          )
      ),
      body: Column(
        children: [
          Wrap(
            spacing: 8.0,
            children: List.generate(suggestions.length, (index) {
              return ElevatedButton(
                onPressed: () {
                  sendMessage(suggestions[index],'general');
                  setState(() {
                    suggestions.removeAt(index); // Question remove kar do
                  });

                  // Naye suggestions add karne ka call
                  if (suggestions.isEmpty) {
                    addNewSuggestions();
                  }
                },
                child: Text(suggestions[index]),
              );
            }),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(messages.length, (index) {
                  return ListTile(
                    title: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Text(
                          '${messages[index]['user']}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8.0),
                        messages[index]['isLoading']
                            ? Row(
                          children: [
                            Lottie.asset(
                              'assets/lottie/Animation - 1734083774272.json', // Animation file
                              width: 80, // Adjust size as needed
                              height: 80,
                            ),
                          ],
                        )
                            : AnimatedOpacity(
                          opacity: 1.0,
                          duration: Duration(milliseconds: 500), // Animation duration
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${messages[index]['bot']}'.replaceAll("\\n", "\n"), // Normal bot text
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  if (messages[index]['bot'].contains("tap here"))
                                    TextSpan(
                                      text: " Tap here", // Tappable text
                                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          // Navigate or perform an action
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>ChatScreen(), // Replace with your screen
                                            ),
                                          );
                                        },
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: CustomColor.primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: 'Ask something...',
                suffixIcon: IconButton(
                  onPressed: () {
                    sendMessage(_controller.text, 'general');
                    _controller.clear();
                  },
                  icon: Icon(Icons.send, size: 30, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
