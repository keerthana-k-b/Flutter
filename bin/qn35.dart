//Write a Dart program to compress a numeric string using run-length encoding (e.g., 1113322 → 3(1)2(3)2(2)).

import 'dart:io';

void main(){
  String? input = stdin.readLineSync()!;
  String result = '';
  int count = 1;
  for(int i = 0; i < input.length; i++){
    if(i < input.length - 1 && input[i] == input[i + 1]){
      count++;
    }else{
        result += "$count(${input[i]})";
        count = 1;
    }
  }
  print("Compressed string: $result");

}