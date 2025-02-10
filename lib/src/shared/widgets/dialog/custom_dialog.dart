import "package:flutter/material.dart";

void customDialog(BuildContext context, String title, String subtitle) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.orange),
            SizedBox(width: 8),
            Text(title),
          ],
        ),
        content: Text(subtitle),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Confirmar"),
          ),
        ],
      );
    },
  );
}
