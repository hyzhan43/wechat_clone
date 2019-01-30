import 'package:flutter/material.dart';
import 'package:flutter_wechat/constants.dart';

class NavigationIconView {
  final String _title;
  final IconData _icon;
  final IconData _activeIcon;
  final BottomNavigationBarItem item;

  NavigationIconView(
      {Key key, String title, IconData icon, IconData activeIcon})
      : _title = title,
        _icon = icon,
        _activeIcon = activeIcon,
        item = new BottomNavigationBarItem(
            icon: Icon(
              icon,
              color: Color(AppColors.TabIconNormal),
            ),
            title: Text(
              title,
              style: TextStyle(
                  fontSize: 14.0, color: Color(AppColors.TabIconNormal)),
            ),
            backgroundColor: Colors.white,
            activeIcon:
                Icon(activeIcon, color: Color(AppColors.TabIconActive)));
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NavigationIconView> _navigationViews;

  @override
  void initState() {
    super.initState();
    _navigationViews = [
      NavigationIconView(
          title: '微信', icon: Icons.delete, activeIcon: Icons.chat_bubble),
      NavigationIconView(
          title: '通讯录', icon: Icons.add, activeIcon: Icons.add_box),
      NavigationIconView(
        title: '发现',
        icon: Icons.delete,
        activeIcon: Icons.delete_forever,
      ),
      NavigationIconView(
        title: '我',
        icon: Icons.person,
        activeIcon: Icons.person_add,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar botNavBar = BottomNavigationBar(
      items: _navigationViews.map((NavigationIconView view) {
        return view.item;
      }).toList(),
      currentIndex: 0,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        print('点击的事第$index个Tab');
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('微信'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print('点击了搜索按钮');
            },
          ),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                print('显示下拉列表');
              })
        ],
      ),
      body: Container(
        color: Colors.red,
      ),
      bottomNavigationBar: botNavBar,
    );
  }
}
