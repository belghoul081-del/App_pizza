import 'package:app_pizza_client/models/model_announcement/announcement_Model.dart';
import 'package:flutter/material.dart';

Widget Content(
  BuildContext context, {
  required int barIndex,
  required int totalBar,
  required PageController controller,
  required List<Announcement_Model> items,
}) {
  return Container(
    child: PageView.builder(
      controller: controller,
      itemCount: totalBar,
      itemBuilder: (context, index) {
        if (index >= items.length) return const SizedBox.shrink();
        final announcement = items[index];
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Image.network(
                announcement.imagePath,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  );
                },
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, color: Colors.white),
              ),
            ),
          ],
        );
      },
    ),
  );
}
