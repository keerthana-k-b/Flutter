//Develop a program to find all Armstrong numbers within a given range.

import 'dart:io';
import 'dart:math';

void main(){
  int? a = int.parse(stdin.readLineSync()!);  //100
  int? b = int.parse(stdin.readLineSync()!);  //200
 for(int i = a; i <= b; i++){
  int temp = i;
  int len = i.toString().length; //integer convert to string
  int sum = 0;
  while(temp>0){
    int digit = temp % 10;
    sum += pow(digit,len).toInt();
    temp = temp ~/ 10;
  }
  if(sum == i){
  print("$i");
  }
 }
}