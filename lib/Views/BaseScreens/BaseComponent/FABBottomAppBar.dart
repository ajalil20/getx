// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:pawndr/Component/custom_text.dart';
import 'package:pawndr/Utils/color_config.dart';
import 'package:pawndr/Utils/responsive.dart';

class FABBottomAppBarItem {
  FABBottomAppBarItem({this.icon, this.text});
  final Icon? icon;
  final String? text;
}

class FABBottomAppBar extends StatefulWidget {
  final List<FABBottomAppBarItem> items;
  final ValueChanged<int> onTabSelected;
  FABBottomAppBar({required this.onTabSelected, required this.items});

  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();
}

class FABBottomAppBarState extends State<FABBottomAppBar> {
  int _selectedIndex = 0;
  ColorConfig colors = ColorConfig();
  Responsive responsive = Responsive();
  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
    print(index);
  }

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: BottomAppBar(
        child: Container(
          decoration: BoxDecoration(
              color: colors.primaryColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20))),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items,
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem({
    FABBottomAppBarItem? item,
    int? index,
    ValueChanged<int>? onPressed,
  }) {
    Color color =
        _selectedIndex == index ? colors.secondaryColor : colors.primaryColor;
    return Expanded(
      child: SizedBox(
        height: responsive.setHeight(10),
        child: Material(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              if (onPressed != null) {
                onPressed(index != null ? index : 0);
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: item != null ? item.icon : Icon(Icons.add),
                ),
                MyText(
                  title: '${item != null ? item.text : ''}',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
