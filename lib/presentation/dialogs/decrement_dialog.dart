import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../application/state/state.dart';
import '../../infrastructure/firebase/firebase_service.dart';

class DecrementDialog extends HookConsumerWidget {
  final String docName;
  final String username;
  const DecrementDialog(this.docName, this.username, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final valueController = useTextEditingController();
    FirebaseService fireServise = FirebaseService();

    return AbsorbPointer(
      absorbing: ref.watch(absorbPointerStateProvider),
      child: AlertDialog(
        backgroundColor: Color.fromARGB(255, 243, 156, 94),
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
                      fillColor: Color.fromARGB(255, 255, 234, 220),
                      helperStyle: TextStyle(color: Colors.white),
                      hintText: "数量",
                      hintStyle: TextStyle(color: Colors.orange)),
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
                      style: TextStyle(color: Colors.orange),
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
                      backgroundColor: const Color.fromARGB(255, 230, 92, 6),
                    ),
                    child: const Text('出庫',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    onPressed: () async {
                      if (valueController.text.isEmpty) {
                        if (context.mounted) {
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
                        }
                      } else {
                        final decrementValue = int.parse(valueController.text);
                        Map<String, dynamic>? data =
                            await fireServise.fetchProductData(docName);
                        final int currentValue = data!['productVolume'];
                        debugPrint(currentValue.toString());
                        if (currentValue <= decrementValue) {
                          if (context.mounted) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor:
                                        Color.fromARGB(255, 255, 200, 200),
                                    title: const Text('在庫不足です',
                                        style: TextStyle(fontSize: 20)),
                                    content: Text('在庫数は $currentValue です'),
                                    actions: [
                                      TextButton(
                                        child: const Text("OK",
                                            style: TextStyle(fontSize: 20.0)),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ],
                                  );
                                });
                          }
                        } else {
                          ref
                              .read(absorbPointerStateProvider.notifier)
                              .set(true);
                          ref.read(loadingStateProvider.notifier).show();

                          FirebaseService firebaseService = FirebaseService();

                          firebaseService.decrementVolume(
                              docName, username, decrementValue);

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
