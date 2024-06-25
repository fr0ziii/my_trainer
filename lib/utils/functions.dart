import 'dart:math';

import 'package:uuid/uuid.dart';

String generateUniqueUid(String baseUid) {
  var uuid = Uuid();
  return uuid.v5(Uuid.NAMESPACE_URL, baseUid);
}

String generateUniqueInvitationCode() {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final random = Random();
  return String.fromCharCodes(
    Iterable.generate(6, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
  );
}
