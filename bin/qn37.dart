//Create a program that finds all duplicate digits in a number entered by the user.

import 'dart:io';

void main(){
  String? n = stdin.readLineSync()!;
  String dup = '' ;
  for (int i = 0; i < n.length-1 ; i++){
    if(n[i] == n[i+1]){
      if(!dup.contains(n[i])){   //check dup already have the digit 
      dup += n[i];  
      }
    }
  }
  if(dup == ''){
    print("No duplicates");
  } else {
    print(" Number $n ,Duplicates: $dup");
  }
}