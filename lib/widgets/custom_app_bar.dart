import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.deepPurple,
      title: const Row(
        children: [
          Icon(
            Icons.square, // Kare ikon
            color: Colors.white,
            size: 45, // İkon boyutu artırıldı (varsayılan boyut 24)
          ),
          SizedBox(width: 8), // İkon ile yazı arasında boşluk
          Text(
            "Hoş Geldiniz!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
