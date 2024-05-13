String replacePhone(String phoneNumber) {
  return phoneNumber.replaceRange(4, 9, "*****");
}

String replaceEmail(String email) {
  var userName = email.split("@");
  var newEmail = email.replaceRange(
    2,
    userName[0].length,
    "*" * (userName[0].length - 2),
  );
  return newEmail;
}
