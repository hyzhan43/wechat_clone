import 'package:flutter/material.dart';
import '../constants.dart' show AppColors, AppStyles, Constants;
import '../model/conversation.dart' show Conversation, mockConversations;

class _ConversationItem extends StatelessWidget {
  const _ConversationItem({Key key, this.conversation})
      : assert(conversation != null),
        super(key: key);

  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Color(AppColors.ConversationItemBg),
          border: Border(
              bottom: BorderSide(
                  color: Color(AppColors.DividerColor),
                  width: Constants.DividerWidth))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/default_nor_avatar.png',
            width: Constants.ConversationAvatarSize,
            height: Constants.ConversationAvatarSize,
          ),
          Container(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Text(
                  conversation.title,
                  style: AppStyles.TitleStyle,
                ),
                Text(conversation.des, style: AppStyles.DesStyle)
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
          Container(
            width: 10.0,
          ),
          Column(
            children: <Widget>[
              Text(
                conversation.updateAt,
                style: AppStyles.DesStyle,
              )
            ],
          )
        ],
      ),
    );
  }
}

class ConversationPage extends StatefulWidget {
  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return _ConversationItem(
          conversation: mockConversations[index],
        );
      },
      itemCount: mockConversations.length,
    );
  }
}
