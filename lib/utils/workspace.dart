class Workspace {

  int id;
  String title;
  String description;
  DateTime modifiedTime;
  DateTime creationTime;

  Workspace({
    required this.id,
    required this.title, required this.description,
    required this.modifiedTime, required this.creationTime
  });

}