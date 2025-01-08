import 'package:flutter/material.dart';
import 'package:mtreeview/mtreeview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late double screenWidth;
  final List<TreeNode> _treeNodes = [
    TreeNode(
      isRoot: true,
      title: "Parent 1",
      children: [
        TreeNode(title: "Child 1.1"),
        TreeNode(title: "Child 1.2"),
        TreeNode(title: "Child 1.3"),
      ],
    ),
    TreeNode(
      isRoot: true,
      title: "Parent 2",
      children: [
        TreeNode(title: "Child 2.1"),
        TreeNode(title: "Child 2.2"),
      ],
    ),
    TreeNode(
      isRoot: true,
      title: "Parent 3",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Treeview(
                treeNodes: _treeNodes,
                dragWidth: screenWidth,
                showNodeConnectionLine: true,
                nodeBuilder: (TreeNode node) {

          return Padding(
            padding: EdgeInsets.only(top: 10),
            child: Container(
              height: node.isRoot ? 28 : 40,
              width: screenWidth,
              child: Row(
                children: [
                  if(!node.isRoot) ...[
                    Opacity(
                      opacity: node.children.isNotEmpty && !node.isRoot ? 1 : 0,
                      child: GestureDetector(
                        onTap: (){
                          if(node.children.isNotEmpty && !node.isRoot){
                            setState(() {
                              node.isExpanded = !node.isExpanded;
                            });
                          }
                        },
                        child: AnimatedRotation(
                          turns: node.isExpanded ? 0.5 : 0, // 0.5 = 180 degrees
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: Image.asset(
                            "assets/img/arrow_down.png",
                            scale: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                  Expanded(
                    child: Container(
                      height: node.isRoot ? 28 : 40,
                      decoration: BoxDecoration(
                          color: node.isRoot ? const Color(0xFFF4F4F5) : Colors.transparent,
                          border: Border.all(
                              width: node.isRoot ? 0 : 1,
                              color: node.isRoot ? Colors.transparent : const Color(0xFFE4E4E7)
                          ),
                          borderRadius: BorderRadius.circular(node.isRoot ? 6 : 8)
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if(node.children.isNotEmpty && node.isRoot)
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  node.isExpanded = !node.isExpanded;
                                });
                              },
                              child: AnimatedRotation(
                                turns: node.isExpanded ? 0.5 : 0, // 0.5 = 180 degrees
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                child: Image.asset(
                                  "assets/img/arrow_down.png",
                                  scale: 2,
                                ),
                              ),
                            ),
                          if(!node.isRoot)
                            Padding(padding: const EdgeInsets.only(left: 10), child: Image.asset("assets/img/gray_circle.png",scale: 2,)),
                          if(!node.isRoot)
                            Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  height: 24,
                                  width: 44,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF4F4F5),
                                      borderRadius: BorderRadius.circular(6)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/img/flag_disable.png",
                                        scale: 2,
                                      ),
                                      SizedBox(width: 3,),
                                      Image.asset(
                                        "assets/img/bolt_disable.png",
                                        scale: 2,
                                      )
                                    ],
                                  ),
                                )),

                          if(!node.isRoot)
                            const Padding(
                              padding: EdgeInsets.only(left: 13),
                              child: Text("TSK-001",style: const TextStyle(
                                color: Color(0xFF27272A),
                                fontFamily: 'InterRegular',
                                fontSize: 10,
                              ),),
                            ),

                          Padding(
                            padding: EdgeInsets.only(left: 13),
                            child: Text(node.title,style: const TextStyle(
                              color: Color(0xFF27272A),
                              fontFamily: 'InterMedium',
                              fontSize: 12,
                            ),),
                          ),

                          Image.asset("assets/img/plus.png",scale: 2,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          );
                },
              ),
        ));
  }
}
