import 'package:flutter/material.dart';

class CustomIcons {
  static IconData getIconFromName(String iconName) {
    switch (iconName) {
      case 'home':
        return Icons.home;
      case 'search':
        return Icons.search;
      case 'settings':
        return Icons.settings;
      case 'login':
        return Icons.login;
      case 'logout':
        return Icons.logout;
      case 'person':
        return Icons.person;
      case 'email':
        return Icons.email;
      case 'phone':
        return Icons.phone;
      case 'info':
        return Icons.info;
      case 'favorite':
        return Icons.favorite;
      case 'star':
        return Icons.star;
      case 'menu':
        return Icons.menu;
      case 'close':
        return Icons.close;
      case 'check':
        return Icons.check;
      case 'warning':
        return Icons.warning;
      case 'error':
        return Icons.error;
      case 'registro':
        return Icons.how_to_reg;
      case 'company':
        return Icons.store;
      default:
        return Icons.help_outline;
    }
  }
}

