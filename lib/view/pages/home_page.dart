import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:talabat_online/utils/app_colors.dart';
import 'package:talabat_online/view/widgets/category_item.dart';
import 'package:talabat_online/view/widgets/home_widget_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TabBar(
            dividerHeight: 0.5,
            unselectedLabelColor: AppColors.grey,
            controller: _tabController,
            tabs: [
              Tab(
                text: 'Home',
              ),
              Tab(
                text: 'Categoey',
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                HomeWidgetItem(),
                CategoryItem(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
