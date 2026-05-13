import 'package:flutter/material.dart';
import 'package:food_delivery_app2/data/services/order_service.dart';
import 'package:food_delivery_app2/presentation/provider/cart_provider.dart';
import 'package:food_delivery_app2/presentation/screens/order_tracking_mock_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

 late Razorpay _razorpay;

 @override
 void initState() {
  super.initState();

  _razorpay = Razorpay();

  _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
  _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

 }

 @override
 void dispose() {
  _razorpay.clear();
  super.dispose();
 }


void openCheckout(double amount) {
  var options = {
    'key': 'rzp_test_SlK5Rw46BKI3Dt', //TEST key
    'amount': (amount * 100).toInt(), 
    'name': 'Food Delivery App',
    'description': 'Order Payment',
    'prefill': {
    //'contact': '9999999999',
    'email': 'demo@test.com'
    },
    // 'external': {
    //   'wallets': ['paytm']
    // }

    'method': {
    'upi': true,
    'card': true,
    'netbanking': true,
    'wallet': true
    }
  };

  try{
    _razorpay.open(options);
  } catch (e) {
    print(e.toString());
  }
}

void _handlePaymentSuccess(PaymentSuccessResponse response) async {
  print("SUCCESS: ${response.paymentId}");

  final cart = Provider.of<CartProvider>(context, listen: false);
  final orderService = OrderService();

  final orderId = await orderService.createOrder(
    items: cart.selectedItems.map((e) => {
      "title": e.food.title,
      "price": e.food.price,
      "qty": e.quantity,
    }).toList(),
    total: cart.selectedTotal,
  );

  cart.removeSelectedItems();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Payment Successful")),
  );

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => OrderTrackingMockPage(orderId: orderId),
    ),
  );
}

void _handlePaymentError(PaymentFailureResponse response) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Payment Failed")),
  );
}

void _handleExternalWallet(ExternalWalletResponse response) {
  print("Wallet: ${response.walletName}");
}

  @override
  Widget build(BuildContext context) {

    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
       title: Text("Cart"),
       centerTitle: true,
      ),

      body: cart.items.isEmpty
           ?Center(child: Text("Cart is empty"))
           :Column(
             children: [

              Expanded(
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index){
                    final item = cart.items[index];

                    return Card(
                      margin: EdgeInsets.all(10),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [

                            Checkbox(
                              value: item.isSelected,
                              onChanged: (_) {
                                cart.toggleSelection(index);
                              },
                             ),

                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                item.food.image,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),

                            SizedBox(width: 10),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.food.title,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    Text("₹${item.food.price}")
                                  ],
                                ),
                              ),

                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () => cart.decreaseQty(index), 
                                   icon: Icon(Icons.remove),
                                  ),

                                  Text(item.quantity.toString()),

                                  IconButton(
                                    onPressed: () => cart.increaseQty(index), 
                                    icon: Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ],
                           ),
                         ),
                       );
                     }
                   ), 
                 ),


             Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 5)
                ],
              ),

              child: Column(
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total:",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        "₹${cart.selectedTotal.toStringAsFixed(2)}",
                        style: GoogleFonts.poppins( 
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () async {

                      if (cart.selectedItems.isEmpty) {
                           ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(content: Text("Select items first")),
                           );
                           return;
                       }
                       openCheckout(cart.selectedTotal);

                       //  FALLBACK (important)
                       Future.delayed(Duration(seconds: 5), () {
                       _handlePaymentSuccess(
                          PaymentSuccessResponse("demo_payment_id", "demo_order_id", "demo_signature", null),
                       );
                       });

                      // final orderService = OrderService();

                      // final orderId = await orderService.createOrder(
                      //  items: cart.selectedItems.map((e) => {
                      //    "title": e.food.title,
                      //    "price": e.food.price,
                      //    "qty": e.quantity,
                      //   }).toList(),
                      //   total: cart.selectedTotal,
                      //   );

                      //  cart.removeSelectedItems();

                      
                      //  ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(content: Text("Order Placed")),
                      //  );

                      
                      //   Navigator.push(
                      //      context,
                      //     MaterialPageRoute(
                      //     builder: (_) => OrderTrackingMockPage(orderId: orderId),
                      //    ),
                      //   );
                     },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text("Place Order"),
                   ),
                 ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}