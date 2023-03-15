import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qcamyphotographers/config/colors.dart';

class PhotographersList extends StatelessWidget {
  final String name;
  final Function()? onTap;
  final String? image;
  const PhotographersList({
    Key? key,
    required this.name,
    this.onTap,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      margin: const EdgeInsets.only(left: 10, right: 10, top: 8),
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey,
                  child: CachedNetworkImage(
                    imageBuilder: (context, imageProvider) => Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    imageUrl: image ??
                        "https://cdn.vectorstock.com/i/preview-1x/66/14/default-avatar-photo-placeholder-profile-picture-vector-21806614.jpg",
                    placeholder: (context, url) {
                      return Image.network(
                          "https://cdn.vectorstock.com/i/preview-1x/66/14/default-avatar-photo-placeholder-profile-picture-vector-21806614.jpg");
                    },
                    errorWidget: (context, url, error) {
                      return Image.network(
                          "https://cdn.vectorstock.com/i/preview-1x/66/14/default-avatar-photo-placeholder-profile-picture-vector-21806614.jpg");
                    },
                  )),
              // NetworkImage(
              //     image ??
              //         "https://cdn.vectorstock.com/i/preview-1x/66/14/default-avatar-photo-placeholder-profile-picture-vector-21806614.jpg",
              //   ),
              const SizedBox(width: 15),
              Text(
                name,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
            ],
          ),
          MaterialButton(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: primaryColor, width: 2)),
            onPressed: onTap,
            child: const Text(
              "View",
              style: TextStyle(letterSpacing: 2),
            ),
          ),
        ],
      ),
    );
  }
}
