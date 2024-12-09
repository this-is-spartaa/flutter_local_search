import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            maxLines: 1,
            onSubmitted: (value) {
              // TODO 검색하기
            },
            decoration: InputDecoration(
              hintText: '검색어를 입력해 주세요',
              border: MaterialStateOutlineInputBorder.resolveWith(
                (states) {
                  if (states.contains(WidgetState.focused)) {
                    return OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black),
                    );
                  }
                  return OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey),
                  );
                },
              ),
            ),
          ),
        ),
        body: ListView.separated(
          padding: EdgeInsets.all(20),
          itemCount: 10, // TODO data binding
          separatorBuilder: (context, index) => SizedBox(height: 20),
          itemBuilder: (context, index) {
            // TODO data binding
            return GestureDetector(
              onTap: () {
                // TODO DetailPage
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey[300]!,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '코엑스',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('문화,예술>컨벤션센터'),
                    Text('서울특별시 강남구 영동대로 513'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
