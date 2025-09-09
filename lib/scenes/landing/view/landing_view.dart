import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/app_colors.dart';
import '../../../theme/app_text_theme.dart';

class LandingView extends StatefulWidget {
  final String image;
  final String label;
  final String description;

  const LandingView({
    super.key,
    required this.image,
    required this.label,
    required this.description,
  });

  @override
  State<StatefulWidget> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose(); // Clean up
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SvgPicture.network(
            widget.image,
            placeholderBuilder: (BuildContext context) => Container(
              padding: const EdgeInsets.all(30.0),
              child: Center(child: const CircularProgressIndicator()),
            ),
          ),
        ),
        // Expanded(child: Image.network(widget.image)),
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.label,
                style: AppTextTheme.title2.copyWith(color: AppColors.primary),
              ),
              SizedBox(height: 10),
              Text(widget.description, style: AppTextTheme.body),
            ],
          ),
        ),
      ],
    );
  }
}
