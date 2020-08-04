class Journal{
  int id;
  String title;
  String body;
  String rating;
  String date;


  journalMap(){
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['title'] = title;
    mapping['body'] = body;
    mapping['rating'] = rating;
    mapping['date'] = date;

    return mapping;
  }
}