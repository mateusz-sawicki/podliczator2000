import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final int index;
  final ValueChanged<int> onChangeTab;
  const BottomNavBar({
    required this.index,
    required this.onChangeTab,
    super.key,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final placeholder = Opacity(
        opacity: 0,
        child: IconButton(
          icon: const Icon(Icons.no_cell),
          onPressed: () {},
        ));
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildTabItem(
            0,
            const Icon(Icons.task_outlined),
          ),
          buildTabItem(
            1,
            const Icon(Icons.analytics_outlined),
          ),
          placeholder,
          buildTabItem(
            2,
            const Icon(Icons.upload_file_outlined),
          ),
          buildTabItem(
            3,
            const Icon(Icons.menu),
          ),
        ],
      ),
    );
  }

  Widget buildTabItem(int index, Icon icon) {
    final isSelected = index == widget.index;
    return IconTheme(
        data: IconThemeData(color: isSelected ? Colors.blue : Colors.black),
        child: IconButton(
            onPressed: () {
              setState(() => widget.onChangeTab(index));
            },
            icon: icon));
  }
}
