class Event {
  final String? imageUrl; // Allow properties to be nullable
  final String? title;
  final String? description;
  final String? date;
  final String? time;
  final String? location;

  Event({
    this.imageUrl,
    this.title,
    this.description,
    this.date,
    this.time,
    this.location,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      imageUrl: json['imageUrl'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      location: json['location'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'location': location,
    };
  }
}