import 'dart:async';

FutureOr<void> Function()? onWindowShouldClose;

String getInitials(String name) {
  List<String> nameParts = name.split(' ');
  if (nameParts.length == 1) {
    // If the user has only one name part, return the first letter
    return nameParts.first.substring(0, 1).toUpperCase();
  } else {
    // If the user has multiple name parts, return the initials of the first and last parts
    return nameParts.first.substring(0, 1).toUpperCase() +
        nameParts.last.substring(0, 1).toUpperCase();
  }
}
