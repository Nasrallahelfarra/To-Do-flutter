import 'package:flutter_driver/flutter_driver.dart';
import 'package:reactive_todo_app/core/key_ui.dart';

class HomePom{
  static int itemNumber=0;
  static SerializableFinder getAddButton(){
    return find.byValueKey(keyAddToDo);
  }
  static SerializableFinder getSearchIcon(){
    return find.byValueKey(keySearchIcon);
  }
  static SerializableFinder getMenuIcon(){
    return find.byValueKey(keyMenuIcon);
  }
  static SerializableFinder getAddToDoTextFiled(){
    return find.byValueKey(keyAddToDoTextFiled);
  }
  static SerializableFinder getSaveIcon(){
    return find.byValueKey(keySaveIcon);
  }
  static SerializableFinder getTitleTodoText(){
    return find.byValueKey('$keyTitleToDoText$itemNumber');
  }
  static SerializableFinder getToDoUnSelectCheckbox(){
    return find.byValueKey('$keyToDoUnSelectCheckBox$itemNumber');
  }
  static SerializableFinder getToDoSelectCheckbox(){
    return find.byValueKey('$keyToDoSelectCheckBox$itemNumber');
  }
  static SerializableFinder getRemoveIcon(){
    return find.byValueKey('$keyRemoveIcon$itemNumber');
  }
  static SerializableFinder getNameAppText(){
    return find.byValueKey(keyNameAppText);
  }

}