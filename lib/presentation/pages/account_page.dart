import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../application/state/state.dart';
import '../../infrastructure/firebase/auth_service.dart';
import '../wedget/account_ditail_view.dart';
import '../wedget/custom_bottunGradation.dart';
import '../wedget/text_style.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    String email = user!.email!;
    final _screenSize = MediaQuery.of(context).size;

    Future<DocumentSnapshot> fetchUserData() async {
      DocumentReference userRef = FirebaseFirestore.instance
          .collection('users')
          .doc(ref.watch(userIdProvider));
      return await userRef.get();
    }

    return Scaffold(
        body: SizedBox(
      height: _screenSize.height,
      child: SingleChildScrollView(
          child: Container(
        constraints: BoxConstraints(
          minHeight: _screenSize.height,
        ),
        height: 900,
        child: Stack(children: [
          Container(
            width: double.infinity,
            // height: 350,
            color: Color.fromARGB(255, 255, 215, 135),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 500,
              child: Stack(
                children: [
                  Positioned(
                    left: 50,
                    top: 60,
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
                    left: 15,
                    top: 60,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleText(
                            text: 'account',
                            color: Colors.white,
                            size: 46,
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ),
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
              width: double.infinity,
              height: 510,
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
              child: FutureBuilder<DocumentSnapshot>(
                  future: fetchUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      DocumentSnapshot data = snapshot.data!;
                      return Column(children: [
                        const SizedBox(
                          height: 25.0,
                        ),
                        AccountDetailView(
                          typeText: 'Name',
                          textContent: data['name'],
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        AccountDetailView(
                          typeText: 'Email',
                          textContent: email,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        AccountDetailView(
                          typeText: '部署',
                          textContent: data['department'],
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        AccountDetailView(
                          typeText: '登録日',
                          textContent: DateFormat('yyyy年M月d日')
                              .format((data['registrationDate']).toDate()),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
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
                            textColor: Colors.white),
                        const SizedBox(
                          height: 20,
                        ),
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
                            textColor: Colors.white),
                      ]);
                    }
                  }),
            )
          ]),
        ]),
      )),
    ));
  }
}
