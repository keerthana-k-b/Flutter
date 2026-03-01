//Write a Dart program to check whether a number is a strong number.

import 'dart:io';

void main(){
  print("Enter a number");
  int? num = int.parse(stdin.readLineSync()!);
  int sum = 0;
  int temp = num;
  while(temp > 0){
    int fact=1;
    int digit = temp % 10;
  for(int i =1; i<= digit;i++){
    fact = fact * i;
  }
  sum += fact;
  temp = temp ~/ 10;
  }
  if(sum == num){
    print("Strong number ");
  }else{
  print("Not");
  }
}