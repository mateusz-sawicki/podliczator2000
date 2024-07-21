import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:podliczator2000/provider/database_provider.dart';

class ProcedureSearch extends StatefulWidget {
  const ProcedureSearch({super.key});

  @override
  State<ProcedureSearch> createState() => _ProcedureSearchState();
}

class _ProcedureSearchState extends State<ProcedureSearch> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final provider = Provider.of<DatabaseProvider>(context, listen: false);
      provider.searchText = '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    final controller = TextEditingController();

    return Container(
      height: 42,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.black26),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        autofocus: true,
        onChanged: (value) {
          provider.searchText = value;
        },
        controller: controller,
        decoration: InputDecoration(
          icon: const Icon(
            Icons.search,
            color: Colors.black54,
          ),
          suffixIcon: GestureDetector(
            child: const Icon(Icons.close, color: Colors.black54),
            onTap: () {
              controller.clear();
              provider.searchText = '';
              FocusScope.of(context).requestFocus(FocusNode());
            },
          ),
          hintText: 'Wyszukaj procedurę',
          hintStyle: const TextStyle(color: Colors.black54),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
        ),
      ),
    );
  }
}
