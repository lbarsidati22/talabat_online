import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:talabat_online/utils/app_colors.dart';
import 'package:talabat_online/view/pages/cart_page.dart';
import 'package:talabat_online/view/pages/favorite_page.dart';
import 'package:talabat_online/view/pages/home_page.dart';
import 'package:talabat_online/view/pages/profile_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final _controller = PersistentTabController();

  final List<Widget> _buildScreens = [
    HomePage(),
    CartPage(),
    FavoritePage(),
    ProfilePage(),
  ];
  final List<PersistentBottomNavBarItem> _navBarsItems = [
    PersistentBottomNavBarItem(
      inactiveColorPrimary: Colors.blueGrey,
      activeColorPrimary: AppColors.primaryColor,
      icon: Icon(
        CupertinoIcons.home,
      ),
      title: 'Home',
    ),
    PersistentBottomNavBarItem(
      inactiveColorPrimary: Colors.blueGrey,
      activeColorPrimary: AppColors.primaryColor,
      icon: Icon(
        CupertinoIcons.shopping_cart,
      ),
      title: 'Cart',
    ),
    PersistentBottomNavBarItem(
      inactiveColorPrimary: Colors.blueGrey,
      activeColorPrimary: AppColors.primaryColor,
      icon: Icon(
        CupertinoIcons.heart,
      ),
      title: 'Favorite',
    ),
    PersistentBottomNavBarItem(
      inactiveColorPrimary: Colors.blueGrey,
      activeColorPrimary: AppColors.primaryColor,
      icon: Icon(
        CupertinoIcons.person,
      ),
      title: 'Profile',
    ),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              'https://scontent.fsvq4-1.fna.fbcdn.net/v/t39.30808-6/448064160_1635279980581472_3917811417946539350_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=a5f93a&_nc_eui2=AeH8HfG5Pghmg-pWP_8T9BNIG7ewNitpeYgbt7A2K2l5iKCehss5l7qZdBrO32R_d5MG3AOdnkA6vbDnlS5zq1A3&_nc_ohc=vjVQszGTC0oQ7kNvgFi8Zlv&_nc_zt=23&_nc_ht=scontent.fsvq4-1.fna&_nc_gid=AxrmJqAZRGTROABRlToH1bg&oh=00_AYC5XSCocYLclsk5mxy8wICEX3zB9UfVOzJiqw253VDyMw&oe=677A68D5',
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lbar sidati',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              'Let\'s Go Shopping',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.grey,
                  ),
            ),
          ],
        ),
        actions: [
          if (currentIndex == 0) ...[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
              ),
            ),
          ],
          if (currentIndex == 1) ...[
            Container(
              margin: EdgeInsets.only(right: 10),
              width: size.width * 0.10,
              height: size.height * 0.05,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: AppColors.grey3,
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.shopping_bag,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ]
        ],
      ),
      body: PersistentTabView(
        onItemSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        context,
        controller: _controller,
        screens: _buildScreens,
        items: _navBarsItems,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: false,
        hideNavigationBarWhenKeyboardAppears: true,
        padding: const EdgeInsets.only(top: 5, bottom: 9),
        isVisible: true,
        animationSettings: const NavBarAnimationSettings(
          navBarItemAnimation: ItemAnimationSettings(
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimationSettings(
            animateTabTransition: true,
            duration: Duration(milliseconds: 200),
            screenTransitionAnimationType: ScreenTransitionAnimationType.slide,
          ),
        ),
        confineToSafeArea: true,
        navBarHeight: kBottomNavigationBarHeight,
        navBarStyle: NavBarStyle.style6,
      ),
    );
  }
}
