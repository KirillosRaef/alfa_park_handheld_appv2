import 'dart:io';

File? setImage(String? path) {
  if (path != null) {
    return File(path);
  }
  return null;
}
