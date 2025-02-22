
class Note{
  int id;
  int date;
  String title;
  String description;

  Note(this.id, this.date, this.title, this.description);

}

Note noteFromJson(Map<String, dynamic> json) {
  return Note(
      json["id"],
      json["date"],
      json["title"],
      json["description"]
  );
}