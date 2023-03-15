// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyphotographers/common/ui/Ui.dart';
import 'package:qcamyphotographers/config/colors.dart';
import 'package:qcamyphotographers/repository/my_bookings/my_bookings.notifier.dart';

class BookingsView extends StatelessWidget {
  const BookingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myBookingsData =
        Provider.of<MyBookingsNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: myBookingsData.getMyBookings(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: myBookingsData.bookingsModel.data.length,
                  itemBuilder: (context, index) {
                    return OrderItem(
                      orderNumber:
                          myBookingsData.bookingsModel.data[index].orderId,
                      date: myBookingsData.bookingsModel.data[index].date,
                      bookingDate:
                          myBookingsData.bookingsModel.data[index].bookingDate,
                      name: myBookingsData.bookingsModel.data[index].name,
                      phone: myBookingsData.bookingsModel.data[index].phone,
                      bookingStatus:
                          myBookingsData.bookingsModel.data[index].status,
                      occassion: myBookingsData
                          .bookingsModel.data[index].bookingPurpose,
                      onTap: () {
                        myBookingsData.bookingId =
                            myBookingsData.bookingsModel.data[index].orderId;
                        Navigator.of(context).pushNamed("/bookingDetailsView");
                      },
                    );
                  });
            }
            return Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }),
    );
  }
}

//show orderd items list
class OrderItem extends StatelessWidget {
  const OrderItem({
    Key? key,
    required this.orderNumber,
    required this.date,
    required this.onTap,
    required this.name,
    required this.phone,
    required this.bookingDate,
    required this.bookingStatus,
    required this.occassion,
  }) : super(key: key);

  final String orderNumber;
  final String date;
  final String name;
  final String phone;
  final String bookingDate;
  final String bookingStatus;
  final Function() onTap;
  final String occassion;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: Ui.getBoxDecoration(color: primaryColor),
          margin: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OrderElement(title: "Order#", value: orderNumber),
                    SizedBox(height: 5),
                    OrderElement(title: "Date", value: date),
                    SizedBox(height: 5),
                    OrderElement(title: "Name", value: name),
                    SizedBox(height: 5),
                    OrderElement(title: "Booking date", value: bookingDate),
                    SizedBox(height: 5),
                    OrderElement(title: "Occassion", value: occassion),
                    SizedBox(height: 5),
                    OrderElement(title: "Phone no", value: phone),
                    SizedBox(height: 5),
                    Divider(color: Colors.grey),
                    OrderElement(title: "Status", value: bookingStatus),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 15),
            ],
          )),
    );
  }
}

class OrderElement extends StatelessWidget {
  const OrderElement({
    Key? key,
    required this.value,
    required this.title,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              title,
              style: GoogleFonts.quicksand(
                  fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Text(" : "),
        Expanded(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              value,
              style: GoogleFonts.quicksand(
                  fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}
