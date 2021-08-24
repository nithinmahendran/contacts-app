import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Kontakt",
                style: TextStyle(
                    fontSize: 39.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600)),
            Text(
              "Version 1.0.0.1",
              style: TextStyle(color: Colors.white),
            ),

            Padding(
              padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
              child: Container(
                height: 110.0,
                child: Image.asset('assets/images/kontaktlogowhite.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:25.0),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Made with",style: TextStyle(color: Colors.white),),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 30.0,
                    child: Image.asset('assets/images/heartemoji.png'),
                  ),
                ),
              ],),
            )
          ],
        ),
      ),
    );
  }
}
