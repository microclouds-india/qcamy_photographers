class BookingDetailsModel {
  BookingDetailsModel({
    required this.id,
    required this.name,
    required this.userId,
    required this.photographerId,
    required this.request,
    required this.bookingDate,
    required this.phone,
    required this.alternateNumber,
    required this.status,
    required this.address,
    required this.bookingPurpose,
  });

  String id;
  String name;
  String userId;
  String photographerId;
  String request;
  String bookingDate;
  String phone;
  String alternateNumber;
  String address;
  String status;
  String bookingPurpose;

  factory BookingDetailsModel.fromJson(Map<String, dynamic> json) =>
      BookingDetailsModel(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        userId: json["user_id"] ?? "",
        photographerId: json["photographer_id"] ?? "",
        request: json["request"] ?? "",
        bookingDate: json["booking_date"] ?? "",
        phone: json["phone"] ?? "",
        alternateNumber: json["alternate_number"] ?? "",
        status: json["status"] ?? "",
        address: json["address"] ?? "",
        bookingPurpose: json["booking_purpose"] ?? "Not specified",
      );
}
