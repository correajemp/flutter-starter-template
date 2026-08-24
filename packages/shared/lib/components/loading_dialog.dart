import 'package:flutter/material.dart';
import 'package:shared/widgets/loading_indicator.dart';

class LoadingDialogContent extends StatelessWidget {
  const LoadingDialogContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Material(color: Colors.transparent, child: LoadingIndicator(size: 88, logoSize: 88)),
    );
  }
}
