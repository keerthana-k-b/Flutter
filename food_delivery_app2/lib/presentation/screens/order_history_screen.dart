import 'package:flutter/material.dart';
import 'package:food_delivery_app2/presentation/provider/order_provider.dart';
import 'package:food_delivery_app2/presentation/screens/order_tracking_mock_screen.dart';
import 'package:provider/provider.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {

  @override
  void initState() {
    super.initState();

    Provider.of<OrderProvider>(context, listen: false)
        .listenOrders();
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("My Orders")),

      body: provider.orders.isEmpty
          ? Center(child: Text("No orders yet"))
          : ListView.builder(
              itemCount: provider.orders.length,
              itemBuilder: (context, index) {
                final order = provider.orders[index];

                return Container(
  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  padding: const EdgeInsets.all(14),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  ),
  child: InkWell(
    borderRadius: BorderRadius.circular(16),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              OrderTrackingMockPage(orderId: order.id),
        ),
      );
    },
    child: Row(
      children: [

        /// 🧾 LEFT ICON
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.receipt_long, color: Colors.orange),
        ),

        const SizedBox(width: 12),

        /// 📄 ORDER DETAILS
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// 💰 PRICE
              Text(
                "₹${order.total.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 4),

              /// 📦 ITEMS
              Text(
                "${order.items.length} items",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 6),

              /// 🟢 STATUS BADGE
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(order.status).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  order.status.toUpperCase(),
                  style: TextStyle(
                    color: _getStatusColor(order.status),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        /// ➡️ ARROW
        const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      ],
    ),
  ),
);
              },
            ),
    );
  }

  Color _getStatusColor(String status) {
  switch (status) {
    case "preparing":
      return Colors.orange;
    case "on the way":
      return Colors.blue;
    case "delivered":
      return Colors.green;
    default:
      return Colors.grey;
  }
}
}