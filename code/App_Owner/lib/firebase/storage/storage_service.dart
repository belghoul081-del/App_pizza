import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

/// cloudinary لتخزين الصور هذه خاصة 
class StorageService {
  static const String _cloudName = 'u1inminr';
  static const String _uploadPreset = 'x1j19two';

  static Uri get _uploadUrl =>
      Uri.parse('https://api.cloudinary.com/v1_1/$_cloudName/image/upload');

  Future<String> uploadProductImage({
    required String productId,
    required File imageFile,
  }) async {
    // معرّف فريد لكل صورة (منتج + وقت الرفع) بدل الاعتماد على 
    // overwrite
    final String uniqueId =
        '$productId-${DateTime.now().millisecondsSinceEpoch}';

    final request = http.MultipartRequest('POST', _uploadUrl)
      ..fields['upload_preset'] = _uploadPreset
      ..fields['public_id'] = 'products/$uniqueId'
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200) {
      throw Exception('Failed to upload image to Cloudinary: ${response.body}');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return data['secure_url'] as String;
  }

  Future<void> deleteProductImage(String productId) async {}

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
  
   Future<String> uploadannounceImage({
    required String announceId,
    required File imageFile,
  }) async {
    final String uniqueId = '$announceId-${DateTime.now().millisecondsSinceEpoch}';
    return _upload(publicId: 'announcements/$uniqueId', imageFile: imageFile);
  }
}
