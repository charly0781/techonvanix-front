import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Showtooltip {

  static  showTooltip(BuildContext context, String? leyenda) {
    if (leyenda != null) {
      final overlay = Overlay.of(context)!;
      final tooltip = OverlayEntry(
        builder: (context) => Positioned(
          top: MediaQuery.of(context).size.height / 2 - 120,
          left: MediaQuery.of(context).size.width / 2 - leyenda.length - 40,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                leyenda,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ),
      );

      overlay.insert(tooltip);
      Future.delayed(const Duration(seconds: 2), () {
        tooltip.remove();
      });
    }
  }
}