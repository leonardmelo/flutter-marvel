class Persons {
  final List<Person> persons;
  final int count;

  Persons(this.persons, this.count);

  factory Persons.fromJson(Map<String, dynamic> json) {
    List<Person> persons = [];

    for (Map<String, dynamic> person in json['data']['results']) {
      persons.insert(0, Person.fromJson(person));
    }

    return Persons(persons, json['data']['count']);
  }
}

class Person {
  final int id;
  final String name;
  final Thumbnail thumbnail;
  final int numberComics;
  final int numberSeries;
  final int numberStories;
  final int numberEvents;

  Person(
      {required this.id,
      required this.name,
      required this.thumbnail,
      required this.numberComics,
      required this.numberEvents,
      required this.numberSeries,
      required this.numberStories});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      name: json['name'],
      thumbnail: Thumbnail.fromJson(json['thumbnail']),
      numberComics: json['comics']["available"],
      numberEvents: json['events']["available"],
      numberSeries: json['series']["available"],
      numberStories: json['stories']["available"],
    );
  }
  @override
  String toString() {
    return 'Id:$id - Name:$name';
  }
}

class Thumbnail {
  final String path;
  final String extension;

  Thumbnail(this.path, this.extension);

  factory Thumbnail.fromJson(Map<String, dynamic> json) {
    return Thumbnail(json['path'], json['extension']);
  }
}
