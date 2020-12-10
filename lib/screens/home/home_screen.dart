import 'package:flutter/material.dart';
import 'package:todo_app/helpers/database_helper.dart';
import 'package:todo_app/helpers/todo_helper.dart';
import 'package:todo_app/models/category.dart';

import 'package:todo_app/widgets/card/t_basic_card.dart';
import 'package:todo_app/widgets/card/t_todo_card.dart';
import 'package:todo_app/widgets/text/t_text_separator.dart';
import 'package:todo_app/widgets/text/t_title.dart';

import 'package:todo_app/models/todo.dart';
import 'package:todo_app/helpers/category_helper.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Category> categories = [];
  List<Todo> todos = [];

  test() async {
    DatabaseHelper helper = DatabaseHelper.getInstance();
    await helper.destroyDabase();
  }

  getCategories() async {
    CategoryHelper categoryHelper = CategoryHelper();
    // Category category = Category.fill('Personal', Colors.purple.value);
    // await categoryHelper.create(category);
    List<Category> categories = await categoryHelper.all();
    print('Categories ==> $categories');
    setState(() {
      this.categories = categories;
    });
  }

  getTodos() async {
    TodoHelper todoHelper = TodoHelper();
    // await todoHelper.create(Todo.fill('Go shopping', false, 1));
    // await todoHelper.create(Todo.fill('Wash the Car', true, 2));
    // await todoHelper.create(Todo.fill('Clean the house', true, 3));
    // await todoHelper.create(Todo.fill('Play with my pets', false, 2));
    // await todoHelper.create(Todo.fill('Plant a tree', false, 3));
    // await todoHelper.create(Todo.fill('Play videogames', true, 1));
    // await todoHelper.create(Todo.fill('Sing a son', true, 2));
    // await todoHelper.create(Todo.fill('Take a bath', true, 2));
    // await todoHelper.create(Todo.fill('Eat something', false, 1));
    // await todoHelper.create(Todo.fill('Buy a new cellphone charger', false, 3));
    // await todoHelper.create(Todo.fill('Turn off the lights', false, 3));
    // await todoHelper.create(Todo.fill('Workout', false, 3));
    // await todoHelper.create(Todo.fill('Go to sleep', false, 1));
    List<Todo> todos = await todoHelper.all();
    print('Todos ==> $todos');
    setState(() {
      this.todos = todos;
    });
  }

  @override
  void initState() {
    super.initState();
    // test();
    getCategories();
    getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEFFF),
      appBar: buildAppBar(),
      drawer: buildDrawer(),
      floatingActionButton: buildFloatingActionButton(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: TTitle(title: 'What\'s up, Matheus!'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TTextSeparator(title: 'CATEGORIES'),
          ),
          Container(
            height: 130,
            padding: EdgeInsets.symmetric(vertical: 20),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: this.categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: (index == categories.length - 1) ? 10 : 0,
                  ),
                  child: TBasicCard(
                    smallText: '40 taks',
                    title: categories[index].name,
                    color: Color(categories[index].color),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TTextSeparator(title: 'TASKS'),
          ),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: this.todos.length,
              itemBuilder: (context, index) => TTodoCard(
                todo: this.todos[index],
                onChange: (bool value) {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xffEFEFFF),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.grey[600]),
      actions: [
        IconButton(icon: Icon(Icons.search), onPressed: null),
        IconButton(icon: Icon(Icons.notifications_outlined), onPressed: null),
      ],
    );
  }

  Drawer buildDrawer() => Drawer();

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {},
    );
  }
}
