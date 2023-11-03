class Call {
  final String? id;
  final String caller;
  
  final String called;
  
  final String channel;
  final bool? active;
  final bool? rejected;
  final bool? connected;
  final bool? accepted;
  Call( {
    required this.id,
    required this.caller,
   
    required this.called,
   required this.rejected, required this.connected, required this.accepted,
    required this.channel,
    required this.active,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'caller': caller,
      'rejected': rejected,
      'connected': connected,
      'accepted': accepted,
      'called': called,
     
      'channel': channel,
      'hasDialled': active,
    };
  }

  factory Call.fromMap(Map<String, dynamic> map) {
    return Call(
      id: map['id'] ?? '',
      caller: map['caller'] ?? '',
      accepted: map['accepted']??'',
      connected: map['connected']??'',
      rejected: map['rejected']??'',
      
      called: map['called'] ?? '',
     
      channel: map['channel'] ?? '',
      active: map['active'] ?? false,
    );
  }
}
