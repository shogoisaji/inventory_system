import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_various/presentation/wedget/text_style.dart';

import '../../infrastructure/firebase/auth_service.dart';
import '../wedget/custom_bottun.dart';

class SignInPage extends StatelessWidget {
  String? mailAddress;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Column(children: [
          Stack(children: [
            Positioned(
              child: Container(
                width: double.infinity,
                height: 450,
                color: Colors.red[200],
              ),
            ),
            Positioned(
              left: 50,
              top: 50,
              child: Container(
                width: 450,
                height: 450,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/inventory_top.png'),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            Positioned(
                left: 0,
                top: 420,
                right: 0,
                child: Container(
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(130, 0, 0, 0),
                        offset: Offset(0, 0),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                )),
            Positioned(
              left: 15,
              top: 10,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleText(
                      text: 'Inventory',
                      color: Colors.white,
                      size: 46,
                    ),
                    TitleText(
                      text: 'Management',
                      color: Colors.white,
                      size: 46,
                    ),
                    TitleText(
                      text: 'System',
                      color: Colors.white,
                      size: 46,
                    ),
                  ]),
            ),
          ]),
          Container(
            constraints: const BoxConstraints(
              maxWidth: 450.0,
            ),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(left: 30, right: 30),
            child: TextField(
              onChanged: (text) {
                mailAddress = text;
              },
              decoration: const InputDecoration(
                labelText: 'Email Address',
                labelStyle: TextStyle(color: Colors.blueGrey),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.blueGrey,
                )),
              ),
            ),
          ),
          Container(
            constraints: const BoxConstraints(
              maxWidth: 450.0,
            ),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(left: 30, right: 30),
            child: TextField(
              obscureText: true,
              onChanged: (text) {
                password = text;
              },
              decoration: const InputDecoration(
                  labelText: 'password',
                  labelStyle: TextStyle(color: Colors.blueGrey),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.blueGrey,
                  ))),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          CustomButton(
              text: 'ログイン',
              mainColor: Color.fromARGB(255, 174, 217, 224),
              shadowColor: Color.fromARGB(255, 45, 45, 45).withOpacity(0.2),
              width: 150,
              height: 50,
              textSize: 20,
              onPressed: () async {
                try {
                  if (mailAddress != null && password != null) {
                    final service = AuthService();
                    await service.signIn(mailAddress!, password!);
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("空欄があります"),
                          content: const Text("すべて記入してください"),
                          actions: [
                            TextButton(
                              child: const Text("OK"),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        );
                      },
                    );
                  }
                } on FirebaseAuthException catch (_) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("ログインに失敗しました"),
                        content: const Text("ログイン情報を確認してください"),
                        actions: [
                          TextButton(
                            child: const Text("OK"),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      );
                    },
                  );
                }
              }),
          const SizedBox(
            height: 20.0,
          ),
          CustomButton(
              text: 'ユーザー登録',
              mainColor: const Color.fromARGB(255, 255, 166, 158),
              shadowColor: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
              width: 150,
              height: 50,
              textSize: 20,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      TextEditingController _emailController =
                          TextEditingController();
                      TextEditingController _passwordController =
                          TextEditingController();
                      TextEditingController _nameController =
                          TextEditingController();
                      TextEditingController _departmentController =
                          TextEditingController();

                      return AlertDialog(
                        backgroundColor: Color.fromARGB(255, 225, 242, 255),
                        title: const Text('アカウント登録'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Container(
                                width: 400,
                                child: TextField(
                                  controller: _emailController,
                                  decoration:
                                      const InputDecoration(hintText: "Email"),
                                ),
                              ),
                              const Text('必須',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.red)),
                              const SizedBox(
                                height: 5,
                              ),
                              TextField(
                                controller: _passwordController,
                                decoration:
                                    const InputDecoration(hintText: "Password"),
                                obscureText: true,
                              ),
                              const Text('必須',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.red)),
                              const SizedBox(
                                height: 5,
                              ),
                              TextField(
                                controller: _nameController,
                                decoration:
                                    const InputDecoration(hintText: "名前"),
                              ),
                              const Text('必須',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.red)),
                              const SizedBox(
                                height: 5,
                              ),
                              TextField(
                                controller: _departmentController,
                                decoration:
                                    const InputDecoration(hintText: "部署"),
                              ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Cancel',
                                style: TextStyle(
                                  fontSize: 18,
                                )),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('登録',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600)),
                            onPressed: () async {
                              if (_emailController.text.isEmpty ||
                                  _passwordController.text.isEmpty ||
                                  _nameController.text.isEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('警告'),
                                      content: const Text('必須項目は入力してください'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                AuthService authService = AuthService();
                                var user = await authService.createUser(
                                  _nameController.text,
                                  _emailController.text,
                                  _passwordController.text,
                                  _departmentController.text,
                                );
                                if (user != null) {
                                  print("User created successfully");
                                } else {
                                  print("Failed to create user");
                                }
                              }
                            },
                          ),
                        ],
                      );
                    });
              }),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                final service = AuthService();
                await service.signIn('sample@gmail.com', 'password');
              } on FirebaseAuthException catch (_) {
                debugPrint("signerror");
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("ログインに失敗しました"),
                      content: const Text("ログイン情報を確認してください"),
                      actions: [
                        TextButton(
                          child: const Text("OK"),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(180, 40),
                primary: Color.fromARGB(155, 255, 237, 187),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10) //こちらを適用
                    )),
            child: const Text(
              'Sample Account',
              style:
                  TextStyle(fontSize: 20, color: Color.fromARGB(108, 0, 0, 0)),
            ),
          ),
        ]),
      ]),
    );
  }
}
