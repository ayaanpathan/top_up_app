import 'package:flutter/material.dart';

/// A widget that displays an alert dialog with a title and content.
class AlertDialogWidget extends StatelessWidget {
  /// Constructs an [AlertDialogWidget] with the given [title] and [content].
  const AlertDialogWidget({
    super.key,
    required this.title,
    required this.content,
  });

  /// The title of the alert dialog.
  final String title;

  /// The content text of the alert dialog.
  final String content;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      backgroundColor: theme.primaryColorDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Row(
        children: [
          Icon(
            Icons.warning,
            color: Theme.of(context).hintColor,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).hintColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      content: Text(
        content,
        style: TextStyle(
          fontSize: 17,
          color: theme.dividerColor,
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'OK',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
