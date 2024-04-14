import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/widgets/appbar.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  void _launchEmail(String email) async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Example Subject & Symbols are allowed!',
      }),
    );
    if (await canLaunchUrl(_emailLaunchUri)) {
      await launchUrl(_emailLaunchUri);
    } else {
      throw 'Could not launch $email';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappBar(title: 'Contact',),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Contact Us!', style: TextStyle(
              fontSize: 18,
                fontWeight:   FontWeight.w500,
                color: Color.fromARGB(255, 42, 42, 42)
            ),),
            SizedBox(
              height: 5.h,
            ),
            Text('Reach out to us. We love to hear from you', style: TextStyle(
                fontSize: 14,
                fontWeight:   FontWeight.w300,
                color: Color.fromARGB(255, 42, 42, 42)
            ),),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 410.h,
              width: 361.w,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.phone, color: Colors.green[400], size: 20,),
                      SizedBox(width: 10.w,),
                      Text('07002255438', style: TextStyle(
                          fontSize: 14,
                          fontWeight:   FontWeight.w400,
                          color: Color.fromARGB(255, 42, 42, 42)
                      ),),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 1,
                    width: 360.w,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Icon(Icons.mail_outline_outlined, color: Colors.black, size: 25,),
                      SizedBox(width: 10.w,),
                      GestureDetector(
                        onTap: () => _launchEmail('contact@posterbox.com.ng'),
                        child: Text('contact@posterbox.com.ng',style: TextStyle(
                            fontSize: 14,
                            fontWeight:   FontWeight.w400,
                            color: Colors.blue, // Change text color to blue for link
                          decoration: TextDecoration.underline,
                        ),),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 1,
                    width: 360.w,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () async {
                      const twitterUrl = 'https://twitter.com/myposterboxapp';
                      if (await canLaunch(twitterUrl)) {
                        await launch(twitterUrl);
                      } else {
                        throw 'Could not launch $twitterUrl';
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                height: 20,
                                child: Image.asset('assets/twitter.jpg')),
                            SizedBox(width: 10.w,),
                            Text('Twitter',style: TextStyle(
                                fontSize: 14,
                                fontWeight:   FontWeight.w400,
                                color: Color.fromARGB(255, 42, 42, 42)
                            ),),
                          ],
                        ),
                        Icon(Icons.chevron_right, size: 25,)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 1,
                    width: 360.w,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              height: 20,
                              child: Image.asset('assets/instagram.png')),
                          SizedBox(width: 10.w,),
                          Text('Instagram',style: TextStyle(
                              fontSize: 14,
                              fontWeight:   FontWeight.w400,
                              color: Color.fromARGB(255, 42, 42, 42)
                          ),),
                        ],
                      ),
                      Icon(Icons.chevron_right, size: 25,)
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 1,
                    width: 360.w,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              height: 20,
                              child: Image.asset('assets/facebook.png')),
                          SizedBox(width: 10.w,),
                          Text('Facebook',style: TextStyle(
                              fontSize: 14,
                              fontWeight:   FontWeight.w400,
                              color: Color.fromARGB(255, 42, 42, 42)
                          ),),
                        ],
                      ),
                      Icon(Icons.chevron_right, size: 25,)
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 1,
                    width: 360.w,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              height: 20,
                              child: Image.asset('assets/linkedin.png')),
                          SizedBox(width: 10.w,),
                          Text('LinkedIn', style: TextStyle(
                              fontSize: 14,
                              fontWeight:   FontWeight.w400,
                              color: Color.fromARGB(255, 42, 42, 42)
                          ),),
                        ],
                      ),
                      Icon(Icons.chevron_right, size: 25,)
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 1,
                    width: 360.w,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
