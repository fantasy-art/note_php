import 'package:note_php/constant/message.dart';

validInput(String val, int min, int max) {
  if (val.length > max) {
    return "$messageInputMax $max";
  }
  if (val.trim().isEmpty) {
    return messageInputEmpty;
  }
  if (val.length < min) {
    return "$messageInputMin $min";
  }
}
