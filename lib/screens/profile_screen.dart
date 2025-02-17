import 'package:bmp_music/features/auth/services/apple_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:bmp_music/utils/color_utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton.filledTonal(
            onPressed: () {},
            icon: const Icon(Icons.create_rounded),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildProfile(),
          // _audioItems(items),
          _otherSettings(),
        ],
      ),
    );
  }

  // Widget _audioItems(List<Item> items) {
  //   return Padding(
  //     padding: const EdgeInsets.only(
  //       top: 16.0,
  //     ),
  //     child: SizedBox(
  //       height: MediaQuery.of(context).size.height * 0.3,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           const Padding(
  //             padding: EdgeInsets.only(left: 8.0),
  //             child: Text(
  //               "を聞いて",
  //               style: TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 16,
  //               ),
  //             ),
  //           ),
  //           Expanded(
  //             child: ListView.builder(
  //               scrollDirection: Axis.horizontal,
  //               physics: const BouncingScrollPhysics(),
  //               itemCount: items.length,
  //               itemBuilder: (context, index) {
  //                 return Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: SizedBox(
  //                     width: MediaQuery.of(context).size.width * 0.6,
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                       children: [
  //                         ClipRRect(
  //                           borderRadius: BorderRadius.circular(8.0),
  //                           child: SizedBox(
  //                             height: MediaQuery.of(context).size.width * 0.4,
  //                             child: Image.asset(
  //                               items[index].image,
  //                               fit: BoxFit.cover,
  //                             ),
  //                           ),
  //                         ),
  //                         Text(items[index].title),
  //                         Text(
  //                           items[index].artist,
  //                           style: TextStyle(
  //                             fontWeight: FontWeight.bold,
  //                             color: ColorUtils.lightRed,
  //                             fontSize: 16,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 );
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _otherSettings() {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: ColorUtils.lightGrey,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(
              Icons.share_rounded,
              color: ColorUtils.lightRed,
            ),
            title: const Text(
              "接続されたサービス",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: ColorUtils.darkGrey,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.info_outline_rounded,
              color: ColorUtils.lightRed,
            ),
            title: const Text(
              "について",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: ColorUtils.darkGrey,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.question_mark_rounded,
              color: ColorUtils.lightRed,
            ),
            title: const Text(
              "ヘルプ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: ColorUtils.darkGrey,
            ),
          ),
          ListTile(
            onTap: () async {
              await AppleAuthServices.signOut();
            },
            leading: Icon(
              Icons.logout_rounded,
              color: ColorUtils.lightRed,
            ),
            title: const Text(
              "ログアウト",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfile() {
    User? user = FirebaseAuth.instance.currentUser;

    String photo = user?.photoURL ?? "";
    String name = user?.displayName ?? "";
    String email = user?.email ?? "";

    return Expanded(
      child: Container(
        color: ColorUtils.lightGrey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 75,
                    backgroundImage: photo.isEmpty ? null : NetworkImage(photo),
                    child:
                        photo.isEmpty ? const Icon(Icons.person_rounded) : null,
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        Icons.verified_rounded,
                        color: ColorUtils.lightRed,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                email,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ColorUtils.lightBlack,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
