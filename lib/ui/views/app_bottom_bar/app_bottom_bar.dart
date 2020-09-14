import 'package:ardico_test/resources/app_colors.dart';
import 'package:ardico_test/resources/strings.dart';
import 'package:ardico_test/ui/views/app_bottom_bar/app_bottom_bar_button.dart';
import 'package:flutter/material.dart';

class AppBottomBar extends StatelessWidget {
  final VoidCallback onExploreButtonPressed;
  final VoidCallback onTicketsButtonPressed;

  const AppBottomBar({
    Key key,
    @required this.onExploreButtonPressed,
    @required this.onTicketsButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary,
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: _buildExploreButton(),
            ),
            Expanded(
              child: _buildTicketsButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExploreButton() {
    return AppBottomBarButton(
      text: Strings.exploreButtonLabel,
      onTap: onExploreButtonPressed,
    );
  }

  Widget _buildTicketsButton() {
    return AppBottomBarButton(
      text: Strings.ticketsButtonLabel,
      onTap: onTicketsButtonPressed,
    );
  }
}
