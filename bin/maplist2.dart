void main(){
 Map<String, List<String>> course ={
  'Science' : ['Physics', 'Chemistry', 'Biology'],
  'Data Science' : ['Excel', 'PowerBi', 'Tableau'],
 };
 print(course);
 print(course['Science']);
 print(course['Data Science']![0]);
  print(course['Data Science']![2]);

}