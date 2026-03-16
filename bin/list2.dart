import 'dart:io';
void main(){
  List num = [];
  print("Enter limit: ");
  int? n = int.parse(stdin.readLineSync()!);
  print("Enter numbers: ");
  for(int i = 1; i <= n; i++){
     int? val = int.parse(stdin.readLineSync()!);
     num.add(val);
  }
  print(num);
  //num.removeAt(0);
  //print(num);
  //num.removeLast();
  //print(num);
  //num[0] = 60;
  //print(num);
  bool found = num.contains(3);
  print("List containes 3 $found");
  bool notfound = num.contains(5);
  print("List not contains 5 $notfound");
  print(num.indexOf(3));
}