import 'package:flutter/material.dart';
import '../screens/login_screen/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/theme_provider.dart';
import '../utils/image_assets.dart';
import '../utils/themes.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 235,
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(40),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildNavigation(
                    context,
                    icon: const Icon(Icons.chevron_left_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Consumer(
                    builder: (context, watch, child) {
                      final theme = watch(themeProvider);
                      return _buildNavigation(
                        context,
                        icon: theme == ThemeMode.dark
                            ? const Icon(Icons.light_mode)
                            : const Icon(Icons.dark_mode),
                        onPressed: () {
                          context.read(themeProvider.notifier).switchTheme();
                        },
                      );
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  Flexible(
                    child: Image.asset(
                      ImageAssets.committes,
                      width: 177,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigation(
    BuildContext context, {
    required VoidCallback onPressed,
    required Widget icon,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: IconTheme(
          data: const IconThemeData(color: kLightModeLightBlue),
          child: icon,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(235);
}