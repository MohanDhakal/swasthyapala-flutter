
import 'package:flutter/foundation.dart';

class Replies {
  int _repId;
  String _replyMessage;
  int _mentionedUserId;
  String _mentionedUserName;

  int get repId => _repId;

  set repId(int value) {
    _repId = value;
  }


  Replies({repId,replyMessage, mentionedUserId,mentionedUserName});

  String get replyMessage => _replyMessage;

  set replyMessage(String value) {
    _replyMessage = value;
  }

  int get mentionedUserId => _mentionedUserId;

  set mentionedUserId(int value) {
    _mentionedUserId = value;
  }

  String get mentionedUserName => _mentionedUserName;

  set mentionedUserName(String value) {
    _mentionedUserName = value;
  }
}
