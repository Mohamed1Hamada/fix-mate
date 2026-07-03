import 'package:easy_localization/easy_localization.dart';
import 'package:fixmate/core/components/custom_circular_progress_indecator.dart';
import 'package:fixmate/core/components/custom_elevated_button.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/features/customer/technician_details/view_models/cubit/technician_request_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTechnicianRequestButton extends StatelessWidget {
  const AddTechnicianRequestButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TechnicianRequestCubit, TechnicianRequestState>(
      buildWhen: (previous, current) =>
          current is AddTechnicianRequestLoading ||
          previous is AddTechnicianRequestLoading,
      builder: (context, state) {
        return state is AddTechnicianRequestLoading
            ? const CustomCircularProgresIndecator()
            : CustomElevatedButton(
                name: "submit".tr(),
                width: double.infinity,
                height: SizeConfig.height * 0.07,
                onPressed: () {
                  context
                      .read<TechnicianRequestCubit>()
                      .addTechnicianRequest();
                },
              );
      },
    );
  }
}
