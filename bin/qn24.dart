//Write a Dart program to parse a configuration-style input (key=value format).

import 'dart:io';

void main(){
  Map<String, dynamic> num = {};
  while(true){
    print("Enter key: ");
    String? key=stdin.readLineSync();
    if(key == null ){
      continue;
    }
     if(key.toLowerCase() == 'exit'){
      break;
    }
    print("Enter value: ");
    String? value = stdin.readLineSync();
    
    num[key]=value;  //Map  one by one key  value add
    
  }
  print(num);
}