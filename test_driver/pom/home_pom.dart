import 'package:flutter_driver/flutter_driver.dart';
import 'package:reactive_todo_app/core/key_ui.dart';
class HomePom{
  static int number=0;
  static SerializableFinder getMenuIcon(){
    return find.byValueKey(keyMenuIcon);
  }
  static SerializableFinder getErorrMenuIcon(){
    return find.byValueKey("keyMenuIconsq");
  }
  static SerializableFinder getSearchIcon(){
    return find.byValueKey(keySearchIcon);
  }
  static SerializableFinder getAddButton(){
    return find.byValueKey(keyAddToDo);
  }
  static SerializableFinder getNameTodoText(){
    return find.byValueKey(keyNameAppText);
  }
  static SerializableFinder getTodoTextFiled(){
    return find.byValueKey(keyAddToDoTextFiled);
  }
  static SerializableFinder getSaveIcon(){
    return find.byValueKey(keySaveIcon);
  }
  static SerializableFinder getSelectCheckBox(){
    return find.byValueKey("$keyToDoSelectCheckBox$number");
  }
  static SerializableFinder getUnSelectCheckBox(){
    return find.byValueKey('$keyToDoUnSelectCheckBox$number');
  }
  static SerializableFinder getTitleTodoText(){
    return find.byValueKey('$keyTitleToDoText$number');
  }
  static SerializableFinder getRemoveIcon(){
    return find.byValueKey('$keyRemoveIcon$number');
  }
}