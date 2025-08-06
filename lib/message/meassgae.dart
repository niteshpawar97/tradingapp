import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final _controller = TextEditingController();
  final List<Map<String, String>> _messages = [
    {'sender': 'Rajesh', 'text': 'Hello Jhon Abraham', 'time': '09:23 AM'},
    {'sender': 'Rajesh', 'text': 'Nazrul How are you', 'time': '09:23 AM'},
    {'sender': 'Rajesh', 'text': 'You did your job well!', 'time': '09:23 AM'},
    {
      'sender': 'Rajesh',
      'text': '00:16',
      'time': '09:23 AM',
      'isAudio': 'true',
    }, // Audio message
    {
      'sender': 'Rajesh',
      'text': 'Have a great working week! Hope you like it',
      'time': '09:25 AM',
    },
  ];

  void _submitMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add({
          'sender': 'You', // User-sent message
          'text': _controller.text,
          'time': DateTime.now().toString().substring(10, 16), // Current time
        });
        _controller.clear(); // Clear the input field after submission
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( centerTitle: true,
        title: Text(
          'Message',
          style: GoogleFonts.poppins(
            fontSize: 18.px,
            fontWeight: FontWeight.w800,
            color: Color(0xff000E08),
          ),
          textAlign: TextAlign.center,
        ),
       
      ),
      body: Column(
        children: [
          // Message List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: _messages.length + 1, // +1 for the 'Today' separator
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Center(
                    child: Text(
                      'Today',
                      style: GoogleFonts.poppins(
                        fontSize: 12.px,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff000E08),
                      ),
                    ),
                  );
                }
                final message = _messages[index - 1];
                bool isSentByUser = message['sender'] == 'You';

                return Row(
                  mainAxisAlignment:
                      isSentByUser
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!isSentByUser) ...[
                      CircleAvatar(
                        backgroundColor: Color(0xffEAFFAA),
                        child: Text(
                          message['sender']![0],
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(width: 8),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            isSentByUser
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                        children: [
                          Text(
                            message['sender']!,
                            style: GoogleFonts.poppins(
                              fontSize: 14.px,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff000E08),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(top: 4),
                            decoration: BoxDecoration(
                              color:
                                  isSentByUser
                                      ? Color(0xff748C27)
                                      : Colors.green[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child:
                                message['isAudio'] == 'true'
                                    ? Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.play_arrow, size: 16),
                                        SizedBox(width: 8),
                                        Text(message['text']!),
                                      ],
                                    )
                                    : Text(message['text']!),
                          ),
                          Text(
                            message['time']!,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    // if (isSentByUser) ...[
                    //   SizedBox(width: 8),
                    //   CircleAvatar(
                    //     // backgroundColor: Color(0xff748C27),
                    //     child: Text(message['sender']![0], style: TextStyle(color: Colors.black)),
                    //   ),
                    // ],
                  ],
                );
              },
            ),
          ),
          // Input Field
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Write your message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: Icon(Icons.edit),
                    ),
                    onFieldSubmitted:
                        (_) => _submitMessage(), // Submit on Enter
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Color(0xffBFE841)),
                  onPressed: _submitMessage, // Submit on button press
                ),
              ],
            ),
          ),
          SizedBox(height: 3.h,)
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
