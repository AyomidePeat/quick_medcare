// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:quick_medcare/models/call_model.dart';
// import 'package:quick_medcare/models/patient_model.dart';
// import 'package:quick_medcare/utils/user_photo.dart';
// import 'package:quick_medcare/utils/utils.dart';

// const token =
//     '+X1avPpjqx3be9tpOj2Vv16srMFgkmRgZpBonWiaZGZkkGScmplkYWpgZpZqYGSaZGBomp7ZdS2kIZGTY8FudmZEBAkF8Xobi1OT8vJTkjMS8vNQcBgYAXhIjIQ==';
// const appId = '8b420e3a9b624b3aaf81862e461b411c';

// class VideoCallScreen extends StatefulWidget {
//   final PatientDetailsModel patient;
//   final Call call;

//   const VideoCallScreen({super.key, required this.patient, required this.call});

//   @override
//   State<VideoCallScreen> createState() => _VideoCallScreenState();
// }

// class _VideoCallScreenState extends State<VideoCallScreen> {
//   RtcEngine? rtcEngine;
//   String? token;
//   int uid = 0;
//   bool localUserJoined = false;
//   String? callID;
//   int? remoteUid;
//   @override
//   void initState() {
//     setState(() {
//       callID = widget.call.id;
//       rtcEngine = createAgoraRtcEngine();
//     });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     rtcEngine!.release();
//     rtcEngine!.leaveChannel();
//     super.dispose();
//   }

//   Future<void> initializeCall() async {
//     await [Permission.microphone, Permission.camera].request();
//     await rtcEngine?.initialize(const RtcEngineContext(appId: appId));
//     await rtcEngine?.enableVideo();
//     rtcEngine?.registerEventHandler(
//         RtcEngineEventHandler(onJoinChannelSuccess: (connection, elapsed) {
//       setState(() {
//         localUserJoined = true;
//       });
//       if (widget.call.id == null) {
//         makeCall();
//       }
//     }, onUserJoined: (connection, _remoteUid, elasped) {
//       setState(() {
//         remoteUid = _remoteUid;
//       });
//     }, onLeaveChannel: (connection, stats) {
//       callsCollection.doc(widget.call.id).update({'active': false});
//       Navigator.pop(context);
//     }, onUserOffline: ((connection, _remoteUid, reason) {
//       setState(() {
//         remoteUid = null;
//       });
//       rtcEngine?.leaveChannel();
//       rtcEngine?.release();
//       Navigator.pop(context);
//       callsCollection.doc(widget.call.id).update({'active': false});
//     })));
//     await joinVideoChannel();
//   }

//   makeCall() async {
//     DocumentReference callDocRef = callsCollection.doc();
//     setState(() {
//       callID = callDocRef.id;
//     });
//     await callDocRef.set({
//       'id': callDocRef.id,
//       'caller': widget.call.caller,
//       'called': widget.call.called,
//       'active': true,
//       'accepted': false,
//       'rejected': false,
//       'connected': false,
//     });
//   }

//   Future joinVideoChannel() async {
//     await rtcEngine?.startPreview();
//     ChannelMediaOptions options = const ChannelMediaOptions(
//         clientRoleType: ClientRoleType.clientRoleBroadcaster,
//         channelProfile: ChannelProfileType.channelProfileCommunication);
//     await rtcEngine?.joinChannel(
//         token: token!,
//         channelId: widget.call.channel,
//         uid: uid,
//         options: options);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           backgroundColor: Colors.white,
//           appBar: AppBar(
//               elevation: 0,
//               centerTitle: true,
//               title: Text(
//                 widget.patient.firstName,
//                 style: TextStyle(color: Colors.black),
//               )),
//           body: localUserJoined == false || callID == null
//               ? const Center(child: CircularProgressIndicator())
//               : StreamBuilder<DocumentSnapshot>(
//                   stream: callsCollection.doc(callID!).snapshots(),
//                   builder: ((context, snapshot) {
//                     if (snapshot.hasData) {
//                       Call call = Call(
//                           id: snapshot.data!['id'],
//                           caller: snapshot.data!['caller'],
//                           called: snapshot.data!['called'],
//                           rejected: snapshot.data!['rejected'],
//                           connected: snapshot.data!['connected'],
//                           accepted: snapshot.data!['accepted'],
//                           channel: snapshot.data!['channel'],
//                           active: snapshot.data!['active']);
//                       return call.rejected == true
//                           ? Text("Call Declined")
//                           : Stack(
//                               children: [
//                                 Center(child: remoteVideo(call: call)),
//                                 if (rtcEngine != null)
//                                   Positioned.fill(
//                                     child: Align(
//                                       alignment: Alignment.topLeft,
//                                       child: SizedBox(
//                                         height: 150,
//                                         width: 100,
//                                         child: AgoraVideoView(
//                                             controller: VideoViewController(
//                                                 rtcEngine: rtcEngine!,
//                                                 canvas: VideoCanvas(uid: uid))),
//                                       ),
//                                     ),
//                                   ),
//                                 Positioned.fill(
//                                   child: Align(
//                                       alignment: Alignment.topLeft,
//                                       child: Padding(
//                                           padding: EdgeInsets.only(bottom: 40),
//                                           child: FloatingActionButton(
//                                             onPressed: () {
//                                               rtcEngine?.leaveChannel();
//                                             },
//                                           ))),
//                                 ),
//                               ],
//                             );
//                     }
//                     return SizedBox.shrink();
//                   }))),
//     );
//   }

//   Widget remoteVideo({required Call call}) {
//     return Stack(
//       children: [
//         if (remoteUid != null)
//           AgoraVideoView(
//             controller: VideoViewController.remote(
//               rtcEngine: rtcEngine!,
//               canvas: VideoCanvas(
//                 uid: remoteUid,
//               ),
//               connection: RtcConnection(channelId: call.channel),
//             ),
//           ),
//         if (remoteUid == null)
//           Positioned.fill(
//               child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               userPhoto(radius: 50, url: widget.patient.firstName),
//               Padding(
//                 padding: EdgeInsets.all(20),
//                 child: Text(call.connected == false
//                     ? "Connecting to ${widget.patient.firstName}"
//                     : "Waiting Respnse"),
//               )
//             ],
//           ))
//       ],
//     );
//   }
// }
