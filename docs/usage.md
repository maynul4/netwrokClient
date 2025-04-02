Import the package

import 'package:network_client/network_client.dart';

//Making a GET request

void main() async {
String url = 'https://api.example.com/data';

NetworkResponse response = await NetworkClient.getRequest(url: url);

if (response.isSuccess) {
print('Data: ${response.body}');
} else {
print('Error: ${response.errorMessage}');
}
}


//Making a POST request

void main() async {
String url = 'https://api.example.com/submit';
Map<String, dynamic> body = {'name': 'John Doe', 'email': 'johndoe@example.com'};

NetworkResponse response = await NetworkClient.postRequest(url: url, body: body);

if (response.isSuccess) {
print('Data: ${response.body}');
} else {
print('Error: ${response.errorMessage}');
}
}


//Other HTTP Methods
You can use the following methods similarly to make PUT, PATCH, or DELETE requests:

NetworkClient.putRequest(url: url, body: body)

NetworkClient.patchRequest(url: url, body: body)

NetworkClient.deleteRequest(url: url)



