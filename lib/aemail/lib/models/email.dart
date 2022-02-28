// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:core/ui/util/lorem_ipsum/lorem_ipsum.dart';

class Email {
  final String? image, name, subject, body, time;
  final bool? isAttachmentAvailable, isChecked;
  final Color? tagColor;

  Email({
    this.time,
    this.isChecked,
    this.image,
    this.name,
    this.subject,
    this.body,
    this.isAttachmentAvailable,
    this.tagColor,
  });
}

List<Email> emails = List.generate(
  demo_data.length,
  (index) => Email(
    name: demo_data[index]['name'],
    image: demo_data[index]['image'],
    subject: demo_data[index]['subject'],
    isAttachmentAvailable: demo_data[index]['isAttachmentAvailable'],
    isChecked: demo_data[index]['isChecked'],
    tagColor: demo_data[index]['tagColor'],
    time: demo_data[index]['time'],
    body: emailDemoText,
  ),
);

List demo_data = [
  {
    "name": "Sam",
    "image": "packages/aemail/assets/images/user_1.png",
    "subject": loremIpsum(words: 3),
    "isAttachmentAvailable": false,
    "isChecked": true,
    "tagColor": null,
    "time": "15:11"
  },
  {
    "name": "Prince",
    "image": "packages/aemail/assets/images/user_2.png",
    "subject": loremIpsum(words: 3),
    "isAttachmentAvailable": true,
    "isChecked": false,
    "tagColor": null,
    "time": "15:32"
  },
  {
    "name": "Akshay",
    "image": "packages/aemail/assets/images/user_3.png",
    "subject": loremIpsum(words: 3),
    "isAttachmentAvailable": true,
    "isChecked": false,
    "tagColor": null,
    "time": "14:27",
  },
  {
    "name": "Seb",
    "image": "packages/aemail/assets/images/user_4.png",
    "subject": loremIpsum(words: 3),
    "isAttachmentAvailable": false,
    "isChecked": true,
    "tagColor": Color(0xFF23CF91),
    "time": "10:43"
  },
  {
    "name": "redDwarf",
    "image": "packages/aemail/assets/images/user_5.jpeg",
    "subject": loremIpsum(words: 4),
    "isAttachmentAvailable": false,
    "isChecked": false,
    "tagColor": Color(0xFF3A6FF7),
    "time": "9:58"
  }
];

String emailDemoText = loremIpsum(words: 300, paragraphs: 3);
