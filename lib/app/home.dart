import 'package:flutter/material.dart';
import 'package:note_php/app/notes/edit.dart';
import 'package:note_php/component/card_note.dart';
import 'package:note_php/main.dart';
import '../constant/url_api.dart';
import '../component/crud.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Crud crud = Crud();
  getNotes() async {
    var response =
        await crud.postRequest(urlReadNote, {"id": sharedPref.getString('id')});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    sharedPref.clear();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('Login', (route) => false);
                  },
                  icon: const Icon(Icons.logout)))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            FutureBuilder(
              future: getNotes(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data['status'] == 'fail') {
                    return const Center(child: Text('No data'));
                  }
                  return ListView.builder(
                      itemCount: snapshot.data['data'].length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CardNote(
                            editFun: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditNote(
                                  notes: snapshot.data['data'][index],
                                ),
                              ));
                            },
                            delFun: () async {
                              await crud.postRequest(urlDeleteNote, {
                                'note_id': snapshot.data['data'][index]
                                        ['note_id']
                                    .toString()
                              });
                              setState(() {});
                            },
                            title: snapshot.data['data'][index]['note_title'],
                            content: snapshot.data['data'][index]
                                ['note_content']);
                      });
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: Text('Waiting'));
                }
                return const Center(child: Text('Waiting'));
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('AddNote');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
