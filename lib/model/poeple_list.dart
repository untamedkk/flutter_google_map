class Peoples {
  final List<People> peoples;

  Peoples.fromJson(List<dynamic> json) : this.peoples = [] {
    //var src = (json ?? {}) as List;
    List<People> c = json.map((tagJson) => People.fromJson(tagJson)).toList();
    this.peoples.addAll(c);
  }
}

class People {
  final String id;
  final Name name;
  final String email;
  final String picture;
  final Location location;

  People(this.id, this.name, this.email, this.picture, this.location);

  People.fromJson(Map<String, dynamic> json)
      : this.id = json['_id'],
        this.name = Name.fromJson(json['name']),
        this.email = json['email'],
        this.picture = json['picture'],
        this.location = Location.fromJson(json['location']);
}

class Name {
  final String last;
  final String first;

  Name(this.last, this.first);

  Name.fromJson(Map<String, dynamic> json)
      : this.first = json['first'],
        this.last = json['last'];
}

class Location {
  final double lat;
  final double long;

  Location(this.lat, this.long);

  Location.fromJson(Map<String, dynamic> json)
      : this.lat = json['latitude'],
        this.long = json['longitude'];
}
