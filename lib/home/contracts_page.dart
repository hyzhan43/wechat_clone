import 'package:flutter/material.dart';
import 'package:flutter_wechat/constants.dart';
import 'package:flutter_wechat/model/contacts.dart';

class _ContactItem extends StatelessWidget {
  _ContactItem({
    @required this.avatar,
    @required this.title,
    this.groupTitle,
  });

  final String avatar;
  final String title;
  final String groupTitle;

  @override
  Widget build(BuildContext context) {
    Widget _avatarIcon = Image.network(
      avatar,
      width: Constants.ContactAvatarSize,
      height: Constants.ContactAvatarSize,
    );

    return Container(
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        child: Container(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(
              width: Constants.DividerWidth,
              color: Color(AppColors.DividerColor),
            ),
          )),
          child: Row(
            children: <Widget>[_avatarIcon, SizedBox(width: 10.0), Text(title)],
          ),
        ));
  }
}

class ContractsPage extends StatefulWidget {
  @override
  _ContractsPageState createState() => _ContractsPageState();
}

class _ContractsPageState extends State<ContractsPage> {
  final List<Contact> _contacts = ContactsPageData.mock().contacts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        Contact _contact = _contacts[index];
        return _ContactItem(avatar: _contact.avatar, title: _contact.name);
      },
      itemCount: _contacts.length,
    );
  }
}
