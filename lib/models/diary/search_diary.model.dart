class SearchDiaryModel {
  SearchDiaryModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory SearchDiaryModel.fromJson(Map<String, dynamic> json) =>
      SearchDiaryModel(
        message: json["message"] ?? "",
        data:
            List<Datum>.from(json["data"]?.map((x) => Datum.fromJson(x)) ?? ""),
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
    required this.bookingPurpose,
    required this.phone,
    required this.alternateNumber,
  });

  String photographerId;
  String orderId;
  String date;
  String name;
  String userId;
  String status;
  String bookingDate;
  String bookingPlace;
  String bookingPurpose;
  String phone;
  String alternateNumber;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        photographerId: json["photographer_id"] ?? "",
        orderId: json["order_id"] ?? "",
        date: json["date"] ?? "",
        name: json["name"] ?? "",
        userId: json["user_id"] ?? "",
        status: json["status"] ?? "",
        bookingDate: json["booking_date"] ?? "",
        bookingPlace: json["booking_place"] ?? "",
        bookingPurpose: json["booking_purpose"] ?? "",
        phone: json["phone"] ?? "",
        alternateNumber: json["alternate_number"] ?? "",
      );
}
