import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_todo_app/core/key_ui.dart';
class HomePom{
  static int number=0;
  static Finder  getMenuIcon()  {
    return find.byKey(const ValueKey(keyMenuIcon));
  }
  static Finder getErorrMenuIcon(){
    return find.byKey(const ValueKey("keyMenuIconsq"));
  }
  static Finder getSearchIcon(){
    return find.byKey(( ValueKey(keySearchIcon)));
  }
  static Finder getAddButton(){
    return find.byKey(ValueKey(keyAddToDo));
  }
  static Finder getNameTodoText(){
    return find.byKey(ValueKey(keyNameAppText));
  }
  static Finder getTodoTextFiled(){
    return find.byKey(ValueKey(keyAddToDoTextFiled));
  }
  static Finder getSaveIcon(){
    return find.byKey(ValueKey(keySaveIcon));
  }
  static Finder getSelectCheckBox(){
    return find.byKey(ValueKey("$keyToDoSelectCheckBox$number"));
  }
  static Finder getUnSelectCheckBox(){
    return find.byKey(ValueKey('$keyToDoUnSelectCheckBox$number'));
  }
  static Finder getTitleTodoText(){
    return find.byKey(ValueKey('$keyTitleToDoText$number'));
  }
  static Finder getRemoveIcon(){
    return find.byKey(ValueKey('$keyRemoveIcon$number'));
  }
}