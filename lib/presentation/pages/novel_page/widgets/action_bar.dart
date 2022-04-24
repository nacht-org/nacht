import 'package:flutter/material.dart';

class ActionBar extends StatelessWidget {
  const ActionBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Icon(Icons.favorite),
                      SizedBox(height: 4),
                      Text('Add to library'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Icon(Icons.open_in_browser),
                      SizedBox(height: 4),
                      Text('WebView'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
