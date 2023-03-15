// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyphotographers/common/ui/Ui.dart';
import 'package:qcamyphotographers/config/colors.dart';
import 'package:qcamyphotographers/repository/my_bookings/my_bookings.notifier.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'bookings.view.dart';

class BookingDetailsView extends StatelessWidget {
  const BookingDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myBookingsData =
        Provider.of<MyBookingsNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 1,
        title: Text(
          "Booking Details",
          style: GoogleFonts.openSans(
              fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
          future: myBookingsData.getBookingDetails(
              bookingId: myBookingsData.bookingId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  OrderDetails(
                      orderNumber: myBookingsData.bookingDetailsModel.id,
                      name: myBookingsData.bookingDetailsModel.name,
                      bookingDate:
                          myBookingsData.bookingDetailsModel.bookingDate,
                      status: myBookingsData.bookingDetailsModel.request,
                      phone: myBookingsData.bookingDetailsModel.phone,
                      phone2:
                          myBookingsData.bookingDetailsModel.alternateNumber,
                      occassion:
                          myBookingsData.bookingDetailsModel.bookingPurpose,
                      address: myBookingsData.bookingDetailsModel.address),
                  SizedBox(height: 50),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: MaterialButton(
                      height: kBottomNavigationBarHeight - 8,
                      minWidth: double.infinity,
                      onPressed: () async {
                        url_launcher.launchUrl(Uri.parse(
                            "tel:${myBookingsData.bookingDetailsModel.phone}"));
                      },
                      color: Colors.white,
                      child: Text(
                        "Call",
                        style: GoogleFonts.openSans(
                            fontSize: 18,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  myBookingsData.isLoading
                      ? CircularProgressIndicator(color: primaryColor)
                      : Visibility(
                          visible: myBookingsData.bookingDetailsModel.request !=
                                  "accepted"
                              ? true
                              : false,
                          child: Container(
                            margin:
                                EdgeInsets.only(left: 20, right: 20, top: 30),
                            child: MaterialButton(
                              height: kBottomNavigationBarHeight - 8,
                              minWidth: double.infinity,
                              onPressed: () async {
                                await myBookingsData
                                    .conformBooking(
                                        bookingId: myBookingsData
                                            .bookingDetailsModel.id,
                                        bookingDate: myBookingsData
                                            .bookingDetailsModel.bookingDate)
                                    .whenComplete(() {
                                  if (myBookingsData
                                          .conformBookingModel.status ==
                                      "200") {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Booking Confirmed Successfully")));
                                  }
                                });
                              },
                              color: primaryColor,
                              child: Text(
                                "Confirm",
                                style: GoogleFonts.openSans(
                                    fontSize: 18,
                                    color: Colors.white,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }),
    );
  }
}

class OrderDetails extends StatelessWidget {
  const OrderDetails({
    Key? key,
    required this.orderNumber,
    required this.phone2,
    required this.name,
    required this.phone,
    required this.address,
    required this.bookingDate,
    required this.status,
    required this.occassion,
  }) : super(key: key);

  final String orderNumber;
  final String phone2;
  final String bookingDate;
  final String name;
  final String phone;
  final String address;
  final String status;
  final String occassion;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: Ui.getBoxDecoration(color: primaryColor),
        margin: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OrderElement(title: "Order#", value: orderNumber),
            SizedBox(height: 5),
            OrderElement(title: "Name", value: name),
            SizedBox(height: 5),
            OrderElement(title: "Booking date", value: bookingDate),
            SizedBox(height: 5),
            OrderElement(title: "Occassion", value: occassion),
            SizedBox(height: 5),
            OrderElement(title: "Phone No", value: phone),
            SizedBox(height: 5),
            OrderElement(title: "Alternate No", value: phone2),
            SizedBox(height: 5),
            OrderElement(title: "Address", value: address),
            SizedBox(height: 5),
            OrderElement(title: "Status", value: status),
          ],
        ));
  }
}
