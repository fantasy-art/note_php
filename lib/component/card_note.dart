import 'package:flutter/material.dart';

class CardNote extends StatelessWidget {
  const CardNote({
    super.key,
    required this.title,
    required this.content,
    required this.editFun,
    required this.delFun,
  });

  final String title;
  final String content;
  final void Function()? editFun;
  final void Function()? delFun;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 2,
              child: Image.asset(
                'images/note_logo.png',
                height: 100,
                fit: BoxFit.cover,
              )),
          Expanded(
              flex: 3,
              child: ListTile(
                title: Text(title),
                subtitle: Text(
                  content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                IconButton(onPressed: editFun, icon: const Icon(Icons.edit)),
                IconButton(onPressed: delFun, icon: const Icon(Icons.clear)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
