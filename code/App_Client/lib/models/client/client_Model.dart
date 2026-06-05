
class Client_Data {
  //int uID;
  String name;
  //رمز اشعار
  //String addres;
  //Image image;
  String number;
  String password;

  Client_Data({this.number = '', this.password = '',this.name=''});
}


/*
class ClientModel {
  String? uID;        // 👈 أضفنا المعرف الفريد الذي يمنحه فايربيس لكل مستخدم
  String name;
  String number;
  String password;    // ⚠️ ملاحظة: كلمة المرور لا تُخزن في قاعدة البيانات بل تُرسل فقط للـ Authentication

  ClientModel({
    this.uID,
    this.name = '',
    this.number = '',
    this.password = '',
  });

  // 1️⃣ الدالة السحرية الأولى: تحويل كود Dart إلى خريطة Map لإرسالها لفايربيس
  Map<String, dynamic> toMap() {
    return {
      'uID': uID,
      'name': name,
      'number': number,
      // لا نضع كلمة المرور هنا لحماية خصوصية المستخدم في قاعدة البيانات
    };
  }

  // 2️⃣ الدالة السحرية الثانية: استقبال البيانات القادمة من فايربيس وتحويلها لكائن Dart نفهمه
  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      uID: map['uID'] as String?,
      name: map['name'] as String? ?? '',
      number: map['number'] as String? ?? '',
    );
  }
}


 */