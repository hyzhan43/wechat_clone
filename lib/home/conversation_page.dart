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
    Widget avatar;
    if (conversation.isAvatarFromNet()) {
      avatar = Image.network(
        conversation.avatar,
        width: Constants.ConversationAvatarSize,
        height: Constants.ConversationAvatarSize,
      );
    } else {
      avatar = Image.asset(
        conversation.avatar,
        width: Constants.ConversationAvatarSize,
        height: Constants.ConversationAvatarSize,
      );
    }

    Widget avatarContainer;
    if (conversation.unreadMsgCount > 0) {
      // 未读消息角标
      Widget unreadMsgCountText = Container(
        width: Constants.UnReadMsgNotifyDotSize,
        height: Constants.UnReadMsgNotifyDotSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(Constants.UnReadMsgNotifyDotSize / 2),
            color: Color(AppColors.NotifyDotBg)),
        child: Text(
          '99',
          style: AppStyles.UnreadMsgCountDotStyle,
        ),
      );

      avatarContainer = Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          avatar,
          Positioned(top: -6.0, right: -6.0, child: unreadMsgCountText)
        ],
      );
    } else {
      avatarContainer = avatar;
    }

    // 勿扰模式
    Widget muteIcon = Icon(
      IconData(0xe755, fontFamily: Constants.IconFontFamily),
      color: Color(AppColors.ConversationMuteIcon),
      size: Constants.ConversationMuteIconSize,
    );

    var _rightArea = <Widget>[
      Text(conversation.updateAt, style: AppStyles.DesStyle),
      Container(height: 10.0,)
    ];

    if (conversation.isMute) {
      _rightArea.add(muteIcon);
    } else {
      _rightArea.add(Icon(
        IconData(0xe755, fontFamily: Constants.IconFontFamily),
        color: Colors.transparent,
        size: Constants.ConversationMuteIconSize,
      ));
    }

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
          avatarContainer,
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
            children: _rightArea,
          ),
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
