class SearchBookingsModel {
  SearchBookingsModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory SearchBookingsModel.fromJson(Map<String, dynamic> json) =>
      SearchBookingsModel(
        message: json["message"] ?? "",
        data:
            List<Datum>.from(json["data"]?.map((x) => Datum.fromJson(x)) ?? []),
        status: json["status"],
      );
}

class Datum {
  Datum({
    required this.photographerId,
    required this.orderId,
    required this.date,
    required this.name,
    required this.userId,
    required this.status,
    required this.bookingDate,
    required this.bookingPlace,
    required this.phone,
    required this.alternateNumber,
    required this.bookingPurpose,
  });

  String photographerId;
  String orderId;
  String date;
  String name;
  String userId;
  String status;
  String bookingDate;
  String bookingPlace;
  String phone;
  String alternateNumber;
  String bookingPurpose;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        photographerId: json["photographer_id"] ?? "",
        orderId: json["order_id"] ?? "",
        date: json["date"] ?? "",
        name: json["name"] ?? "",
        userId: json["user_id"] ?? "",
        status: json["status"] ?? "",
        bookingDate: json["booking_date"] ?? "",
        bookingPlace: json["booking_place"] ?? "",
        phone: json["phone"] ?? "",
        alternateNumber: json["alternate_number"] ?? "",
        bookingPurpose: json["booking_purpose"] ?? "Not specified",
      );
}
