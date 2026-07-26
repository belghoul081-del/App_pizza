import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

/// نفس حساب Cloudinary المستخدَم في تطبيق المالك بالضبط (نفس Cloud name
/// والـ preset، فهو حساب واحد مشترك للمشروع بأكمله وليس خاصًا بتطبيق
/// معيّن). يُستخدم هنا لرفع صورة الملف الشخصي للزبون فقط.

class StorageService {
  static const String _cloudName = 'u1inminr';
  static const String _uploadPreset = 'x1j19two';

  static Uri get _uploadUrl =>
      Uri.parse('https://api.cloudinary.com/v1_1/$_cloudName/image/upload');

  Future<String> uploadClientImage({
    required String uid,
    required File imageFile,
  }) async {
    final String uniqueId = '$uid-${DateTime.now().millisecondsSinceEpoch}';
    return _upload(publicId: 'clients/$uniqueId', imageFile: imageFile);
  }

  /// ✅ جديد: رفع صورة تُرسَل داخل محادثة (لا تحتاج قصًا مربعًا 1:1 مثل
  /// صورة الملف الشخصي، تُرفع كما هي).
  Future<String> uploadChatImage({
    required String chatId,
    required File imageFile,
  }) async {
    final String uniqueId = '$chatId-${DateTime.now().millisecondsSinceEpoch}';
    return _upload(publicId: 'chat/$uniqueId', imageFile: imageFile);
  }

  Future<String> _upload({
    required String publicId,
    required File imageFile,
  }) async {
    final request = http.MultipartRequest('POST', _uploadUrl)
      ..fields['upload_preset'] = _uploadPreset
      ..fields['public_id'] = publicId
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200) {
      throw Exception('Failed to upload image to Cloudinary: ${response.body}');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return data['secure_url'] as String;
  }
}
