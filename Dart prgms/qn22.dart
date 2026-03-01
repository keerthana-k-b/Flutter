//Write a Dart program to simulate a login system with username/password validation and limited attempts.

import 'dart:io';

void main(){
  String uname = "Keerthana";
  String pswd = "Keer@123";
  for(int i=0; i < 4 ; i++){
  print("Enter Username:");
  String? name = stdin.readLineSync();
  print("Password");
  String? pwd = stdin.readLineSync();
  if(uname == name && pswd == pwd){
    print("Login Successfully");
    break;
  }else{
    print("Invalid Username or Password");
  }
  }

}