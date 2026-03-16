import 'package:flutter/material.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({super.key});

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {

  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.arrow_back_rounded,
            color: Colors.black),
            centerTitle: true,
        title: Text(
              "Add Project",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
            ),
            actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(Icons.notifications_active,
              color: Colors.black),
            ),
            ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
                ),
              
                child: Row(
                  children: [
                    
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.pink.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.wallet_giftcard,color: Colors.pink,)),
                    SizedBox(width: 20),
                    Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Task Group",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 117, 116, 116),
                            fontSize: 20,
                          ),
                        ),
                        Text(
                         "Work",
                            style: TextStyle(
                             color: Colors.black,
                             fontSize: 20,
                             fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    
                    Spacer(),
              
                    Icon(Icons.arrow_right_rounded,
                    size: 50,
                    color: Colors.black),
                  ],
                ),
              ),

              SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Project Name",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "Grocery Shopping App",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      ),
                  ],
                ),

                ),

                SizedBox(height: 20),

                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "This application designed for super shops.By using this application they can enlist all their products in one place and can deliver.Customers will get a one_stop sloution for their daily shopping.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      ),
                  ],
                ),

                ),

                SizedBox(height: 20),

                //start date

                GestureDetector(
                    onTap:() async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), 
                        firstDate: DateTime(2020), 
                        lastDate: DateTime(2030),
                        );

                        if(picked != null){
                          setState(() {
                            startDate = picked;
                          });
                        }
                    },
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_month,color: Colors.deepPurple),
                    SizedBox(width: 15),
                    Text(
                      startDate == null 
                      ? "Start Date"
                      : "${startDate!.day}/${startDate!.month}/${startDate!.year}"
                    ),
                    Spacer(),
                    Icon(Icons.keyboard_arrow_down)
                  ],
                ),

                ),
                ),
                
                SizedBox(height: 20),

                 //end date

                GestureDetector(
                    onTap:() async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), 
                        firstDate: DateTime(2020), 
                        lastDate: DateTime(2030),
                        );

                        if(picked != null){
                          setState(() {
                            endDate = picked;
                          });
                        }
                    },
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_month,color: Colors.deepPurple),
                    SizedBox(width: 15),
                    Text(
                      endDate == null 
                      ? "End Date"
                      : "${endDate!.day}/${endDate!.month}/${endDate!.year}"
                    ),
                    Spacer(),
                    Icon(Icons.keyboard_arrow_down)
                  ],
                ),

                
                ),
                ),

                SizedBox(height: 20),

                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage("assets/logo.png"),
                      ),

                      SizedBox(width: 15),

                      Text(
                        "Grocery Shop",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Spacer(),

                      ElevatedButton(
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                         backgroundColor: const Color.fromARGB(255, 174, 142, 233),
                         padding: EdgeInsets.symmetric(vertical: 15),
                         shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10),
                      )
                    ),
                        child: Text(
                          " Change Logo ",
                          style: TextStyle(
                            color: Colors.deepPurple,
                          ),
                        ),
                        ),
                  ],
                ),

                ),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                    ),
                     child: Text(
                      "Add Project",
                       style: TextStyle(fontSize: 20,
                       color: Colors.white,
                       ),
                     ),
                     ),
                ),

            ],
          ),
        ),
      ),
    );
  }
}