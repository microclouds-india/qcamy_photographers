class ConformBookingModel {
  ConformBookingModel({
    required this.request,
    required this.bookingDate,
    required this.message,
    required this.status,
  });

  String request;
  String bookingDate;
  String message;
  String status;

  factory ConformBookingModel.fromJson(Map<String, dynamic> json) =>
      ConformBookingModel(
        request: json["request"],
        bookingDate: json["booking_date"],
        message: json["message"],
        status: json["status"],
      );
}
