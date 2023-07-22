import 'package:admin_panel/constants/colors.dart';
import 'package:admin_panel/provider/app_provider.dart';
import 'package:admin_panel/screens/chat_screen/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user_model/user_model.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('User View'),
        ),
        body: Consumer<AppProvider>(builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.userList.length,
            itemBuilder: (context, index) {
              UserModel userModel = value.userList[index];
              return InkWell(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context)=>ChatScreen(uid: userModel.id,)));
                },
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                        children: [
                      userModel.image != null
                          ? Image.network(
                              userModel.image!,
                            )
                          : const CircleAvatar(
                              backgroundColor: kPrimaryGreen,
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userModel.name,
                            style: const TextStyle(),
                          ),
                          Text(
                            userModel.phone,
                            style: const TextStyle(),
                          ),

                        ],

                      ),
                      const Spacer(),
                      value.getIsDeletingLoading
                          ? const CircularProgressIndicator()
                          : CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                value.deleteUser(userModel);
                              },
                            child: IconButton(
                            onPressed: () {
                              value.deleteUser(userModel);
                            },
                            icon: const Icon(Icons.delete, color: Colors.red)),
                          ),
                          // SizedBox(width: 6.0),
                          // GestureDetector(
                          //   // padding: EdgeInsets.zero,
                          //   onTap: () {
                          //     value.deleteUser(userModel);
                          //   },
                          //   child: IconButton(
                          //       onPressed: () {
                          //         value.deleteUser(userModel);
                          //       },
                          //       icon: Icon(Icons.edit)),
                          // ),
                    ]),
                  ),
                ),
              );
            },
          );
        }));
  }
}
