import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import '../models/user.dart';
import './connected_scoped_model.dart';

class UserModel extends ConnectedModel {
  User authenticatedUser = null;
  User get getAuthenticatedUser {
    print(authenticatedUser);
    return authenticatedUser;
  }

  // Future<Null> userLogin(String email, String password) async {
  //   isLoading = true;
  //   notifyListeners();
  //   print('Inside Plogin : ');
  //   Map<String, dynamic> req = {'email': email, 'password': password};
  //   try {
  //     http.Response response = await http.post('${uri}api/patients/login',
  //         body: json.encode(req),
  //         headers: {'Content-Type': 'application/json'});
  //     if (response.statusCode == 200) {
  //       print('Inside plogin success');
  //       final Map<String, dynamic> res = json.decode(response.body);
  //       await setAuthenticatedUser(res['patientId'], res['token']);
  //     }
  //     isLoading = false;
  //     notifyListeners();
  //   } catch (error) {
  //     print("Error in Plogin:  " + error.toString());
  //     isLoading = false;
  //     notifyListeners();
  //     return;
  //   }
  // }

  // Future<Null> setAuthenticatedUser(String userId, String token) async {
  //   isLoading = true;
  //   notifyListeners();
  //   print('Inside setAuthenticatedUser : ');
  //   return await http
  //       .get(
  //     '${uri}api/patients/patient/$userId',
  //   )
  //       .then<Null>((http.Response response) {
  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> responseData = json.decode(response.body);
  //       User user = new User();
  //       authenticatedUser = user;
  //       isLoading = false;
  //       notifyListeners();
  //     }
  //   }).catchError((error) {
  //     isLoading = false;
  //     notifyListeners();
  //     print("Fetch Authenticated User Error: ${error.toString()}");
  //     return;
  //   });
  // }
}
