import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:optix_scouting/data.dart';

void showSaveDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      String comments = '';

      return AlertDialog(
        title: Text('Additional Comments'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Additional Comments',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                comments = value;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                DataStorage.storeComments(comments); // Store the comments in DataStorage
                String jsonData = DataStorage.exportData(); // Get the JSON data

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('QR Code'),
                      content: QrImageView(
                        data: jsonData,
                        version: QrVersions.auto,
                        size: 320,
                        gapless: false,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Save'),
            ),
          ],
        ),
      );
    },
  );
}
