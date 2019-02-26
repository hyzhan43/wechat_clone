import 'package:flutter/material.dart';
import '../constants.dart' show AppColors, AppStyles, Constants;
import '../model/conversation.dart'
    show Conversation, Device, ConversationPageData;

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
      Container(
        height: 10.0,
      )
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

class _DeviceInfoItem extends StatelessWidget {
  const _DeviceInfoItem({this.device: Device.WIN}) : assert(device != null);

  final Device device;

  int get iconName {
    return device == Device.WIN ? 0xe75e : 0xe640;
  }

  String get deviceName {
    return device == Device.WIN ? 'Windows' : 'Mac';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: Constants.DividerWidth,
                  color: Color(AppColors.DividerColor))),
          color: Color(AppColors.DeviceInfoItemBg)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            IconData(this.iconName, fontFamily: Constants.IconFontFamily),
            size: 24.0,
            color: Color(AppColors.DeviceInfoItemIcon),
          ),
          SizedBox(
            width: 16.0,
          ),
          Text(
            '$deviceName 微信已登录, 手机通知已关闭',
            style: AppStyles.DeviceInfoItemTextStyle,
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
  final ConversationPageData data = ConversationPageData.mock();

  @override
  Widget build(BuildContext context) {
    var mockConversations = data.conversations;

    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        if (data.device != null) {
          // 需要显示其他设备登录信息
          if (index == 0) {
            return _DeviceInfoItem(device: data.device);
          }

          return _ConversationItem(conversation: mockConversations[index - 1]);
        } else {
          return _ConversationItem(conversation: mockConversations[index]);
        }
      },
      itemCount: data.device != null ? mockConversations.length + 1 : mockConversations.length,
    );
  }
}
