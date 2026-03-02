void main(){
  Map<String, List<String>> courses = {
    'Flutter' : ['Dart', 'Widget'],
    'Web' : ['HTML', 'CSS'],
  };
  print(courses);
  print(courses['Flutter']);
  print(courses['Flutter']![0]);
}