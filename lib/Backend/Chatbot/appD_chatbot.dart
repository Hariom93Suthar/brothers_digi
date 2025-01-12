// import 'package:flutter/material.dart';
// import 'chat_provider.dart';
//
// class ChatScreen extends StatefulWidget {
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   final ChatProvider _chatProvider = ChatProvider();
//   final TextEditingController _controller = TextEditingController();
//   List<Map<String, String>> messages = [];
//
//   void sendMessage() async {
//     final userMessage = _controller.text;
//     if (userMessage.isNotEmpty) {
//       setState(() {
//         messages.add({'sender': 'user', 'text': userMessage});
//       });
//       _controller.clear();
//
//       final botResponse = await _chatProvider.sendMessage(userMessage);
//       setState(() {
//         messages.add({'sender': 'bot', 'text': botResponse});
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('ChatGPT Chatbot')),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 final message = messages[index];
//                 final isUser = message['sender'] == 'user';
//                 return Align(
//                   alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
//                   child: Container(
//                     margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: isUser ? Colors.blue : Colors.grey,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Text(
//                       message['text']!,
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: InputDecoration(hintText: 'Type your message'),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:brothers_digi/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];
  List<String> suggestions = [
    "What is Flutter?",
    "How to use Firebase?",
    "Tell me about Dart language.",
    "What is state management?",
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
        "What is Flutter 3?",
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25))
        ),
        toolbarHeight: 50,
          backgroundColor:CustomColor.primaryColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("assets/lottie/Animation - 1734084167850.json",
                height: 50,
                width: 50,
              ),
              SizedBox(width: 5,),
              Text('AppD Chat',style: TextStyle(
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
                  sendMessage(suggestions[index],'app');
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
                            child: Text(
                              '${messages[index]['bot']}', // Bot response
                              style: TextStyle(color: Colors.black),
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
                    sendMessage(_controller.text, 'app');
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
