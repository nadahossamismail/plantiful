import 'package:atlas_icons/atlas_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:plantiful/core/app_colors.dart';
import 'package:plantiful/core/app_routes.dart';
import 'package:plantiful/cubits/fertilizers/fertilizers_cubit.dart';
import 'package:plantiful/presentation_layer/screens/fertilizers_view.dart';

class ExpandableFAB extends StatelessWidget {
  final _key = GlobalKey<ExpandableFabState>();

  ExpandableFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      closeButtonBuilder: RotateFloatingActionButtonBuilder(
        backgroundColor: AppColors.primary,
        child: const Icon(
          Icons.close,
        ),
        fabSize: ExpandableFabSize.small,
      ),
      openButtonBuilder: RotateFloatingActionButtonBuilder(
        backgroundColor: AppColors.primary,
        child: const Icon(
          Atlas.leaf,
        ),
        fabSize: ExpandableFabSize.regular,
      ),
      key: _key,
      type: ExpandableFabType.up,
      childrenAnimation: ExpandableFabAnimation.rotate,
      distance: 50,
      overlayStyle: const ExpandableFabOverlayStyle(),
      children: [
        FloatingActionButton.small(
          backgroundColor: AppColors.primary,
          heroTag: null,
          onPressed: () => Navigator.of(context).pushNamed(Routes.plantsRoute),
          child: const Icon(
            Icons.add,
          ),
        ),
        FloatingActionButton.small(
          backgroundColor: AppColors.primary,
          heroTag: null,
          onPressed: () {
            showModalBottomSheet(
                useSafeArea: true,
                showDragHandle: true,
                isScrollControlled: true,
                context: context,
                builder: (_) {
                  return DraggableScrollableSheet(
                      expand: false,
                      builder: (context, controller) {
                        return BlocProvider(
                          create: (context) => FertilizersCubit(),
                          child: FertilizersScreen(
                            scrollController: controller,
                          ),
                        );
                      });
                });
          },
          child: const Icon(
            Atlas.green_gas,
          ),
        ),
      ],
    );
  }
}
