import 'package:googleapis_auth/auth_io.dart';
import 'package:intl/intl_standalone.dart';
import 'package:oauth2/oauth2.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sprintf/sprintf.dart';

class notificationfromuser {
  List<String> scopeslist = [
    'https://www.googleapis.com/auth/firebase.messaging'
  ];
  final  FCM_PUSH_NOTIFICATION_DOMAIN = 'fcm.googleapis.com';
  final FCM_PUSH_NOTIFICATION_ENDPOINT =
      'v1/projects/messinfo-bb96b/messages:send';
  final SCOPES = ['https://www.googleapis.com/auth/firebase.messaging'];

  Future<Map<String, dynamic>> loadJsonFromAssets() async {
    String jsonString =
        await rootBundle.loadString('assets/messinfo-bb96b-607fbe9d297d.json');
    return jsonDecode(jsonString);
  }

  Future<ServiceAccountCredentials> getServiceAccountCredentials() async {
    final credentials = await ServiceAccountCredentials.fromJson({
      "type": "service_account",
      "project_id": "messinfo-bb96b",
      "private_key_id": "607fbe9d297db1ba0b65b09dd5d305ab283db1c5",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCVExaVrLrX2y/H\n8KRw393a1M5rOGeuznoTEhgu0AIxQ0PwDd+6WXSzP/xFTxCJJVSf/uMdUgrSeOP6\n+KgCWjHifBEUOUupIRvkqnOLiL2JbPXY0KqnUCnDALsi4+207Fs6icsB5WHc8cLU\nWRCY8dDJaIAI78QOZKoRT8YlU7CP0ncsEW29iqGEoqGO50sUkDXAIwPfajvFbf1G\nj84fOIwzTHkiPb7KRrkr32kwodOUEJIozgbGI8gZpGGSarbtHQb+Tf6ndUpWD8se\nzdF0MscUhKulZaQKzoZ71D/yjLvM7bOMowrn1fo/k1ow1aVBlBsxDYf0IOUNgpIc\n6ePlsglvAgMBAAECggEAER9dpzhtR5DR9qWhxaM5AMMTqIYUhqQJqnoYE/xpXA4t\nVfvJ+EYBHPua9r0DmbUTeMMWhA4h1xXynaeE6KxCcZCth4SjN5xpb0TSu7KrjobY\n4BvrlgcjnNXPKM1ERtUlD163VhLqQC32olxOhzqzMAcUObKMctjGHfHrQOtRattl\nUJyPTfNhWd3q82eSuXXnYtZsM2DpyvH6u8eOwQrCRr6DbUD53fNSvTAtsT1Hx0S5\nV+bNaGmitD5P0FbJ5yWvkn9FYEKbIZd2HzqUSxE0QWkwp6AVvYaf88IZNIFdXeWE\npTQwVllJ/LIEj+BYyYtHHIj/vIAFw8kWLjzD5N+ZfQKBgQDL9p96wARwt0OmV21a\nmX7dxpRiud58QBOcTZmOyanKCsIlzFwRGkOPMeXhROCfj/fQ1sXV9admAsZwXYCt\nbFU5sBYDmXIym6KIJ8qNxcS1MOWZm0q3+SZeyQpuVUu+qDTz5dZtVbyYVaMv8u25\nWcpV8v5rE6icR51Z1jPtEoHP4wKBgQC7G4joac0oCV6/3FUWLZvU/9aXJ6aKhfS4\njY1/6ciqECnNnxakjwjWQ4nIWmK+XIk8I2sPbXffgBJ3c14ZsX6tCsjuB0MRDkn4\naVfKxpOAngqjNiwVhZAYPtWNk5N20US1skzCNrax628yDOcQ01RrG+Bo4tvRi5e3\nHg4pPPA+BQKBgQDI33rxSWsWF2doy3HHaKSpholdMfEMLY8iwMoa9kFh2nabA0kp\nDtS6kkn0MgGHJCLMarksn2Ld9J26zFuOcML+rY0Avn7ZmK3ZqlayibPRPvbg8TAF\nQDup3hWH1Dlk7AQ6sIEd7PJwlObCsl2tzeCYBVjL2/CS+XTepTc+pJt0QQKBgGym\nSJHtHhyplEOFBkOiqGK/TTTo6WR29OxWBlzIvKVETYIBZ3yXMmJ5RYD6O2ye/3HU\nf06uGnXGQPLsIzB4ST7ijFrsDJ3S1lFRmpE9TlnZbAPqaR72N/5cPlW/5FmSm3uG\n1dvRObWHKUK/C05R6StpPJ6rXUoI7UiAQ2je4gKhAoGBAL/OxJ5KAtINMM7akWQj\nvnOBlJPnJ60sQjwSDZlhn06zjR0Et4q5mIgrIm7vmCZmFf4zpRZEGh8pKU2oL5/e\nOGNi6WW/aLLfvnrBwjv98CEh6p7QR991S45A6POB3zd4KlUTPAeBPeV//7I6V/n+\nL8pYuen214PXaGXfDCkB5cXB\n-----END PRIVATE KEY-----\n",
      "client_email": "amanservers@messinfo-bb96b.iam.gserviceaccount.com",
      "client_id": "105510458679902328840",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/amanservers%40messinfo-bb96b.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    });

    // print(credentials.);
    return credentials;
  }


  // final messageJSON = jsonEncode({
  //   "token":
  //       "device_token", // Replace with the device token you want to send the notification to
  //   "notification": {
  //     // Notification details
  //   },
  //   "data": {
  //     // Optional data payload
  //   }
  // });

  //await sendNotification(messageJSON);

  Future<String> sendNotification(String tokenid,String title,String body) async {


                   final messageJSON=jsonEncode({"message": {
    "token": tokenid.toString(),
    "notification": {
      "title": title,
      "body": body
    },
    "android": {
      "priority": "high"
    }}
  });


    final credentials = await getServiceAccountCredentials();
    AuthClient client = await clientViaServiceAccount(credentials, scopeslist);
    final uri = Uri.https(FCM_PUSH_NOTIFICATION_DOMAIN,
        sprintf(FCM_PUSH_NOTIFICATION_ENDPOINT, ['messinfo-bb96b']));
    final response = await client.post(uri,
        headers: {
          'Authorization': 'Bearer ${client.credentials.accessToken.data}',
          'Content-Type': 'application/json',
        },
        body: messageJSON);

    if (response.statusCode == 200) {
      return 'Notification sent successfully';
    } else {
      return 'Notification failed with status: ${response.statusCode}';
      
    }
  }
}
