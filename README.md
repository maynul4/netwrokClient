1. GET Request
   The GET request fetches data from a given URL.

dart
Copy
Edit
import 'package:network_client/network_client.dart';

void main() async {
String url = 'https://api.example.com/data';

// Make the GET request
NetworkResponse response = await NetworkClient.getRequest(url: url);

// Check if the request was successful
if (response.isSuccess) {
print('Data: ${response.body}');
} else {
print('Error: ${response.errorMessage}');
}
}
2. POST Request
   The POST request is used to send data to a server.

dart
Copy
Edit
import 'package:network_client/network_client.dart';

void main() async {
String url = 'https://api.example.com/submit';
Map<String, dynamic> body = {'name': 'John Doe', 'email': 'johndoe@example.com'};

// Make the POST request
NetworkResponse response = await NetworkClient.postRequest(url: url, body: body);

// Check if the request was successful
if (response.isSuccess) {
print('Response Data: ${response.body}');
} else {
print('Error: ${response.errorMessage}');
}
}
3. PUT Request
   The PUT request is used to update existing data on the server.

dart
Copy
Edit
import 'package:network_client/network_client.dart';

void main() async {
String url = 'https://api.example.com/update';
Map<String, dynamic> body = {'id': 1, 'name': 'John Doe', 'email': 'john.updated@example.com'};

// Make the PUT request
NetworkResponse response = await NetworkClient.putRequest(url: url, body: body);

// Check if the request was successful
if (response.isSuccess) {
print('Response Data: ${response.body}');
} else {
print('Error: ${response.errorMessage}');
}
}
4. PATCH Request
   The PATCH request is used to partially update data on the server.

dart
Copy
Edit
import 'package:network_client/network_client.dart';

void main() async {
String url = 'https://api.example.com/patch';
Map<String, dynamic> body = {'email': 'john.partial.update@example.com'};

// Make the PATCH request
NetworkResponse response = await NetworkClient.patchRequest(url: url, body: body);

// Check if the request was successful
if (response.isSuccess) {
print('Response Data: ${response.body}');
} else {
print('Error: ${response.errorMessage}');
}
}
5. DELETE Request
   The DELETE request is used to delete data from the server.

dart
Copy
Edit
import 'package:network_client/network_client.dart';

void main() async {
String url = 'https://api.example.com/delete/1';

// Make the DELETE request
NetworkResponse response = await NetworkClient.deleteRequest(url: url);

// Check if the request was successful
if (response.isSuccess) {
print('Response Data: ${response.body}');
} else {
print('Error: ${response.errorMessage}');
}
}