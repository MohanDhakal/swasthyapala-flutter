
import 'package:flutter/foundation.dart';

class Replies {
  @required
  int repId;
  @required
  String replyMessage;
  @required
  int mentionedUserId;
  @required
  String mentionedUserName;

  Replies({this.repId, this.replyMessage, this.mentionedUserId});
}
