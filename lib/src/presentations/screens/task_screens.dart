import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_task_manager/src/data/todo/todo_api.dart';

import '../../config/theme.dart';

class TaskScreens extends ConsumerStatefulWidget {
  const TaskScreens({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskScreensState();
}

class _TaskScreensState extends ConsumerState<TaskScreens> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  late TextEditingController _titleCtrl;
  @override
  void initState() {
    _titleCtrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          children: [
            Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ListTile(
                      title: const Text(
                        "Tugas Belum Selesai",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: TextButton(
                          onPressed: () {
                            _pageController.animateToPage(
                              1,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.bounceIn,
                            );
                          },
                          child: const Text("Belum Selesai")),
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("todo")
                            .snapshots(),
                        builder: (_, snapshot) {
                          if (snapshot.hasData) {
                            return Expanded(
                              child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (_, index) {
                                    final DocumentSnapshot todo =
                                        snapshot.data!.docs[index];
                                    if (!todo['status']) {
                                      return Dismissible(
                                        background: Container(
                                          color: Colors.red,
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Icon(Icons.clear_rounded),
                                              Icon(Icons.clear_rounded),
                                            ],
                                          ),
                                        ),
                                        key: Key(todo.id),
                                        onDismissed: (direction) {
                                          TodoApi().deleteProduct(todo);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                      'Tugas berhasil dihapus')));
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: ListTile(
                                            title: Text(todo['title']),
                                            trailing: IconButton(
                                              onPressed: () {
                                                TodoApi()
                                                    .editProduct(true, todo.id);
                                              },
                                              icon: const Icon(Icons.check),
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const Visibility(
                                          visible: false, child: SizedBox());
                                    }
                                  }),
                            );
                          } else {
                            return const Center(
                              child: Text("Tidak ada tugas"),
                            );
                          }
                        }),
                    Form(
                      key: _globalKey,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, -2),
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                  color: Colors.black.withOpacity(0.2))
                            ]),
                        alignment: Alignment.bottomCenter,
                        child: TextFormField(
                          controller: _titleCtrl,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(20),
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              onPressed: () {
                                if (_globalKey.currentState!.validate()) {
                                  TodoApi()
                                      .uploadingData(title: _titleCtrl.text);
                                  _titleCtrl.clear();
                                }
                                FocusScope.of(context).unfocus();
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Harap isi";
                            }
                            return null;
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  title: GestureDetector(
                      onTap: () {
                        _pageController.animateToPage(0,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.bounceIn);
                      },
                      child: const Text(
                        "Tugas Selesai",
                        style: TextStyle(fontSize: 14),
                      )),
                  trailing: const Text(
                    "Belum Selesai",
                    style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("todo")
                        .snapshots(),
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        return Expanded(
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (_, index) {
                                final DocumentSnapshot todo =
                                    snapshot.data!.docs[index];
                                if (todo['status']) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        todo['title'],
                                        style: const TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {
                                          TodoApi().editProduct(false, todo.id);
                                        },
                                        icon: const Icon(Icons.close),
                                      ),
                                    ),
                                  );
                                } else {
                                  return const Visibility(
                                      visible: false, child: SizedBox());
                                }
                              }),
                        );
                      } else {
                        return const Center(
                          child: Text("Tidak ada tugas"),
                        );
                      }
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
