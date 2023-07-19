// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:quick_medcare/firebase_reposisitories/cloud_firestore.dart';
// import 'package:quick_medcare/utils/colors.dart';
// import 'package:quick_medcare/widgets/chat_list.dart';
// import 'package:quick_medcare/widgets/chat_textfield.dart';
// import 'package:uuid/uuid.dart';

// import '../utils/textstyle.dart';

// class ChatScreen extends ConsumerStatefulWidget {
//   const ChatScreen({super.key});

//   @override
//   ConsumerState<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends ConsumerState<ChatScreen> {
//   final TextEditingController chatController = TextEditingController();
//   @override
//   void dispose() {
//     chatController.dispose();
//     super.dispose();
//   }
// String generateRecipientId() {
//   var uuid = const Uuid();
//   return uuid.v4(); 
// }
//   bool isTyping = false;
//   @override
//   void initState() {
//     super.initState();
//     chatController.addListener(onTextChanged);
//   }

//   void onTextChanged() {
//     setState(() {
//       isTyping = chatController.text.trim().isNotEmpty;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cloudStoreProviderRef = ref.watch(cloudStoreProvider);
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         centerTitle: true,
//         title: Row(
//           children: [
//             const CircleAvatar(
//                 backgroundImage: AssetImage(
//               'images/heritage.jpg',
//             )),
//             const SizedBox(width: 10),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Dr. Heritage', style: headLine3(black)),
//                 Text(
//                   'Online',
//                   style: bodyText2(black),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15), color: grey),
//               child: const Text('Today'),
//             ),
//             const SizedBox(height: 15),
//             const ChatList(),
//             const Divider(
//               thickness: 5,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ChatTextField(
//                   controller: chatController,
//                 ),
//                 isTyping
//                     ? IconButton(
//                         onPressed: () {
//                           cloudStoreProviderRef.sendMessage(
//                               chatController.text, 'doctor');
//                           chatController.clear();
//                         },
//                         icon: const Icon(Icons.send))
//                     : const Row(
//                         children: [
//                           Icon(Icons.emoji_emotions_outlined),
//                           Icon(Icons.mic_none_rounded),
//                           Icon(Icons.camera_alt_outlined),
//                         ],
//                       )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
