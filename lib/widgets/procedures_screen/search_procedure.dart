import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:podliczator2000/provider/database_provider.dart';

class ProcedureSearch extends StatefulWidget {
  const ProcedureSearch({super.key});

  @override
  State<ProcedureSearch> createState() => _ProcedureSearchState();
}

class _ProcedureSearchState extends State<ProcedureSearch> {
  int? _value;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final provider = Provider.of<DatabaseProvider>(context, listen: false);
      provider.searchText = '';
      provider.getProcedures(int.parse(_value.toString()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    final controller = TextEditingController();

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        children: [
          Container(
            height: 42,
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
          ),
          Consumer<DatabaseProvider>(builder: (_, db, __) {
            var priceLists = db.priceLists;
            priceLists.sort((b, a) => a.id.compareTo(b.id));
            _value ??= priceLists.firstWhere((x) => x.isActive == 1).id;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Wrap(
                    spacing: 5.0,
                    children: List<Widget>.generate(
                      priceLists.length,
                      (index) {
                        return ChoiceChip(
                          label: Text(priceLists[index].name),
                          selected: _value == priceLists[index].id,
                          onSelected: (bool selected) {
                            setState(() {
                              _value = selected ? priceLists[index].id : null;
                            });
                            provider.setActivePriceList(priceLists[index].id);
                            provider.getProcedures(priceLists[index].id);
                          },
                        );
                      },
                    ).toList(),
                  )
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}
