import 'package:flutter/material.dart';
import 'package:network_client/network_client.dart'; // Import your network client package

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Network Client Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NetworkExampleScreen(),
    );
  }
}

class NetworkExampleScreen extends StatelessWidget {
  final String url = 'https://jsonplaceholder.typicode.com/posts';

  // Example for GET request
  Future<void> getRequestExample() async {
    NetworkResponse response = await NetworkClient.getRequest(url: url);
    if (response.isSuccess) {
      print('GET Response: ${response.body}');
    } else {
      print('GET Error: ${response.errorMessage}');
    }
  }

  // Example for POST request
  Future<void> postRequestExample() async {
    Map<String, dynamic> body = {'title': 'foo', 'body': 'bar', 'userId': 1};
    NetworkResponse response = await NetworkClient.postRequest(url: url, body: body);
    if (response.isSuccess) {
      print('POST Response: ${response.body}');
    } else {
      print('POST Error: ${response.errorMessage}');
    }
  }

  // Example for PUT request
  Future<void> putRequestExample() async {
    Map<String, dynamic> body = {'title': 'updated title', 'body': 'updated body'};
    NetworkResponse response = await NetworkClient.putRequest(url: url + '/1', body: body);
    if (response.isSuccess) {
      print('PUT Response: ${response.body}');
    } else {
      print('PUT Error: ${response.errorMessage}');
    }
  }

  // Example for PATCH request
  Future<void> patchRequestExample() async {
    Map<String, dynamic> body = {'title': 'patched title'};
    NetworkResponse response = await NetworkClient.patchRequest(url: url + '/1', body: body);
    if (response.isSuccess) {
      print('PATCH Response: ${response.body}');
    } else {
      print('PATCH Error: ${response.errorMessage}');
    }
  }

  // Example for DELETE request
  Future<void> deleteRequestExample() async {
    NetworkResponse response = await NetworkClient.deleteRequest( url: 'url',);
    if (response.isSuccess) {
      print('DELETE Response: ${response.body}');
    } else {
      print('DELETE Error: ${response.errorMessage}');
    }
  }

  // Example of universal API call method (dynamic HTTP methods)
  Future<void> callApiMethodExample() async {
    String method = 'GET'; // You can change this to 'POST', 'PUT', 'PATCH', or 'DELETE'
    NetworkResponse response = await callAPIMethod(method: method, url: url);
    if (response.isSuccess) {
      print('$method Response: ${response.body}');
    } else {
      print('$method Error: ${response.errorMessage}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Network Client Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ElevatedButton(
              onPressed: getRequestExample,
              child: Text('GET Request Example'),
            ),
            ElevatedButton(
              onPressed: postRequestExample,
              child: Text('POST Request Example'),
            ),
            ElevatedButton(
              onPressed: putRequestExample,
              child: Text('PUT Request Example'),
            ),
            ElevatedButton(
              onPressed: patchRequestExample,
              child: Text('PATCH Request Example'),
            ),
            ElevatedButton(
              onPressed: deleteRequestExample,
              child: Text('DELETE Request Example'),
            ),
            ElevatedButton(
              onPressed: callApiMethodExample,
              child: Text('Dynamic API Call Example'),
            ),
          ],
        ),
      ),
    );
  }
}
