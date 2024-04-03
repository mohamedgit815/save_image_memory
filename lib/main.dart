import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/home_page.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  final prefs = await SharedPreferences.getInstance();

  String? id = prefs.getString('id');
  String? name = prefs.getString('name');
  String? email = prefs.getString('email');
  String? image = prefs.getString('image');

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);


  runApp(ProviderScope(child: MyApp(
    name: name ?? "name", email: email ?? "Email", id: id ?? "ID", image: image ?? "Image",
  )));

}




class MyApp extends StatelessWidget {
  final String name , id , email, image;
  const MyApp({super.key, required this.image, required this.id, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(name: name, email: email, id: id, image: image, )
    );
  }
}
