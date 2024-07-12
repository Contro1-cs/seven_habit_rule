import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final navbarProvider =
    ChangeNotifierProvider<NavBarModel>((ref) => NavBarModel());

class NavBarModel extends ChangeNotifier {
  int _page = 0;
  NavBarModel();
  int get page => _page;

  void changePage(int newPage) {
    _page = newPage;
    notifyListeners();
  }
}
