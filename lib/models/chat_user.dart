class ChatUser {
  ChatUser({
    required this.image,
    required this.name,
    required this.createdAt,
    required this.lastActive,
    required this.isOnline,
    required this.abaut,
    required this.id,
    required this.pushToken,
    required this.email,
  });
  late final String image;
  late final String name;
  late final String createdAt;
  late final String lastActive;
  late final bool isOnline;
  late final String abaut;
  late final String id;
  late final String pushToken;
  late final String email;
  
  ChatUser.fromJson(Map<String, dynamic> json){
    image = json['image']??'';
    name = json['name']??'';
    createdAt = json['created_at']??'';
    lastActive = json['last_active']??'';
    isOnline = json['is_online']??'';
    abaut = json['abaut']??'';
    id = json['id']??'';
    pushToken = json['push_token']??'';
    email = json['email']??'';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['last_active'] = lastActive;
    data['is_online'] = isOnline;
    data['abaut'] = abaut;
    data['id'] = id;
    data['push_token'] = pushToken;
    data['email'] = email;
    return data;
  }
}
  
