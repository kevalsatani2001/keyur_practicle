import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_demo/contact_list_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'bloc/contact_bloc.dart';
import 'bloc/contact_event.dart';
import 'contact_model.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ContactModelAdapter());
  final box = await Hive.openBox<ContactModel>('contactsBox');

  runApp(
    BlocProvider(
      create: (context) => ContactBloc(box)..add(LoadContacts()),
      child:  MaterialApp(home: ContactListScreen()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}


/*
dependencies:
  flutter:
    sdk: flutter

  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.8
  flutter_bloc: ^8.1.3
  hive:
  hive_flutter:

dev_dependencies:
  flutter_test:
    sdk: flutter
  hive_generator:
  build_runner:
 */

/*
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: CrudApp()));

class CrudApp extends StatefulWidget {
  @override
  _CrudAppState createState() => _CrudAppState();
}

class _CrudAppState extends State<CrudApp> {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter CRUD API")),
      body: FutureBuilder(
        future: apiService.getPosts(),
        builder: (context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: 10, // Testing mate fakt 10 items
              itemBuilder: (context, index) {
                Post post = snapshot.data![index];
                return ListTile(
                  title: Text(post.title),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _showForm(post: post),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => apiService.deletePost(post.id!),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showForm(),
      ),
    );
  }

  // Form Dialog for Create & Update
  void _showForm({Post? post}) {
    TextEditingController titleController = TextEditingController(text: post?.title ?? "");
    TextEditingController bodyController = TextEditingController(text: post?.body ?? "");

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(post == null ? "Add Post" : "Update Post"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: InputDecoration(labelText: "Title")),
            TextField(controller: bodyController, decoration: InputDecoration(labelText: "Body")),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Post newPost = Post(title: titleController.text, body: bodyController.text);
              if (post == null) {
                await apiService.createPost(newPost);
              } else {
                await apiService.updatePost(post.id!, newPost);
              }
              Navigator.pop(context);
              setState(() {}); // Refresh UI
            },
            child: Text("Save"),
          )
        ],
      ),
    );
  }
}

class ApiService {
  final String url = "https://jsonplaceholder.typicode.com/posts";

  // READ
  Future<List<Post>> getPosts() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((item) => Post.fromJson(item)).toList();
    } else {
      throw "Post fetch nathi thai rahya.";
    }
  }

  // CREATE
  Future<void> createPost(Post post) async {
    await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(post.toJson()),
    );
  }

  // UPDATE
  Future<void> updatePost(int id, Post post) async {
    await http.put(
      Uri.parse('$url/$id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(post.toJson()),
    );
  }

  // DELETE
  Future<void> deletePost(int id) async {
    await http.delete(Uri.parse('$url/$id'));
  }
}

class Post {
  final int? id;
  final String title;
  final String body;

  Post({this.id, required this.title, required this.body});

  // JSON mathi Object banavva mate
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  // Object mathi JSON banavva mate
  Map<String, dynamic> toJson() {
    return {'title': title, 'body': body};
  }
}
 */

/*
detail================

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: CrudApp()));

class CrudApp extends StatefulWidget {
  @override
  _CrudAppState createState() => _CrudAppState();
}

class _CrudAppState extends State<CrudApp> {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter CRUD API")),
      body: FutureBuilder(
        future: apiService.getPosts(),
        builder: (context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: 10, // Testing mate fakt 10 items
              // ... ListView.builder ni andar badlav ...

              itemBuilder: (context, index) {
                Post post = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(post.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                    subtitle: Text("Click to view details"),
                    leading: CircleAvatar(child: Text("${post.id}")),

                    // ITEM CLICK LOGIC
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(post: post),
                        ),
                      );
                    },

                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => apiService.deletePost(post.id!),
                    ),
                  ),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showForm(),
      ),
    );
  }

  // Form Dialog for Create & Update
  void _showForm({Post? post}) {
    TextEditingController titleController = TextEditingController(text: post?.title ?? "");
    TextEditingController bodyController = TextEditingController(text: post?.body ?? "");

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(post == null ? "Add Post" : "Update Post"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: InputDecoration(labelText: "Title")),
            TextField(controller: bodyController, decoration: InputDecoration(labelText: "Body")),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Post newPost = Post(title: titleController.text, body: bodyController.text);
              if (post == null) {
                await apiService.createPost(newPost);
              } else {
                await apiService.updatePost(post.id!, newPost);
              }
              Navigator.pop(context);
              setState(() {}); // Refresh UI
            },
            child: Text("Save"),
          )
        ],
      ),
    );
  }
}

class ApiService {
  final String url = "https://jsonplaceholder.typicode.com/posts";

  // READ
  Future<List<Post>> getPosts() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((item) => Post.fromJson(item)).toList();
    } else {
      throw "Post fetch nathi thai rahya.";
    }
  }

  // CREATE
  Future<void> createPost(Post post) async {
    await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(post.toJson()),
    );
  }

  // UPDATE
  Future<void> updatePost(int id, Post post) async {
    await http.put(
      Uri.parse('$url/$id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(post.toJson()),
    );
  }

  // DELETE
  Future<void> deletePost(int id) async {
    await http.delete(Uri.parse('$url/$id'));
  }
}

class Post {
  final int? id;
  final String title;
  final String body;

  Post({this.id, required this.title, required this.body});

  // JSON mathi Object banavva mate
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  // Object mathi JSON banavva mate
  Map<String, dynamic> toJson() {
    return {'title': title, 'body': body};
  }
}


class DetailScreen extends StatelessWidget {
  final Post post; // Item data recieve karva mate

  DetailScreen({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Post Detail")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Title:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue),
            ),
            Text(post.title, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text(
              "Description:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue),
            ),
            Text(post.body, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text("Post ID: ${post.id}", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
 */

/////////////////////////// FIREBASE CRUD ////////////////////////
/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase initialize karvu jaruri che
  runApp(MaterialApp(home: FirebaseCrudApp()));
}

class FirebaseCrudApp extends StatefulWidget {
  @override
  _FirebaseCrudAppState createState() => _FirebaseCrudAppState();
}

class _FirebaseCrudAppState extends State<FirebaseCrudApp> {
  // Firestore collection reference
  final CollectionReference _users = FirebaseFirestore.instance.collection('users');

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();

  // CREATE or UPDATE logic
  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _nameController.text = documentSnapshot['name'];
      _jobController.text = documentSnapshot['job'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20, left: 20, right: 20, bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Name')),
                TextField(controller: _jobController, decoration: InputDecoration(labelText: 'Job')),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final String job = _jobController.text;
                    if (name.isNotEmpty && job.isNotEmpty) {
                      if (action == 'create') {
                        // 1. CREATE: Navu document add karva
                        await _users.add({"name": name, "job": job});
                      }
                      if (action == 'update') {
                        // 2. UPDATE: Existing document update karva
                        await _users.doc(documentSnapshot!.id).update({"name": name, "job": job});
                      }
                      _nameController.text = '';
                      _jobController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  // 3. DELETE: Document remove karva
  Future<void> _deleteUser(String userId) async {
    await _users.doc(userId).delete();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User deleted successfully!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firebase CRUD')),
      // 4. READ: Real-time data mate StreamBuilder
      body: StreamBuilder(
        stream: _users.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['name']),
                    subtitle: Text(documentSnapshot['job']),
                    onTap: () {
                      // DETAIL: Click karta detail page par java mate (pela mapela concept mujab)
                      _showDetail(documentSnapshot);
                    },
                    trailing: SizedBox(
                      width: 100,
                      children: [
                        IconButton(icon: Icon(Icons.edit), onPressed: () => _createOrUpdate(documentSnapshot)),
                        IconButton(icon: Icon(Icons.delete), onPressed: () => _deleteUser(documentSnapshot.id)),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createOrUpdate(),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showDetail(DocumentSnapshot doc) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Scaffold(
      appBar: AppBar(title: Text("User Detail")),
      body: Center(child: Text("Name: ${doc['name']}\nJob: ${doc['job']}", style: TextStyle(fontSize: 20))),
    )));
  }
}
 */