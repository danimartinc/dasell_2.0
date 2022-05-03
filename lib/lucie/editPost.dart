import '../commons.dart';

import '../services/firebase/models/product_vo.dart';
import 'editPostState.dart';


class EditPost extends StatefulWidget {
  final ResponseProductVo data;

  const EditPost({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  createState() => _EditPostState();
}

class _EditPostState extends EditPostState{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:ListView(
        children: [
          TextFormField(
            controller: TitleController,
            decoration: InputDecoration(
              hintText: "Enter title",
            ),
          ),
          TextFormField(
            controller: DescriptionController,
            decoration: InputDecoration(
              hintText: "Enter title",
            ),
          ),
          TextFormField(
            controller: PriceController,
            decoration: InputDecoration(
              hintText: "Enter title",
            ),
          ),
          TextFormField(
            controller: CategoryController,
            decoration: InputDecoration(
              hintText: "Enter title",
            ),
          ),

          InkWell(onTap: (){
            updateData();
          },child: Container(child: Text("click me"),))
        ],
      ),
    );
  }
}
