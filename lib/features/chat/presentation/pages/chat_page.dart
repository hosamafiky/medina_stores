part of '../presentation_imports.dart';

class ChatPage extends StatelessWidget {
  const ChatPage(this.chat, {super.key});

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependencyHelper.instance.serviceLocator<ChatCubit>()
        ..setCurrentChat(chat)
        ..getChatMessages(),
      child: const ChatPageBody(),
    );
  }
}

class ChatPageBody extends StatelessWidget {
  const ChatPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final chat = context.select((ChatCubit cubit) => cubit.state.currentChat);

    return Scaffold(
      appBar: MainAppBar(
        title: Text(chat!.receiverName),
      ),
      body: BlocSelector<ChatCubit, ChatState, ({UsecaseStatus status, Failure? failure, PaginatedList<ChatMessage>? messages})>(
        selector: (state) {
          return (status: state.messagesStatus, failure: state.messagesFailure, messages: state.messages.data);
        },
        builder: (context, state) {
          return RefreshIndicator.adaptive(
            onRefresh: () async {
              context.read<ChatCubit>().getChatMessages(1);
            },
            child: ListView.separated(
              padding: REdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              itemBuilder: (context, index) => ChatMessageWidget(state.messages!.data[index]),
              separatorBuilder: (context, index) => SizedBox(height: 20.h),
              itemCount: state.messages!.data.length,
            ),
          );
        },
      ),
      bottomNavigationBar: const ChatInputField(),
    );
  }
}
