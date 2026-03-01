import 'dart:io';
void main(){
  List l1= [];
  print("Enter a number: ");
  int? n = int.parse(stdin.readLineSync()!);
  for(int i = 1; i <= n; i++){
  //l1.add(i);
  l1 += [i];
  }
 print(l1);
  
}