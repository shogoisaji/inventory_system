import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../router/router.dart';

class MyBottomNavigationBar extends ConsumerWidget {
  onTabTapped(BuildContext context) {
    context.push('sign-in');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped(context),
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.file_download),
            label: '入庫',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_upload),
            label: '出庫',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.text_snippet),
            label: '在庫',
          ),
        ],
      ),
    );
  }
}
