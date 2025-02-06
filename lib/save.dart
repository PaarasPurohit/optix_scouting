import 'package:flutter/material.dart';
import 'package:optix_scouting/data.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
            if (DataStorage.defense) 
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
                DataStorage.comments = comments;
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('QR Code'),
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 320,
                              height: 320,
                              child: QrImageView(
                                data: DataStorage.toJson().toString(),
                                version: QrVersions.auto,
                                size: 100,
                                gapless: false,
                              ),
                            ),
                          ],
                        ),
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
