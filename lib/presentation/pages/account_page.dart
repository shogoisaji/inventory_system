import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test_various/infrastructure/firebase/firebase_service.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../application/state/state.dart';
import '../../infrastructure/firebase/auth_service.dart';
import '../wedget/account_ditail_view.dart';
import '../wedget/custom_bottunGradation.dart';
import '../wedget/text_style.dart';
import '../wedget/custom_bottun.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    String email = user!.email!;

    Future<DocumentSnapshot> fetchUserData() async {
      DocumentReference userRef = FirebaseFirestore.instance
          .collection('users')
          .doc(ref.watch(userIdProvider));
      return await userRef.get();
    }

    // Future<String> fetchUserDataValues() async {
    //   DocumentSnapshot snapshot = await fetchUserData();
    //   return snapshot['name'];
    // }

    return Scaffold(
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
        Container(
          width: 300,
          alignment: Alignment.bottomLeft,
          child: 
            const Text('Email',style:TextStyle(color: Colors.blueGrey,)),
        ),
        Center(
            child: Column(
          children: [
            // const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0),
                color: Colors.blueGrey.withOpacity(0.3),
              ),
              width: 300,
              height: 40,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left:10.0),
              child:
                Text(email)
            ),
            const SizedBox(height: 10),
            // AccountDitailView(
            //   typeText: 'name',
            // textWidget: fetchUserDataValues(),
            
            
            // ),
            Text(ref.watch(userNameProvider)),
            const SizedBox(height: 10),
            Container(
              width: 300,
              alignment: Alignment.bottomLeft,
              child: 
                const Text('部署',style:TextStyle(color: Colors.blueGrey,)),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0),
                color: Colors.blueGrey.withOpacity(0.3),
              ),
              width: 300,
              height: 40,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left:10.0),
              child:
                Text(email)
            ),
            const SizedBox(height: 10),
            Container(
              width: 300,
              alignment: Alignment.bottomLeft,
              child: 
                const Text('登録日',style:TextStyle(color: Colors.blueGrey,)),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0),
                color: Colors.blueGrey.withOpacity(0.3),
              ),
              width: 300,
              height: 40,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left:10.0),
              child:
                Text(email)
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
            const SizedBox(height: 20,),
            CustomButtonGradation(
              text: '在庫一覧',
              mainColor1: Color.fromARGB(255, 94, 208, 161),
              mainColor2: Color.fromARGB(255, 6, 100, 85),
              borderColor1: Color.fromARGB(255, 222, 255, 195),
              borderColor2: Color.fromARGB(255, 0, 100, 57),
              onPressed: () {
                context.go('/stock');
              },
              width: 100,
              height: 35,
              textSize: 16,
              textColor: Colors.white
            ),
            const SizedBox(height: 20,),
            CustomButtonGradation(
              text: 'ログアウト',
              mainColor1: Color.fromARGB(255, 94, 132, 208),
              mainColor2: Color.fromARGB(255, 57, 23, 144),
              borderColor1: Color.fromARGB(255, 138, 164, 206),
              borderColor2: Color.fromARGB(255, 0, 0, 0),
              onPressed: () {
                final service = AuthService();
                service.signOut();
              },
              width: 100,
              height: 35,
              textSize: 16,
              textColor: Colors.white
            ),
              // onPressed: () {
              //   return context.go('/stock');
              // },
              // child: const Text('在庫一覧'),
            
            const SizedBox(height: 30),
          ],
        )),
      ]),
    ]));
  }
}
