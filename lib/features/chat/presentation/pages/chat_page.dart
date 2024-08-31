part of '../presentation_imports.dart';

class ChatPage extends StatelessWidget {
  const ChatPage(this.chat, {super.key});

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependencyHelper.instance.serviceLocator<ChatCubit>()
        ..setCurrentChat(chat)
        ..getChatMessages()
        ..subscribeAndBind()
        ..initScrollListener(),
      child: const ChatPageBody(),
    );
  }
}

class ChatPageBody extends StatefulWidget {
  const ChatPageBody({super.key});

  @override
  State<ChatPageBody> createState() => _ChatPageBodyState();
}

class _ChatPageBodyState extends State<ChatPageBody> {
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
            onRefresh: () async => context.read<ChatCubit>().getChatMessages(1),
            child: ListView.separated(
              reverse: true,
              controller: context.read<ChatCubit>().scrollController,
              padding: REdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              itemBuilder: (context, index) {
                final message = state.messages!.data.reversed.toList()[index];
                final nextMessage = index + 1 < state.messages!.data.reversed.length ? state.messages!.data.reversed.toList()[index + 1] : null;
                final previousMessage = index > 0 ? state.messages!.data.reversed.toList()[index - 1] : null;
                return ChatMessageWidget(message, previousMessage: previousMessage, nextMessage: nextMessage);
              },
              separatorBuilder: (context, index) {
                final nextMessage = state.messages!.data.reversed.toList()[index + 1];
                final currentMessage = state.messages!.data.reversed.toList()[index];
                final isTheSameSender = (nextMessage.isSender && currentMessage.isSender) || (!nextMessage.isSender && !currentMessage.isSender);
                return isTheSameSender ? SizedBox(height: 6.h) : SizedBox(height: 20.h);
              },
              itemCount: state.messages!.data.reversed.length,
            ),
          );
        },
      ),
      bottomNavigationBar: ChatInputField(
        onMicPressed: () {},
        onEmojiPressed: () {},
        onAttachmentPressed: () {},
        onCameraPressed: () {},
      ),
    );
  }
}
