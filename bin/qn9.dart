//Develop a program that checks whether two numeric strings are anagrams

import 'dart:io';

void main(){
  String? a = stdin.readLineSync()!;
  String? b = stdin.readLineSync()!;
  List l1 = a.split('')..sort();
  List l2 = b.split('')..sort();
  if( l1.join() == l2.join()){
    print("Anagrams");
  }else{
    print("Not anagrams");
  }
}