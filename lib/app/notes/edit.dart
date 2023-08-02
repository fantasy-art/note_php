import 'package:flutter/material.dart';
import 'package:note_php/component/crud.dart';
import 'package:note_php/component/custom_button.dart';
import 'package:note_php/component/custom_text_form_field.dart';
import 'package:note_php/component/valid.dart';
import 'package:note_php/constant/url_api.dart';

class EditNote extends StatefulWidget {
  const EditNote({super.key, required this.notes});
  final dynamic notes;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  bool isLoading = false;

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  Crud crud = Crud();
  editNotes() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await crud.postRequest(urlEditdNote, {
        'note_title': title.text,
        'note_content': content.text,
        'note_id': widget.notes['note_id'].toString(),
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
  void initState() {
    title.text = widget.notes['note_title'];
    content.text = widget.notes['note_content'];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                      valid: (val) => validInput(val!, 4, 40),
                    ),
                    CustomTextForm(
                      hintText: 'Content',
                      textController: content,
                      valid: (val) => validInput(val!, 5, 255),
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                        text: 'Save', onPressed: () async => await editNotes())
                  ],
                ),
              ),
      ),
    );
  }
}
