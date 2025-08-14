import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/const_image.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/features/auction_view/model/auction_model.dart';
import 'package:car_store/features/auction_view/presentation/manager/auction_cubit.dart';
import 'package:car_store/features/auction_view/presentation/manager/auction_state.dart';
import 'package:car_store/features/auction_view/presentation/widget/auction_list_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class AuctionView extends StatelessWidget {
  const AuctionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: InkWell(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: const Icon(Icons.menu)),
        centerTitle: true,
        title: Text(
          'CarStore',
          style: getTitleStyle(context, color: AppColors.primaryColor),
        ),
      ),
      body: BlocProvider(
        create: (context) => AuctionCubit(),
        child: BlocBuilder<AuctionCubit, AuctionState>(
          builder: (context, state) {
            return StreamBuilder(
                stream: context.read<AuctionCubit>().getAuctionData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return const Center(
                      child: Text('No data available'),
                    );
                  } else {
                    final dataSnapshot = snapshot.data!.snapshot;
                    if (dataSnapshot.value == null) {
                      return Center(
                          child: SvgPicture.asset(ConstImage.kNotFound));
                    }

                    final data =
                        Map<String, dynamic>.from(dataSnapshot.value as Map);
                    final List<AuctionModel> auction = data.entries
                        .map((entry) => AuctionModel.fromJson(
                            Map<String, dynamic>.from(entry.value as Map)))
                        .toList();

                    return auction.isEmpty
                        ? Center(
                            child: Text(
                              'No Data Available',
                              style: getTitleStyle(context,
                                  color: AppColors.primaryColor),
                            ),
                          )
                        : ListView.builder(
                            itemCount: auction.length,
                            itemBuilder: (context, index) {
                              AuctionCubit()
                                  .getDataUserId(id: auction[index].creatorUid);

                              return AuctionListItems(
                                  auctionItem: auction[index]);
                            },
                          );
                  }
                });
          },
        ),
      ),
    );
  }
}
