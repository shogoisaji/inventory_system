import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../application/state/state.dart';
import '../../infrastructure/firebase/firebase_service.dart';

class IncrementDialog extends HookConsumerWidget {
  final String docName;
  final String username;
  const IncrementDialog(this.docName, this.username, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final valueController = useTextEditingController();

    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20.0),
      ),
      width: 300,
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('数量を入力してくださ', style: TextStyle(fontSize: 24)),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: 100,
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: valueController,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 220, 230, 255),
                  helperStyle: TextStyle(color: Colors.white),
                  hintText: "数量",
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 70, 172, 255))),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                child: const Text(
                  'キャンセル',
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  ref.read(incrementDialogProvider.notifier).hide();
                },
              ),
              const SizedBox(
                width: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 96, 175),
                ),
                child: const Text('入庫',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                onPressed: () async {
                  if (valueController.text.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Color.fromARGB(255, 255, 200, 200),
                            title: const Text('数量を入力してください',
                                style: TextStyle(fontSize: 20)),
                            actions: [
                              TextButton(
                                child: const Text("OK",
                                    style: TextStyle(fontSize: 20.0)),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          );
                        });
                  } else {
                    ref.read(loadingStateProvider.notifier).show();

                    FirebaseService firebaseService = FirebaseService();
                    final incrementValue = int.parse(valueController.text);
                    firebaseService.incrementVolume(
                        docName, username, incrementValue);

                    Future.delayed(const Duration(seconds: 2), () {
                      context.go('/stock');
                      ref.read(incrementDialogProvider.notifier).hide();
                      ref.read(loadingStateProvider.notifier).hide();
                    });
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
