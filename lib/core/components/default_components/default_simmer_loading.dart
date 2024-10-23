import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';


class DefaultSimmerLoading extends StatelessWidget {
  final bool loading;
  final Widget child;
  const DefaultSimmerLoading(
      {super.key, required this.loading, required this.child});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(enabled: loading, child: child);
  }
}
