import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../application/state/state.dart';
import '../../infrastructure/firebase/auth_service.dart';
import '../wedget/text_style.dart';
import '../wedget/custom_bottun.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    String email = user!.email!;
    String username = email.split('@')[0];

    Future<DocumentSnapshot> fetchUserData() async {
      DocumentReference userRef = FirebaseFirestore.instance
          .collection('users')
          .doc(ref.watch(userIdProvider));
      return await userRef.get();
    }

    return Scaffold(
        // appBar: AppBar(centerTitle: true, title: Text('アカウント'), actions: [
        //   Center(
        //     child: Padding(
        //         padding: const EdgeInsets.all(10.0),
        //         child: Row(children: [
        //           IconButton(
        //               icon: const Icon(Icons.account_circle), onPressed: () {}),
        //           Text(username)
        //         ])),
        //   )
        // ]),
        body: ListView(children: [
      Column(children: [
        Stack(children: [
          Positioned(
            child: Container(
              width: double.infinity,
              height: 350,
              color: Color.fromARGB(255, 255, 215, 135),
            ),
          ),
          Positioned(
            left: 50,
            top: 10,
            child: Container(
              width: 400,
              height: 400,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/Profiling_Isometric.png'),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Positioned(
              left: 0,
              top: 320,
              right: 0,
              child: Container(
                height: 50,
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TitleText(
                text: 'account',
                color: Colors.white,
                size: 46,
              ),
            ]),
          ),
        ]),
        Center(
            child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              'Email : $email',
            ),
            Column(
              children: [
                FutureBuilder<DocumentSnapshot>(
                    future: fetchUserData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        DocumentSnapshot data = snapshot.data!;
                        return Column(
                          children: [
                            Text(data['name']),
                            Text(data['department']),
                            Text(DateFormat('yyyy年M月d日')
                                .format((data['registrationDate']).toDate())),
                          ],
                        );
                      }
                    }),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                return context.go('/stock');
              },
              child: const Text('在庫一覧'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {},
              child: const Text('log out'),
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: 'ログアウト',
              onPressed: () {
                final service = AuthService();
                service.signOut();
              },
              width: 100,
              height: 50,
              mainColor: Colors.blue,
              shadowColor: Colors.blue,
            )
          ],
        )),
      ]),
    ]));
  }
}
