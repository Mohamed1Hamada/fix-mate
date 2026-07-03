import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/features/customer/nearest_technicians/view_models/cubit/nearest_technicians_cubit.dart';
import 'package:fixmate/features/customer/nearest_technicians/views/widgets/custom_failure_message.dart';
import 'package:fixmate/features/customer/nearest_technicians/views/widgets/custom_loading_indicator.dart';
import 'package:fixmate/features/customer/nearest_technicians/views/widgets/empty_lottie.dart';
import 'package:fixmate/features/customer/nearest_technicians/views/widgets/nearest_technician_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NearestTechnicianListView extends StatelessWidget {
  const NearestTechnicianListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<NearestTechniciansCubit, NearestTechniciansState>(
        builder: (context, state) {
          if (state is GetNearestTechniciansLoading) {
            return CustomLoadingIndicator();
          }
          if (state is GetNearestTechniciansError) {
            return CustomFailureMesage(errorMessage: state.message);
          }
          var cubit = context.read<NearestTechniciansCubit>();
          return cubit.nearestTechnicians.isEmpty
              ? EmptyLottie()
              : ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.width * 0.04,
                    vertical: SizeConfig.height * 0.02,
                  ),
                  itemCount: cubit.nearestTechnicians.length,
                  itemBuilder: (context, index) {
                    final tech = cubit.nearestTechnicians[index];
                    return NearestTechnicianCard(
                      key: ValueKey(tech.id),
                      tech: tech,
                    );
                  },
                );
        },
      ),
    );
  }
}

