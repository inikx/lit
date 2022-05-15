class Booking {
  String user_id;
  //int booking_id;
  String title;
  String name;
  DateTime? timeOfBooking;
  DateTime? timeOfOrder;
  int personCount;
  String comment;
  String status;

  Booking(
      {this.user_id = "",
      //this.booking_id = -1,
      this.title = "",
      this.name = "",
      required this.timeOfBooking,
      required this.timeOfOrder,
      this.personCount = 0,
      this.comment = "",
      this.status = ""});

  Booking copyWith(
      {String? user_id,
      //int? booking_id,
      String? title,
      String? name,
      DateTime? timeOfBooking,
      DateTime? timeOfOrder,
      int? personCount,
      String? comment,
      String? status}) {
    return Booking(
        user_id: user_id ?? this.user_id,
        //booking_id: booking_id ?? this.booking_id,
        title: title ?? this.title,
        name: name ?? this.name,
        timeOfBooking: timeOfBooking ?? this.timeOfBooking,
        timeOfOrder: timeOfOrder ?? this.timeOfOrder,
        personCount: personCount ?? this.personCount,
        comment: comment ?? this.comment,
        status: status ?? this.status);
  }

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
        user_id: json["user_id"] ?? null,
        //booking_id: json["id"] ?? null,
        title: json["title"],
        name: json["name"],
        timeOfBooking: json["timeOfBooking"] != null
            ? DateTime.parse(json["timeOfBooking"])
            : null,
        timeOfOrder: json["timeOfOrder"] != null
            ? DateTime.parse(json["timeOfOrder"])
            : null,
        personCount: json["personCount"] ?? null,
        comment: json["comment"] ?? null,
        status: json["status"] ?? null);
  }

  @override
  String toString() {
    return 'Booking(user_id: $user_id, title: $title, name: $name, timeOfBooking: $timeOfBooking, timeOfOrder: $timeOfOrder, personCount: $personCount, comment: $comment, status: $status)';
  } //booking_id: $booking_id,
}
