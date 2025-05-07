class VolunteerDesignedCounter {
  final int name;
  final String designed_count;

  VolunteerDesignedCounter({required this.name, required this.designed_count});

  factory VolunteerDesignedCounter.fromJson(Map<String, dynamic> json) {
    return VolunteerDesignedCounter(
      name: json['volunteer_name'],
      designed_count: json['designed_count'],
    );
  }
}
