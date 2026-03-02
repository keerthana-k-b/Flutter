void main(){
  String name = 'Keerthana';
  print("Keerthana");
  print(name.length);
  print(name.isEmpty);
  print(name.isNotEmpty);
  print(name.contains('r'));
  print(name.toLowerCase());
  print(name.toUpperCase());
  print(name[0]);
  print(name[5]);

  String lname = 'K B ';
  print("$name $lname");
  print(lname.trimLeft());
  print(lname.trimRight());
  print(name.split('t'));
  String rev = name.split('').reversed.join();
  print(rev);
  print('name'.compareTo('lname'));

}