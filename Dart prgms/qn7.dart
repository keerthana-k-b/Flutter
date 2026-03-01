//Create a program to find the longest numeric substring within a given input string

import 'dart:io';

void main(){
  stdout.write("Enter a string: ");
  String? input = stdin.readLineSync()!;
  print(input);
  int len =input.length ;
  String longest ='';
  String currentvariable = '';
for(int i = 0; i < len ; i++){
  if(input[i].contains(RegExp(r'^\d+$'))){
    currentvariable += input[i]; 
    if(currentvariable.length > longest.length){
      longest = currentvariable;
    }
  }else{
      currentvariable = '';
  }
}
print(longest);
}