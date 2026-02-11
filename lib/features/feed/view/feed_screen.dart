import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/feed_bloc.dart';
import '../bloc/feed_event.dart';
import '../bloc/feed_state.dart';
import '../widgets/image_card.dart';
import '../widgets/shimmer_box.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<FeedBloc>().add(LoadFeed());

    scrollController.addListener(() {
      final state = context.read<FeedBloc>().state;

      if (scrollController.position.extentAfter < 300 &&
          state is FeedLoaded &&
          !state.hasReachedMax) {
        context.read<FeedBloc>().add(LoadFeed());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text(
            "Picsum Image Feed",
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          if (state is FeedLoading) {
            return ListView.builder(
              itemCount: 6,
              itemBuilder: (_, __) => const Padding(
                padding: EdgeInsets.all(12),
                child: ShimmerBox(),
              ),
            );
          }

          if (state is FeedError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 50),
                  const SizedBox(height: 12),
                  const Text("Something went wrong"),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      context.read<FeedBloc>().add(LoadFeed());
                    },
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }

          if (state is FeedLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<FeedBloc>().add(LoadFeed(isRefresh: true));
              },
              child: ListView.builder(
                controller: scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.images.length + (state.hasReachedMax ? 0 : 1),
                itemBuilder: (context, index) {
                  if (index >= state.images.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  return ImageCard(image: state.images[index]);
                },
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
