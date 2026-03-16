//. Create a program to generate all prime numbers up to a given limit using optimized logic.

import 'dart:io';

void main(){
  
  print("Enter number:");
  int? limit = int.parse(stdin.readLineSync()!);
   print("Prime numbers:");
 for(int num = 2; num <= limit; num++){
  bool isPrime = true;
  for(int i =2; i < num; i++){
    if(num % i == 0){
      isPrime = false;
      break;
    }
  }

  if(isPrime){
    print(num);
  }
 }
}