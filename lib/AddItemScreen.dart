import 'package:flutter/material.dart';
import 'Product.dart';
import 'AddSelectedItemScreen.dart';
import 'SortableProduct.dart';
import  'package:string_similarity/string_similarity.dart';
import 'AddSuggestionScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  
  final List<Product> _newItems = <Product>[];
  final List<SortableProduct> _suggestions = <SortableProduct>[];
  
  
  @override
  //@mustCallSuper
  void initState() {
    super.initState();
    _readSuggestions();
  }


  void _saveSuggestions () async {
    final String savedKey = 'productDatabase';
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(savedKey, jsonEncode(_suggestions));
    print('Saved $_suggestions');
  }

  void _readSuggestions () async {
    final String savedKey = 'productDatabase';
    SharedPreferences sp = await SharedPreferences.getInstance();
      final toDecode = sp.getString(savedKey);
      print('Decoding');
      setState(() {
        
      
      if(toDecode != null) {
        _suggestions.clear();
        jsonDecode(toDecode).forEach((map) => _suggestions.add(new SortableProduct.fromJson(map)));
        print('Not null');
      }
      else {
        print('Was null');
      }
      }); 
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context, _newItems),),
        title: TextFormField(
                    autofocus: true,
                    onChanged: _sortSuggestions,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      hintText: " Search...",
                      border: InputBorder.none,
                  /*    suffixIcon: IconButton(
                        icon:Icon(Icons.search), 
                        onPressed: () {
                          
                        },
                      ), */
                    ),
                  ),
        actions: [
          IconButton(onPressed: _addSuggestion, icon: Icon(Icons.add)),
        ],  
        //backgroundColor: Colors.white,    
      ),
      body: _buildSuggestionList(),
    );
  }

  void _sortSuggestions (String searching) {
    setState(() {
    _suggestions.forEach((element) {
      element.sLevel = element.product.name.similarityTo(searching);
     });
    _suggestions.sort((b, a) => a.sLevel.compareTo(b.sLevel));
    });
  }



  Widget _buildSuggestion(SortableProduct sortableProduct) {
    final Product product = sortableProduct.product;
    return ListTile(
      title: Text('${product.name}'),
      subtitle: Text('${product.kcal} kcal, ${product.protein} P, ${product.fat} F, ${product.carbs} C'),
      onTap: () => _addItem(product),
      trailing: IconButton(onPressed: () => _removeSuggestion(sortableProduct), icon: Icon(Icons.remove)),
    );
  }

 void _addItem(Product product) async {
    final result = await Navigator.push(context, 
            MaterialPageRoute(
              builder: (context) => AddSelectedItemScreen(product)),);
             //refresh the state of your Widget
                 setState(() {
              if(result != null)
                _newItems.add(result);
                
            }
      );
  }


  void _removeSuggestion(SortableProduct sortableProduct) {
    showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Are you sure you want to delete this product?'),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _suggestions.remove(sortableProduct); 
                              _saveSuggestions();
                              Navigator.pop(context);
                          });
                          }, 
                          child: Text('Yes'),),
                        ElevatedButton(onPressed: () => Navigator.pop(context), child: Text('No'),),
                      ],
                    )
                  ],
                )
              );
            },
          );
    }


  void _addSuggestion () async {
    final result = await Navigator.push(context, 
            MaterialPageRoute(
              builder: (context) => AddSuggestionScreen()),);
             //refresh the state of your Widget
                 setState(() {
              if(result != null)
                _suggestions.add(result);
                _saveSuggestions();
            }
      );
  }

  Widget _buildSuggestionList() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _suggestions.length * 2,
      itemBuilder: (context, i) {
        if(i.isOdd) return Divider();
        final index = i~/2;
        return _buildSuggestion(_suggestions[index]);
      }
    );
  }
}

