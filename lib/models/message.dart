enum MessageType {
  text,
  image,
  file,
  assignment,
}

class Message {
  final String id;
  final String senderId;
  final String receiverId;
  final String? classId;
  final MessageType type;
  final String content;
  final String? attachmentUrl;
  final bool isRead;
  final DateTime sentAt;
  final DateTime? readAt;

  const Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    this.classId,
    required this.type,
    required this.content,
    this.attachmentUrl,
    required this.isRead,
    required this.sentAt,
    this.readAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as String,
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      classId: json['classId'] as String?,
      type: MessageType.values.firstWhere(
        (type) => type.name == json['type'],
        orElse: () => MessageType.text,
      ),
      content: json['content'] as String,
      attachmentUrl: json['attachmentUrl'] as String?,
      isRead: json['isRead'] as bool,
      sentAt: DateTime.parse(json['sentAt'] as String),
      readAt: json['readAt'] != null
          ? DateTime.parse(json['readAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'classId': classId,
      'type': type.name,
      'content': content,
      'attachmentUrl': attachmentUrl,
      'isRead': isRead,
      'sentAt': sentAt.toIso8601String(),
      'readAt': readAt?.toIso8601String(),
    };
  }

  Message copyWith({
    String? id,
    String? senderId,
    String? receiverId,
    String? classId,
    MessageType? type,
    String? content,
    String? attachmentUrl,
    bool? isRead,
    DateTime? sentAt,
    DateTime? readAt,
  }) {
    return Message(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      classId: classId ?? this.classId,
      type: type ?? this.type,
      content: content ?? this.content,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
      isRead: isRead ?? this.isRead,
      sentAt: sentAt ?? this.sentAt,
      readAt: readAt ?? this.readAt,
    );
  }
}