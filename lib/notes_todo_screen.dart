import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowy_borders/glowy_borders.dart';
import 'package:notes_app/sqlhelper.dart';

class NotesTodoScreen extends StatefulWidget {
  const NotesTodoScreen({super.key});

  @override
  State<NotesTodoScreen> createState() => _NotesTodoScreenState();
}

class _NotesTodoScreenState extends State<NotesTodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes & Todo"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete_forever),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: SqlHelper().readData(),
                builder: (context, AsyncSnapshot<List<Map>> snapshot) {
                  // connectionState
                  // List<Map>
                  // .length

                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        // Padding //
                        return AnimatedGradientBorder(
                          animationTime: 5,
                          gradientColors: [
                            Colors.amber,
                            Colors.amber,
                            Colors.transparent,
                            Colors.transparent,
                            Colors.red,
                            Colors.red,
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          child: Dismissible(
                            key: UniqueKey(),
                            child: Card(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        margin: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          "${snapshot.data![index]['title']}",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      // ListView - SingleChildScrollView //
                                      SizedBox(
                                        height: 80,
                                        width: 150,
                                        child: SingleChildScrollView(
                                          child: Text(
                                            "${snapshot.data![index]['content']}",
                                            style: TextStyle(fontSize: 16),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.edit),
                                  ),
                                  Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                      fontSize: 50,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Dialog //
          // AlertDialog //
          // CupertinoAlertDialog //
          showCupertinoDialog(
              context: context,
              barrierDismissible: true,
              builder: (_) {
                TextEditingController title = TextEditingController();
                TextEditingController content = TextEditingController();
                return CupertinoAlertDialog(
                  title: Text("Add New Note"),
                  // TextFormField //
                  content: Material(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: title,
                        ),
                        TextFormField(
                          controller: content,
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("No"),
                    ),
                    CupertinoDialogAction(
                      onPressed: () {
                        SqlHelper()
                            .insertNote(
                          Note(
                            title.text,
                            content.text,
                          ),
                        )
                            .whenComplete(() {
                          setState(() {});
                          Navigator.pop(context);
                        });
                      },
                      child: Text("Yes"),
                    ),
                  ],
                );
              });
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
      ),
    );
  }
}

// FutureBuilder - one time - Future
// StreamBuilder - real time - Stream
