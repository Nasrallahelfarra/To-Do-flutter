import 'package:flutter/material.dart';
import 'package:reactive_todo_app/features/todo/presentation/cubit/todo_cubit.dart';
import 'package:reactive_todo_app/features/todo/presentation/cubit/todo_state.dart';
import 'package:reactive_todo_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/key_ui.dart';
import '../../data/model/todo.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Allows Todo card to be dismissable horizontally
  final DismissDirection _dismissDirection = DismissDirection.horizontal;





  @override
  Widget build(BuildContext context) {

    return BlocProvider<TodoCubit>(
      create: (_) => sl<TodoCubit>()..getTodos(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
                child: Container(
                    //This is where the magic starts
                    child: getTodosWidget()))),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(color: Colors.grey, width: 0.3),
            )),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Builder(builder: (context) {

                  return IconButton(
                    icon: Icon(
                      Icons.menu,
                      key: const ValueKey(keyMenuIcon),

                      color: Colors.indigoAccent,
                      size: 28,
                    ),
                    onPressed: () {
                      final TodoCubit cubit = context.read<TodoCubit>();
                      cubit.getTodos();
                    },
                  );
                }),
                Expanded(
                  child: Text(
                    'Todo',
                    key: const ValueKey(keyNameAppText),

                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'RobotoMono',
                        fontStyle: FontStyle.normal,
                        fontSize: 19),
                  ),
                ),
                Wrap(children: <Widget>[
                  Builder(builder: (context) {
                    return IconButton(
                      icon: Icon(
                        Icons.search,
                        key: const ValueKey(keySearchIcon),

                        size: 28,
                        color: Colors.indigoAccent,
                      ),
                      onPressed: () {
                        final TodoCubit cubit = context.read<TodoCubit>();
                        _showTodoSearchSheet(context, cubit);
                      },
                    );
                  }),
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                  )
                ])
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 25),
          child: Builder(builder: (context) {
            return FloatingActionButton(
              key: const ValueKey(keyAddToDo),
              elevation: 5.0,
              onPressed: () {
                final TodoCubit cubit = context.read<TodoCubit>();
                _showAddTodoSheet(context, cubit);
              },
              backgroundColor: Colors.white,
              child: Icon(
                Icons.add,
                size: 32,
                color: Colors.indigoAccent,
              ),
            );
          }),
        ),
      ),
    );
  }

  void _showAddTodoSheet(BuildContext context, TodoCubit cubit) {
    final _todoDescriptionFormController = TextEditingController();
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              color: Colors.transparent,
              child: Container(
                height: 230,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 15, top: 25.0, right: 15, bottom: 30),
                  child: ListView(
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: _todoDescriptionFormController,
                              textInputAction: TextInputAction.newline,
                              maxLines: 4,
                              key: const ValueKey(keyAddToDoTextFiled),
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.w400),
                              autofocus: true,
                              decoration: const InputDecoration(
                                  hintText: 'I have to...',
                                  labelText: ' Todo',
                                  labelStyle: TextStyle(
                                      color: Colors.indigoAccent,
                                      fontWeight: FontWeight.w500)),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Empty description!';
                                }
                                return value.contains('')
                                    ? 'Do not use the @ char.'
                                    : null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5, top: 15),
                            child: CircleAvatar(
                              backgroundColor: Colors.indigoAccent,
                              radius: 18,
                              child: IconButton(
                                key: const ValueKey(keySaveIcon),
                                icon: Icon(
                                  Icons.save,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  final todo = Todo(
                                    _todoDescriptionFormController.value.text,
                                  );
                                  if (todo.description.isNotEmpty) {
                                    final TodoCubit cubit =
                                        context.read<TodoCubit>();
                                    cubit.addTodo(todo);
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }

  void _showTodoSearchSheet(BuildContext context, TodoCubit cubit) {
    final _todoSearchDescriptionFormController = TextEditingController();
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              color: Colors.transparent,
              child: Container(
                height: 230,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 15, top: 25.0, right: 15, bottom: 30),
                  child: ListView(
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: _todoSearchDescriptionFormController,
                              textInputAction: TextInputAction.newline,
                              maxLines: 4,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                              autofocus: true,
                              decoration: const InputDecoration(
                                hintText: 'Search for todo...',
                                labelText: 'Search *',
                                labelStyle: TextStyle(
                                    color: Colors.indigoAccent,
                                    fontWeight: FontWeight.w500),
                              ),
                              validator: (value) {
                                return value!.contains('@')
                                    ? 'Do not use the @ char.'
                                    : null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5, top: 15),
                            child: CircleAvatar(
                              backgroundColor: Colors.indigoAccent,
                              radius: 18,
                              child: IconButton(
                                icon: Icon(
                                  Icons.search,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  final TodoCubit cubit =
                                      context.read<TodoCubit>();
                                  cubit.search(
                                    _todoSearchDescriptionFormController
                                        .value.text,
                                  );
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget getTodosWidget() {
    return BlocBuilder<TodoCubit, TodoState>(
      builder: (BuildContext context, TodoState state) {
        return getTodoCardWidget(state);
      },
    );
  }

  Widget getTodoCardWidget(TodoState state) {
    if (state is TodoLoadedState) {
      return ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, itemPosition) {
                Todo? todo = state.items[itemPosition];
                final Widget dismissibleCard = Dismissible(
                  background: Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Deleting',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    color: Colors.redAccent,
                  ),
                  onDismissed: (direction) {
                    final TodoCubit cubit = context.read<TodoCubit>();
                    cubit.deleteTodo(todo.id);
                  },
                  direction: _dismissDirection,
                  key: ObjectKey(todo),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey[200]!, width: 0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: Colors.white,
                      child: ListTile(
                        trailing: InkWell(
                            key:  ValueKey('$keyRemoveIcon$itemPosition'),

                            onTap: () {
                              final TodoCubit cubit = context.read<TodoCubit>();
                              cubit.deleteTodo(todo.id);
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                        leading: InkWell(
                          onTap: () {
                            todo.isDone = !todo.isDone;
                            final TodoCubit cubit = context.read<TodoCubit>();
                            cubit.updateTodo(todo);
                          },
                          child: Container(
                            //decoration: BoxDecoration(),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: todo.isDone
                                  ? Icon(
                                      Icons.done,
                                key:  ValueKey('$keyToDoSelectCheckBox$itemPosition'),
                                size: 26.0,
                                      color: Colors.indigoAccent,
                                    )
                                  : Icon(
                                      Icons.check_box_outline_blank,
                                      size: 26.0,
                                key:  ValueKey('$keyToDoUnSelectCheckBox$itemPosition'),
                                color: Colors.tealAccent,
                                    ),
                            ),
                          ),
                        ),
                        title: Text(
                          todo.description,
                          key:  ValueKey('$keyTitleToDoText$itemPosition'),
                          style: TextStyle(
                              fontSize: 16.5,
                              fontFamily: 'RobotoMono',
                              fontWeight: FontWeight.w500,
                              decoration: todo.isDone
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none),
                        ),
                      )),
                );
                return dismissibleCard;
              },
            );

    } else if (state is TodoEmptyState) {
      return Container(
        child: Center(
          child: noTodoMessageWidget(),
        ),
      );
    } else {
      return Center(
        child: loadingData(),
      );
    }
  }

  Widget loadingData() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Text("Loading...",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget noTodoMessageWidget() {
    return Container(
      child: Text(
        "Start adding Todo...",
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
      ),
    );
  }
}
