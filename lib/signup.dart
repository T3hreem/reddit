

import 'dart:io';

import 'package:flutter/material.dart';
import 'feed.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key key}) : super(key: key);
  TextEditingController email = TextEditingController(text: "");
  TextEditingController username = TextEditingController(text: "");
  TextEditingController password = TextEditingController(text: "");
  TextEditingController configpassword = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          "Sing up",
                          style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("Create an account, it's free",
                            style: TextStyle(fontSize: 15, color: Colors.grey[700]))
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: <Widget>[
                          inputFile(label: "Email"),
                          inputFile(label: "Username"),
                          inputFile(label: "Password", obscureText: true),
                          inputFile(label: "Confirm Password", obscureText: true),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        padding: EdgeInsets.only(top: 3, left: 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border(
                              bottom: BorderSide(color: Colors.black),
                              top: BorderSide(color: Colors.black),
                              left: BorderSide(color: Colors.black),
                              right: BorderSide(color: Colors.black),
                            )),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: () { ///////////////0(pasword qalat) 1(okeye) -1(moshkel!!)////////////////////
                            send();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FeedPage()));
                          },
                          color: Colors.deepOrange,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            "Sing up",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 100),
                      height: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/signup.png"),
                              fit: BoxFit.fitHeight)),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
  Future<int> send() async {
    String request = "signup-$email-$username-$password\u0000";
    bool check;
    if(password!=configpassword){
       return 0;
    }

    await Socket.connect("10.0.2.2", 1234).then((serverSocket){
      serverSocket.write(request);
      serverSocket.flush();
      serverSocket.listen((response){check = response as bool;});
    });
  }
}

Widget inputFile({label, obscureText = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87),
      ),
      SizedBox(
        height: 5,
      ),
      TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      ),
      SizedBox(
        height: 10,
      )
    ],
  );
}


