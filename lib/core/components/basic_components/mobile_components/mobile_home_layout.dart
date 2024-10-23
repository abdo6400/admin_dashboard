import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/manage_mobile_cubit/manage_mobile_cubit.dart';
import 'appbar_components.dart';
import 'tabview_component.dart';

class MobileHomeLayout extends StatelessWidget {
  const MobileHomeLayout({super.key, required this.screens});
  final List<Map<String, dynamic>> screens;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
          create: (context) => ManageMobileCubit(),
          child: Scaffold(
            body: NestedScrollView(
                headerSliverBuilder: (context, _) => [
                      AppbarComponents(
                        title: screens[context
                                .watch<ManageMobileCubit>()
                                .currentPage]["title"]
                            .toString(),
                      )
                    ],
                body: TabviewComponent(
                  screens: screens,
                )),
          )),
    );
  }
}
