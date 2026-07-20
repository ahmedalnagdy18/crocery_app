import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_project/data/models/item_model.dart';
import 'package:hive_project/ui/cubits/crocery_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController iconController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  @override
  void dispose() {
    iconController.dispose();
    titleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CroceryCubit, CroceryState>(
      listener: (context, state) {
        //
      },
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: Builder(
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: FloatingActionButton(
                  onPressed: () {
                    showBottomSheet(
                      backgroundColor: Colors.grey.shade200,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: iconController,
                                decoration: InputDecoration(
                                  counterText: '',
                                  hintText: 'icon',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                ),
                                maxLength: 10,
                              ),
                              SizedBox(height: 22),
                              TextField(
                                controller: titleController,
                                decoration: InputDecoration(
                                  counterText: '',
                                  hintText: 'title',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                ),
                                maxLength: 10,
                              ),
                              SizedBox(height: 40),
                              MaterialButton(
                                onPressed: () {
                                  if (titleController.text.isNotEmpty ||
                                      iconController.text.isNotEmpty) {
                                    context.read<CroceryCubit>().addItem(
                                      ItemModel(
                                        icon: iconController.text,
                                        name: titleController.text,
                                      ),
                                    );
                                    iconController.clear();
                                    titleController.clear();
                                    Navigator.pop(context);
                                  }
                                },
                                color: Colors.blue,
                                child: Text('Add'),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.add),
                ),
              );
            },
          ),
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Color(0xFFF7F9FF),
            title: Text(
              'Packing List',
              style: TextStyle(color: Color(0xFF00668A)),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  context.read<CroceryCubit>().clearAllItem();
                },
                icon: Icon(
                  Icons.delete_forever_outlined,
                  color: Color(0xFF00668A),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      if (state is CroceryLoaded) {
                        final item = state.item[index];
                        return itemCard(
                          icon: item.icon,
                          tilte: item.name,
                          isSelected: item.isSelected,
                          onTap: () {
                            context.read<CroceryCubit>().updateItem(item);
                          },
                        );
                      }
                      return SizedBox();
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 8),
                    itemCount: state is CroceryLoaded ? state.item.length : 0,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget itemCard({
  required Function()? onTap,
  required String icon,
  required String tilte,
  required bool isSelected,
}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Color(0xFFEEF4FF),
    ),
    child: Row(
      children: [
        Text(
          icon,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(width: 16),
        Text(
          tilte,
          style: TextStyle(
            color: isSelected == true ? Colors.grey : Colors.black,
            fontSize: 16,
            decoration: isSelected == true
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        Spacer(),
        isSelected == true
            ? SizedBox()
            : GestureDetector(
                onTap: onTap,
                child: Icon(
                  Icons.check_circle,
                  size: 40,
                  color: Color(0xFF00BFFF),
                ),
              ),
      ],
    ),
  );
}
