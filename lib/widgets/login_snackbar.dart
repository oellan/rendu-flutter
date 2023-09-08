import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginSnackBar {
  static SnackBar create(BuildContext context, IconData icon, String text) {
    return SnackBar(
      backgroundColor: Theme.of(context).colorScheme.inverseSurface,
      closeIconColor: Theme.of(context).colorScheme.onInverseSurface,
      content: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.onInverseSurface,
          ),
          const Gap(8),
          Text(
            text,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onInverseSurface),
          ),
        ],
      ),
    );
  }
}
