// dart run merge_script.dart

import 'dart:io';

void main() async {
  // اسم المجلد الذي يحتوي على ملفاتك (النقطة تعني المجلد الحالي)
  final dir = Directory('.');
  final outputFile = File('full_project.txt');
  
  // فتح الملف للكتابة (سيمسح محتواه القديم إن وجد)
  final sink = outputFile.openWrite();

  // البحث عن كل ملفات .dart بشكل متكرر (Recurse)
  await for (final entity in dir.list(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      // تجاهل ملف السكربت نفسه حتى لا يدخل في الحلقة
      if (entity.path.endsWith('merge_script.dart')) continue;

      sink.writeln('\n\n// ==========================================');
      sink.writeln('// FILE: ${entity.path}');
      sink.writeln('// ==========================================\n');
      
      final content = await entity.readAsString();
      sink.write(content);
      sink.writeln('\n');
      
      print('تمت إضافة: ${entity.path}');
    }
  }

  await sink.close();
  print('\nتم الانتهاء! تم دمج جميع الملفات في: full_project.txt');
}