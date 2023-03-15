// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyphotographers/common/ui/Ui.dart';
import 'package:qcamyphotographers/config/colors.dart';
import 'package:qcamyphotographers/repository/my_bookings/my_bookings.notifier.dart';
import 'package:qcamyphotographers/repository/past_bookings/past_bookings.notifier.dart';
import 'package:qcamyphotographers/views/home/main/homeTabViews/my_bookings_views/bookings.view.dart';

class PastBookingsView extends StatelessWidget {
  const PastBookingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pastBookingsData =
        Provider.of<PastBookingsNotifier>(context, listen: false);
    final myBookingsData =
        Provider.of<MyBookingsNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 1,
        title: Text(
          "Past Bookings",
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/searchBookingsView");
            },
            icon: Icon(
              Icons.filter_alt_outlined,
              size: 30,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
          future: pastBookingsData.getPastBookings(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (pastBookingsData.pastBookingsModel.data.isNotEmpty) {
                return ListView.builder(
                    itemCount: pastBookingsData.pastBookingsModel.data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          myBookingsData.bookingId = pastBookingsData
                              .pastBookingsModel.data[index].orderId;
                          Navigator.of(context)
                              .pushNamed("/pastBookingDetailsView");
                        },
                        child: OrderDetails(
                            orderNumber: pastBookingsData
                                .pastBookingsModel.data[index].orderId,
                            status: pastBookingsData
                                .pastBookingsModel.data[index].status,
                            date: pastBookingsData
                                .pastBookingsModel.data[index].date,
                            name: pastBookingsData
                                .pastBookingsModel.data[index].name,
                            bookingDate: pastBookingsData
                                .pastBookingsModel.data[index].bookingDate,
                            bookingPlace: pastBookingsData
                                .pastBookingsModel.data[index].bookingPlace,
                            occassion: pastBookingsData
                                .pastBookingsModel.data[index].bookingPurpose,
                            phone: pastBookingsData
                                .pastBookingsModel.data[index].phone,
                            phone2: pastBookingsData
                                .pastBookingsModel.data[index].alternateNumber),
                      );
                    });
              } else {
                return Center(
                  child: Text("No past bookings"),
                );
              }
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Something went wrong"),
              );
            }
            return Center(
                child: CircularProgressIndicator(
              color: primaryColor,
            ));
          }),
    );
  }
}

class OrderDetails extends StatelessWidget {
  const OrderDetails({
    Key? key,
    required this.orderNumber,
    required this.date,
    required this.name,
    required this.phone,
    required this.phone2,
    required this.bookingDate,
    required this.status,
    required this.bookingPlace,
    required this.occassion,
  }) : super(key: key);

  final String orderNumber;
  final String date;
  final String bookingDate;
  final String name;
  final String phone;
  final String phone2;
  final String status;
  final String bookingPlace;
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
            OrderElement(title: "Date", value: date),
            SizedBox(height: 5),
            OrderElement(title: "Name", value: name),
            SizedBox(height: 5),
            OrderElement(title: "Booking date", value: bookingDate),
            SizedBox(height: 5),
            OrderElement(title: "Booking place", value: bookingPlace),
            SizedBox(height: 5),
            OrderElement(title: "Occassion", value: occassion),
            SizedBox(height: 5),
            OrderElement(title: "Phone No", value: phone),
            SizedBox(height: 5),
            OrderElement(title: "Alternate No", value: phone2),
            SizedBox(height: 5),
            Divider(color: Colors.grey),
            OrderElement(title: "Status", value: status),
          ],
        ));
  }
}
