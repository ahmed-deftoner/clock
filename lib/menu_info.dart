import 'package:clock/enums.dart';
import 'package:flutter/cupertino.dart';

class Menu_info extends ChangeNotifier{
  menu_type menu;
  String title;
  String image;

  Menu_info(
      this.menu,
  {this.title,this.image}
      );

  update_menu(Menu_info menu_info){
    this.menu=menu_info.menu;
    this.title=menu_info.title;
    this.image=menu_info.image;

    notifyListeners();
  }
}