import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final String name , id , email, image;
  const HomePage({super.key, required this.image, required this.id, required this.name, required this.email});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                    onPressed: () async {
                      // final List data = await getData();
                      // SharedPreferences pref = await SharedPreferences.getInstance();
                      // print(data.elementAt(0)['avatar']);
                      await getData();
                    },
                    child: const Text("data")
                ) ,

                Text(widget.id.toString()),
                Text(widget.name.toString()),
                Text(widget.email.toString()),
                
                Image.memory(base64Decode(widget.image))
              ],

        ),
      ),
    );
  }
  
  Future<void> getData() async {
    final http.Response response = await http.get(Uri.parse('https://api.escuelajs.co/api/v1/users/1'));
    final Map<String,dynamic> data = await jsonDecode(response.body);
    String image64 = await networkImageToBase64(data['avatar']);
    final prefs = await SharedPreferences.getInstance();
    
    if(response.statusCode == 200) {
      await prefs.setString("id", data['id'].toString());
      await prefs.setString("email", data['email']);
      await prefs.setString("name", data['name']);
      await prefs.setString("image", image64);
      print("dataSave");
    }
  }


  Future<String> networkImageToBase64(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    final Uint8List bytes = response.bodyBytes;
    return base64Encode(bytes);
  }
}
