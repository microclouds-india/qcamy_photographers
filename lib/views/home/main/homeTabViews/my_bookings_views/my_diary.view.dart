// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qcamyphotographers/common/ui/Ui.dart';
// import 'package:table_calendar/table_calendar.dart';

import '../../../../../config/colors.dart';
import '../../../../../repository/diary/diary.notifier.dart';
import '../../../../../repository/my_bookings/my_bookings.notifier.dart';
import 'bookings.view.dart';

class MyDiaryView extends StatelessWidget {
  const MyDiaryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dairyData = Provider.of<DiaryNotifier>(context, listen: false);
    final myBookingsData =
        Provider.of<MyBookingsNotifier>(context, listen: false);
    return FutureBuilder(
        future: dairyData.getPhotographerDiary(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            if (dairyData.diaryModel.data.isNotEmpty) {
              return Scaffold(
                backgroundColor: Colors.white,
                body: ListView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount: dairyData.diaryModel.data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return DiaryItems(
                        orderNumber: dairyData.diaryModel.data[index].orderId,
                        bookingStatus: dairyData.diaryModel.data[index].status,
                        date: dairyData.diaryModel.data[index].date,
                        name: dairyData.diaryModel.data[index].name,
                        place: dairyData.diaryModel.data[index].bookingPlace,
                        onTap: () {
                          myBookingsData.bookingId =
                              dairyData.diaryModel.data[index].orderId;
                          Navigator.of(context)
                              .pushNamed("/bookingDetailsView");
                        },
                        bookingDate:
                            dairyData.diaryModel.data[index].bookingDate,
                        // bookingPlace:
                        //     dairyData.diaryModel.data[index].bookingPlace,
                        phone: dairyData.diaryModel.data[index].phone,
                        // phone2:
                        //     dairyData.diaryModel.data[index].alternateNumber
                      );
                    }),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/diarySearchView');
                  },
                  backgroundColor: primaryColor,
                  child: Icon(Icons.search),
                ),
              );
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
        }));
    // return TableCalendar(
    //   firstDay: DateTime.utc(2010, 10, 16),
    //   lastDay: DateTime.utc(2030, 3, 14),
    //   focusedDay: DateTime.now(),
    // );
  }
}

// IconButton(
//                       onPressed: () {
//                         Navigator.of(context).pushNamed('/diarySearchView');
//                       },
//                       icon: Icon(
//                         Icons.search,
//                         size: 35,
//                       ),
//                     ),

class DiaryItems extends StatelessWidget {
  const DiaryItems({
    Key? key,
    required this.orderNumber,
    required this.date,
    required this.onTap,
    required this.name,
    required this.phone,
    required this.bookingDate,
    required this.bookingStatus,
    required this.place,
  }) : super(key: key);

  final String orderNumber;
  final String date;
  final String name;
  final String phone;
  final String bookingDate;
  final String bookingStatus;
  final Function() onTap;
  final String place;

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
                    OrderElement(title: "Location", value: place),
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
