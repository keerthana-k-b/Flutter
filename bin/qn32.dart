//Write a program that keeps asking for input and only accepts even numbers, rejecting all others with a message.

import 'dart:io';

void main(){
  print("Enter a number: ");
  int? n = int.parse(stdin.readLineSync()!);
  for(int i = 0; i <= n; i++){
  int? num = int.parse(stdin.readLineSync()!);
  if( num % 2 == 0){
    print(num);
  }else{
    print("Not an even number please enter a valid even number !");
  }
  }
}