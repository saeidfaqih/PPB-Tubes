import 'package:flutter/material.dart';


class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final List<Map<String, String>> messages = [
    {'sender': 'Me', 'text': 'Halo Admin!'},
    {'sender': 'Other', 'text': 'Hello! Ada yang bisa saya bantu?'},
  ];

  final TextEditingController _controller = TextEditingController();

  void _addMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add({'sender': 'Me', 'text': _controller.text});
      });
      _controller.clear();
    }
  }

  Widget _buildMessage(Map<String, String> message) {
    bool isMe = message['sender'] == 'Me';
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: isMe ? Colors.green : Colors.grey[300],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          message['text']!,
          style: TextStyle(
            color: isMe ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF94CABD),
        title: Text(
          'Yanto',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Membuat teks menjadi tebal (bold)
            color: Colors.white, // Warna teks putih
          ),
        ),
      ),

      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(messages[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Enter your message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _addMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MessageScreen(),
  ));
}
