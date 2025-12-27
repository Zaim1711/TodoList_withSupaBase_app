import 'package:flutter/material.dart';

Widget buildMenuCard({
  required Color color,
  required IconData icon,
  required Color iconColor,
  required String title,
  required String count,
}) {
  return Container(
    width: 160,
    height: 100,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Stack(
      children: [
        // ICON KIRI ATAS
        Align(
          alignment: Alignment.topLeft,
          child: Icon(icon, color: iconColor, size: 28),
        ),

        // TEXT KIRI BAWAH
        Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                count,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  // return Container(
  //   decoration: BoxDecoration(
  //     color: color,
  //     borderRadius: BorderRadius.circular(12),
  //   ),
  //   child: Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Icon(icon, size: 26, color: Colors.white),
  //       SizedBox(width: 12),
  //       Column(
  //         mainAxisAlignment: MainAxisAlignment.end,
  //         children: [
  //           Row(
  //             children: [
  //               SizedBox(width: 8),
  //               Text(
  //                 count,
  //                 style: TextStyle(
  //                   color: Color(0xff393433),
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //               SizedBox(width: 8),
  //               Text(
  //                 title,
  //                 style: TextStyle(color: Color(0xff393433), fontSize: 16),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ],
  //   ),
  // );
}
