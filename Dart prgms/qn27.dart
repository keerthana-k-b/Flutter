//Program to analyze a number (prime, Armstrong, palindrome).

import 'dart:io';
import 'dart:math';

void main(){
  print("Enter a number:");
  int? num = int.parse(stdin.readLineSync()!);
  int temp = num;
  int sum = 0;
  int rev = 0;
  //int len = num.length;
  bool isPrime = true;
  //int? n = int.parse(stdin.readLineSync()!);
  for(int i = 2; i < num; i++){
    if( num % i == 0){
      isPrime = false;
      break;
    } 
  }
  if(isPrime){
  print("Prime");
  }

  int b = num.toString().length; // num -> string -> length
  temp = num;
  for(int i = 0; i < b; i++){
    int digit = temp % 10;
    sum += pow(digit, b).toInt();
    temp = temp  ~/ 10;
  }
    if(num == sum){
      print("Armstrong number");
    }

  temp = num;

  while (temp > 0){
    int digit = temp % 10;
    //print(temp);
    rev = rev * 10 + digit;
    temp = temp ~/ 10;
  }
  
 // print(rev);
   if(num == rev ){
      print("Palindrome number");
    }
  
}
