//Create a program that validates a phone number format entered by the user (e.g., 10 digits, no letters).

import 'dart:io';

void main(){
  print("Enter phone number : ");
  String phn = stdin.readLineSync()!;
  bool num = true;
  if(phn.length == 10 || RegExp('[0 - 9]').hasMatch(phn)){
    print("Valid Phone number: $phn");
    
  }else {
  num = false;
  print("Invalid phone number");
 }
}