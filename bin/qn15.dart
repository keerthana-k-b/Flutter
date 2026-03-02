import 'dart:io';

void main(){
  print("Enter elements: ");
  String? nums= stdin.readLineSync();
  List<int> numbers =nums!.split(',').map((n) => int.parse(n.trim())).toList();
  print("List $numbers" );
  var doubled = numbers.map((e) => e * e).toList();
print("Power $doubled");
}

