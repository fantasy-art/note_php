import 'package:flutter/material.dart';
import 'package:note_php/component/crud.dart';
import 'package:note_php/component/custom_button.dart';
import 'package:note_php/component/custom_text_form_field.dart';
import 'package:note_php/component/valid.dart';
import 'package:note_php/constant/url_api.dart';
import 'package:note_php/main.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  bool isLoading = false;

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  Crud crud = Crud();
  addNotes() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await crud.postRequest(urlAddNote, {
        'title': title.text,
        'content': content.text,
        'id': sharedPref.getString('id'),
      });
      isLoading = false;
      setState(() {});
      if (response['status'] == 'success') {
        if (context.mounted) {
          Navigator.of(context).pushReplacementNamed('Home');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color.fromARGB(255, 20, 53, 100),
      appBar: AppBar(
        //backgroundColor: const Color.fromARGB(255, 145, 201, 195),
        foregroundColor: Colors.black,
        title: const Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: formstate,
                child: ListView(
                  children: [
                    CustomTextForm(
                      hintText: 'Title',
                      textController: title,
                      valid: (val) => validInput(val!, 5, 40),
                    ),
                    CustomTextForm(
                      hintText: 'Content',
                      textController: content,
                      valid: (val) => validInput(val!, 5, 255),
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                        text: 'Save', onPressed: () async => await addNotes())
                  ],
                ),
              ),
      ),
    );
  }
}
