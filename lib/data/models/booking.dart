import 'package:equatable/equatable.dart';

class Booking extends Equatable {
  String id;
  String user_id;
  String title;
  String name;
  DateTime? timeOfBooking;
  DateTime? timeOfOrder;
  int personCount;
  String comment;
  String status;
  String phone;

  Booking(
      {this.id = "",
      this.user_id = "",
      this.title = "",
      this.name = "",
      required this.timeOfBooking,
      required this.timeOfOrder,
      this.personCount = 0,
      this.comment = "",
      this.status = "",
      this.phone = ""});

  Booking copyWith(
      {String? id,
      String? user_id,
      String? title,
      String? name,
      DateTime? timeOfBooking,
      DateTime? timeOfOrder,
      int? personCount,
      String? comment,
      String? status,
      String? phone}) {
    return Booking(
        user_id: user_id ?? this.user_id,
        id: id ?? this.id,
        title: title ?? this.title,
        name: name ?? this.name,
        timeOfBooking: timeOfBooking ?? this.timeOfBooking,
        timeOfOrder: timeOfOrder ?? this.timeOfOrder,
        personCount: personCount ?? this.personCount,
        comment: comment ?? this.comment,
        status: status ?? this.status,
        phone: phone ?? this.phone);
  }

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
        id: json["_id"] ?? null,
        user_id: json["user_id"] ?? null,
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
        status: json["status"] ?? null,
        phone: json["phone"] ?? null);
  }

  @override
  String toString() {
    return 'Booking(user_id: $user_id, title: $title, name: $name, timeOfBooking: $timeOfBooking, timeOfOrder: $timeOfOrder, personCount: $personCount, comment: $comment, status: $status, phone: $phone)';
  }

  @override
  List<Object?> get props =>
      [title, name, timeOfBooking, personCount, comment, phone];
}
