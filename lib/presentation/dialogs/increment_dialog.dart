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

    return AbsorbPointer(
      absorbing: ref.watch(absorbPointerStateProvider),
      child: AlertDialog(
        backgroundColor: Colors.lightBlue,
        title: const Text("数量を入力してください"),
        content: SizedBox(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                      Navigator.pop(context);
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
                                backgroundColor:
                                    Color.fromARGB(255, 255, 200, 200),
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
                        ref.read(absorbPointerStateProvider.notifier).set(true);
                        ref.read(loadingStateProvider.notifier).show();

                        FirebaseService firebaseService = FirebaseService();
                        final incrementValue = int.parse(valueController.text);
                        firebaseService.incrementVolume(
                            docName, username, incrementValue);

                        await Future.delayed(const Duration(seconds: 2));
                        ref.read(loadingStateProvider.notifier).hide();
                        if (context.mounted) {
                          Navigator.pop(context);
                          context.go("/stock");
                          ref
                              .read(absorbPointerStateProvider.notifier)
                              .set(false);
                        }
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
