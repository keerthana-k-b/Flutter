//Write a Dart program that reads input until the user types "exit" and stores all valid integers entered.

import 'dart:io';
void main(){
  List<int> num=[];
  final RegExp intRegex = RegExp(r'^-?\d+$');

  while(true){
    stdout.write("Enter numbers:");
    String? input = stdin.readLineSync();
    if(input == null || input.isEmpty){
      continue;
    }
    else if(input.toLowerCase() == 'exit' ){
        break;
    }else{
     int? value=int.tryParse(input);
       if(value != null){
         num.add(value);  //List one by one value add
      }else{
       print("Invalid input! ");
     }
   }
    print(num);
  }
}