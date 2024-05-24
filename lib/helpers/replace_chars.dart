String replacePhone(String phoneNumber) {
  if (phoneNumber.isEmpty || phoneNumber == 'null') {
    return "";
  } else {
    return phoneNumber.replaceRange(4, 9, "*****");
  }
}

String replaceEmail(String email) {
  if (email.isEmpty) {
    return "";
  } else {
    var userName = email.split("@");
    var newEmail = email.replaceRange(
      2,
      userName[0].length,
      "*" * (userName[0].length - 2),
    );
    return newEmail;
  }
}
