part of '../presentation_imports.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependencyHelper.instance.get<OrderCubit>()..getOrders(),
      child: const OrdersPageBody(),
    );
  }
}

class OrdersPageBody extends StatelessWidget {
  const OrdersPageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: BlocSelector<OrderCubit, OrderState, ({UsecaseStatus status, Failure? failure, List<Order> orders})>(
        selector: (state) => (status: state.ordersStatus, failure: state.ordersFailure, orders: state.orders),
        builder: (context, state) {
          return ListView.separated(
            itemCount: state.orders.length,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final order = state.orders[index];
              return ListTile(
                leading: Text(order.id.toString()),
                title: Text(order.title),
                subtitle: Text(
                  order.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final cubit = context.read<OrderCubit>();
          await context.showSheet<Order>(child: AddOrderSheet(orderCubit: cubit));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
