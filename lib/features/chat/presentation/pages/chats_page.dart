part of '../presentation_imports.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependencyHelper.instance.get<ChatCubit>()..getChats(),
      child: const ChatsPageBody(),
    );
  }
}

class ChatsPageBody extends StatefulWidget {
  const ChatsPageBody({super.key});

  @override
  State<ChatsPageBody> createState() => _ChatsPageBodyState();
}

class _ChatsPageBodyState extends State<ChatsPageBody> {
  final _scrollController = ScrollController();

  void _onScroll() {
    final currentScroll = _scrollController.position.pixels;
    final maxScroll = _scrollController.position.maxScrollExtent;

    if (currentScroll == maxScroll) {
      context.read<ChatCubit>().getChats();
    }
  }

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          context.read<ChatCubit>().getChats(1);
        },
        child: BlocSelector<ChatCubit, ChatState, ({UsecaseStatus status, Failure? failure, PaginatedList<Chat> chats})>(
          selector: (state) => (status: state.chatsStatus, failure: state.chatsFailure, chats: state.chats.data!),
          builder: (context, state) {
            return state.status.when<List<Chat>>(
              context,
              idle: (context) => const Center(child: CircularProgressIndicator.adaptive()),
              running: (context) => const Center(child: CircularProgressIndicator.adaptive()),
              completed: (context) => ListView.separated(
                controller: _scrollController,
                padding: REdgeInsets.symmetric(horizontal: 16, vertical: 24),
                itemCount: !state.chats.hasReachedEnd ? state.chats.data.length + 1 : state.chats.data.length,
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  if (index >= state.chats.data.length) {
                    return const Center(child: CircularProgressIndicator.adaptive());
                  }

                  final chat = state.chats.data[index];
                  return ChatWidget(chat);
                },
              ),
              error: (context) => Center(child: Text(state.failure!.response.message)),
            );
          },
        ),
      ),
    );
  }
}
