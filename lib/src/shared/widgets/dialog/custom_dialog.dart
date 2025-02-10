import "package:flutter/material.dart";

void customDialog(BuildContext context, String title, String subtitle) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.orange),
            SizedBox(width: 8),
            Text(title),
          ],
        ),
        content: Text(
          subtitle,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.orange)),
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              "Continuar",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
}
