import 'package:atlas_icons/atlas_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:plantiful/core/app_colors.dart';
import 'package:plantiful/core/app_sizing.dart';
import 'package:plantiful/cubits/fertilizers/fertilizers_cubit.dart';
import 'package:plantiful/data_layer.dart/models/get_fertilizers_response.dart';

class FertilizersScreen extends StatefulWidget {
  const FertilizersScreen({
    super.key,
    required this.scrollController,
  });
  final ScrollController scrollController;
  @override
  State<FertilizersScreen> createState() => _FertilizersScreenState();
}

class _FertilizersScreenState extends State<FertilizersScreen> {
  @override
  void initState() {
    FertilizersCubit.get(context).getFertilizers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FertilizersCubit, FertilizersState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            // appBar: AppBar(
            //   title: const Text("Fertilizers"),
            // ),
            body: state is FertilizersLoading
                ? Center(
                    child: LoadingAnimationWidget.waveDots(
                        color: AppColors.primary, size: 35),
                  )
                : state is FertilizersSuccess
                    ? ListView.builder(
                        controller: widget.scrollController,
                        padding: const EdgeInsets.fromLTRB(0, 4, 0, 24),
                        itemCount: state.fertilizers.length,
                        itemBuilder: (context, index) {
                          Fertilizer fertilizer = state.fertilizers[index];
                          return ExpansionTile(
                            expansionAnimationStyle: AnimationStyle(
                                curve: Curves.decelerate,
                                duration: const Duration(milliseconds: 500),
                                reverseCurve: Curves.bounceIn,
                                reverseDuration:
                                    const Duration(milliseconds: 500)),
                            leading: CircleAvatar(
                              radius: 20,
                              child: Text("${index + 1}"),
                            ),
                            subtitle: Text(
                              fertilizer.definition,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: FontSize.f12),
                            ),
                            title: Text(
                              fertilizer.name,
                              style: const TextStyle(
                                  fontSize: FontSize.f20,
                                  fontWeight: FontWeight.bold),
                            ),
                            children: [
                              ListTile(
                                  leading: const Icon(Atlas.herb_mix),
                                  title: const Text(
                                    "How to make:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(fertilizer.instructions)),
                              ListTile(
                                  leading: const Icon(Atlas.first_aid_box),
                                  title: const Text(
                                    "Benefits:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(fertilizer.benefits))
                            ],
                          );
                        })
                    : const SizedBox(),
          ),
        );
      },
    );
  }
}
