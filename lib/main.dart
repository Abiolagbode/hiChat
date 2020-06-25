import 'package:abiolachat/screen/auth_screen.dart';
import 'package:abiolachat/screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

/* created by Abiola Gbode
repo -> https://github.com/abiolagbode
whatsapp: +2348176391092
email: infogbodeabiola@gmail.com
 */

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HiChat',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        backgroundColor: Colors.pink,
        accentColor: Colors.deepPurple,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
        ),
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder(stream: FirebaseAuth.instance.onAuthStateChanged,builder: (ctx, userSnapshot){
        if(userSnapshot.hasData){
          return ChatScreen();
        }else
        return AuthScreen();
      },),
    );
  }
}
