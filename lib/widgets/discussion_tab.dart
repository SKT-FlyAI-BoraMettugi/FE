import 'package:flutter/material.dart';

class Comment {
  String id;
  String userId;
  String userName;
  String userProfileImage;
  String content;
  List<Comment> replies;

  Comment({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userProfileImage,
    required this.content,
    this.replies = const [],
  });
}

class DiscussionTab extends StatefulWidget {
  const DiscussionTab({super.key});

  @override
  State<DiscussionTab> createState() => _DiscusstionTabState();
}

class _DiscusstionTabState extends State<DiscussionTab> {
  List<Comment> comments = [];

  void addComment({required Comment c}) {
    setState(() {
      comments.add(c);
    });
  }

  void addReply({required Comment re, required Comment parentComment}) {
    setState(() {
      parentComment.replies = List.from(parentComment.replies)..add(re);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return buildComment(comment: comments[index], index: index);
              },
            ),
          ),
          buildCommentInput(),
        ],
      ),
    );
  }

  Widget buildComment(
      {required Comment comment, required int index, int level = 0}) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0 * level), // 들여쓰기 적용
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(comment.userProfileImage),
            ),
            title: Text("$index-$level"),
            subtitle: Text(comment.content),
            trailing: TextButton(
              onPressed: () {
                _showReplyDialog(comment);
              },
              child: Text('답글'),
            ),
          ),
          Column(
            children: comment.replies.map((reply) {
              return buildComment(
                comment: reply,
                index: index,
                level: level + 1,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget buildCommentInput() {
    TextEditingController comment = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: comment,
              decoration: InputDecoration(
                hintText: '댓글을 입력하세요...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              if (comment.text.isNotEmpty) {
                addComment(
                  c: Comment(
                    content: comment.text,
                    id: "user",
                    userId: "user",
                    userName: "user",
                    userProfileImage: 'assets/main/rabbit.png',
                    replies: [],
                  ),
                );
                comment.clear();
              }
            },
          ),
        ],
      ),
    );
  }

  void _showReplyDialog(Comment parentComment) {
    TextEditingController reply = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('답글 달기'),
          content: TextField(
            controller: reply,
            decoration: InputDecoration(hintText: '답글을 입력하세요...'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                if (reply.text.isNotEmpty) {
                  addReply(
                      re: Comment(
                          id: "user",
                          userId: "user",
                          userName: "user",
                          userProfileImage: 'assets/main/rabbit.png',
                          content: reply.text),
                      parentComment: parentComment);
                  Navigator.pop(context);
                }
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }
}
