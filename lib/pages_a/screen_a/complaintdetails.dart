import 'package:flutter/material.dart';

class ComplaintDetails extends StatefulWidget {
  final Map<String, dynamic> data;
  const ComplaintDetails({Key key, this.data}) : super(key: key);
  @override
  _ComplaintDetailsState createState() => _ComplaintDetailsState(data);
}

class _ComplaintDetailsState extends State<ComplaintDetails> {
  final Map<String, dynamic> data;
  _ComplaintDetailsState(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Complaint Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.0,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(3, 5, 3, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  // height: 50,
                  decoration: BoxDecoration(
                      //color: Colors.blue[100],
                      /*  boxShadow: [
                        new BoxShadow(
                          color: Colors.blue[100],
                          blurRadius: 50.0,
                        ),
                      ], */
                      border: Border.all(
                        width: 0.9,
                        color: Colors.blue[400],
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(5),
                    shadowColor: Colors.blue,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Complaint Number: " +
                                    '${data["complaint_number"]}',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              " Date: " + data["date"],
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              "time: " + data["time"] + " ",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(1, 8, 3, 8),
                child: new Text(
                  ' Complaint Details',
                  style: TextStyle(
                      fontSize: 26.0,
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Container(
                  width: double.infinity,
                  decoration: new BoxDecoration(
                    //color: Colors.blue[100],
                    border: Border.all(
                      width: 0.5,
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    shadowColor: Colors.blue,
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(
                                left: 2.0, right: 5.0, top: 5.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      ' Description',
                                      style: TextStyle(
                                        fontSize: 23.0,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.fromLTRB(8, 5, 8, 3),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            // height: 100,
                            decoration: BoxDecoration(
                                //color: Colors.blue[100],
                                border: Border.all(
                                  width: 0.0,
                                  color: Colors.blue[400],
                                ),
                                borderRadius: BorderRadius.circular(0)),
                            child: Material(
                              elevation: 3,
                              borderRadius: BorderRadius.circular(0),
                              shadowColor: Colors.blue,
                              child:
                                  /* Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[ */
                                  Container(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(7, 0, 5, 5),
                                  child: data["description"] == ""
                                      ? Text(
                                          'not updoaded',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 25.0,
                                          ),
                                        )
                                      : Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            data['description'],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 25.0,
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                              /*   ],
                              ), */
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 2.0, right: 5.0, top: 5.0, bottom: 0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      ' Landmark',
                                      style: TextStyle(
                                        fontSize: 23.0,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.fromLTRB(8, 5, 8, 3),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            // height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.0,
                                  color: Colors.blue[400],
                                ),
                                borderRadius: BorderRadius.circular(0)),
                            child: Material(
                              elevation: 3,
                              borderRadius: BorderRadius.circular(0),
                              shadowColor: Colors.blue,
                              child:
                                  /*  Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[ */
                                  Container(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(7, 0, 5, 5),
                                  child: data["landmark"] == ""
                                      ? Text(
                                          'not updoaded',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 25.0,
                                          ),
                                        )
                                      : Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            data['landmark'],
                                            //overflow: TextOverflow.ellipsis,
                                            maxLines: null,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 25.0,
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                              /*    ],
                              ), */
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 2.0, right: 5.0, top: 5.0, bottom: 0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      ' Location',
                                      style: TextStyle(
                                        fontSize: 23.0,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.fromLTRB(8, 5, 8, 3),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            // height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.0,
                                  color: Colors.blue[400],
                                ),
                                borderRadius: BorderRadius.circular(0)),
                            child: Material(
                              elevation: 3,
                              borderRadius: BorderRadius.circular(0),
                              shadowColor: Colors.blue,
                              child:
                                  /*  Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[ */
                                  Container(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(7, 0, 5, 5),
                                  child: data["location"] == ""
                                      ? Text(
                                          'not updoaded',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 25.0,
                                          ),
                                        )
                                      : Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            data['location'],
                                            //overflow: TextOverflow.ellipsis,
                                            maxLines: null,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 25.0,
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                              /*    ],
                              ), */
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 2.0, right: 5.0, top: 5.0, bottom: 0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      ' Complaint status',
                                      style: TextStyle(
                                        fontSize: 23.0,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.fromLTRB(8, 5, 8, 8),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            // height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.0,
                                  color: Colors.blue[400],
                                ),
                                borderRadius: BorderRadius.circular(0)),
                            child: Material(
                              elevation: 3,
                              borderRadius: BorderRadius.circular(0),
                              shadowColor: Colors.blue,
                              child:
                                  /*  Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[ */
                                  Container(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(7, 0, 5, 5),
                                  child: data["status"] == ""
                                      ? Text(
                                          'not updoaded',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 25.0,
                                          ),
                                        )
                                      : Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            data['status'],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 25.0,
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                              /*  ],
                              ), */
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 2.0, right: 5.0, top: 5.0, bottom: 0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      ' Complaint Due Date',
                                      style: TextStyle(
                                        fontSize: 23.0,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.fromLTRB(8, 5, 8, 8),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            // height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.0,
                                  color: Colors.blue[400],
                                ),
                                borderRadius: BorderRadius.circular(0)),
                            child: Material(
                              elevation: 3,
                              borderRadius: BorderRadius.circular(0),
                              shadowColor: Colors.blue,
                              child:
                                  /* Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[ */
                                  Container(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(7, 0, 5, 5),
                                  child: data["due_date"] == ""
                                      ? Text(
                                          'not updoaded',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 25.0,
                                          ),
                                        )
                                      : Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            data['due_date'],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 25.0,
                                            ),
                                          ),
                                        ),
                                ),
                              ),
/*                                 ],
                              ), */
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(1, 8, 3, 8),
                child: new Text(
                  ' Complaint Assignment Details',
                  style: TextStyle(
                      fontSize: 26.0,
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Container(
                  width: double.infinity,
                  decoration: new BoxDecoration(
                    //color: Colors.blue[100],
                    border: Border.all(
                      width: 0.5,
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    shadowColor: Colors.blue,
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(
                                left: 2.0, right: 5.0, top: 5.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      ' Employee Name',
                                      style: TextStyle(
                                        fontSize: 23.0,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.fromLTRB(8, 5, 8, 3),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            // height: 50,
                            decoration: BoxDecoration(
                                //color: Colors.blue[100],
                                border: Border.all(
                                  width: 0.0,
                                  color: Colors.blue[400],
                                ),
                                borderRadius: BorderRadius.circular(0)),
                            child: Material(
                              elevation: 3,
                              borderRadius: BorderRadius.circular(0),
                              shadowColor: Colors.blue,
                              child:
                                  /*Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
 */
                                  Container(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(7, 0, 5, 5),
                                  child: data["employee_name"] == ""
                                      ? Text(
                                          'not updoaded',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 25.0,
                                          ),
                                        )
                                      : Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            data['employee_name'],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 25.0,
                                            ),
                                          ),
                                        ),
                                ),
                              ),
/*                                 ],
                              ), */
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 2.0, right: 5.0, top: 5.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      ' Employee contect no.',
                                      style: TextStyle(
                                        fontSize: 23.0,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.fromLTRB(8, 5, 8, 3),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            // height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.0,
                                  color: Colors.blue[400],
                                ),
                                borderRadius: BorderRadius.circular(0)),
                            child: Material(
                              elevation: 3,
                              borderRadius: BorderRadius.circular(0),
                              shadowColor: Colors.blue,
                              child:
                                  /*  Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[ */
                                  Container(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(7, 0, 5, 5),
                                  child: data["employee_cno"] == ""
                                      ? Text(
                                          'not updoaded',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 25.0,
                                          ),
                                        )
                                      : Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            data['employee_cno'],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 25.0,
                                            ),
                                          ),
                                        ),
                                ),
                              ),
/*                                 ],
                              ), */
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 2.0, right: 5.0, top: 5.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      ' Employee designation',
                                      style: TextStyle(
                                        fontSize: 23.0,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.fromLTRB(8, 5, 8, 8),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            // height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.0,
                                  color: Colors.blue[400],
                                ),
                                borderRadius: BorderRadius.circular(0)),
                            child: Material(
                              elevation: 3,
                              borderRadius: BorderRadius.circular(0),
                              shadowColor: Colors.blue,
                              child:
                                  /* Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[ */
                                  Container(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(7, 0, 5, 5),
                                  child: data["employee_designation"] == ""
                                      ? Text(
                                          'not updoaded',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 25.0,
                                          ),
                                        )
                                      : Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            data['employee_designation'],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 25.0,
                                            ),
                                          ),
                                        ),
                                ),
                              ),
/*                                 ],
                              ), */
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                  child: data['imageUrl1'] == ""
                      ? Container()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(1, 5, 3, 8),
                                child: new Text(
                                  ' Complaint Image',
                                  style: TextStyle(
                                      fontSize: 26.0,
                                      color: Colors.blue[900],
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 350,
                                  //width: 350,
                                  /*  decoration: BoxDecoration(
                                    //color: Colors.blue[100],
                                    border: Border.all(
                                      width: 0.5,
                                      color: Colors.blue,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ), */
                                  child: Material(
                                    elevation: 10,
                                    borderRadius: BorderRadius.circular(5),
                                    shadowColor: Colors.blue,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 1,
                                        itemBuilder: (context, index) {
                                          return Container(
                                              child: data['imageUrl2'] == ""
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        child: Image.network(
                                                          data['imageUrl1'],
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ))
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0.0),
                                                      child: Row(
                                                        children: <Widget>[
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            child:
                                                                Image.network(
                                                              data['imageUrl1'],
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            child:
                                                                Image.network(
                                                              data['imageUrl2'],
                                                              fit: BoxFit.cover,
                                                            ),
                                                          )
                                                        ],
                                                      )));
                                        }),
                                  ),
                                ),
                              ),
                            ])),
            ],
          ),
        ),
      ),
    );
  }
}
