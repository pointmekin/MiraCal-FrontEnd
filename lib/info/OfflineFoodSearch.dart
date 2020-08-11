import 'foodData.dart';

List<dynamic> alphabet = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','r','s','t','u','v','w','x','y','z'];
void bubbleSort(List<dynamic> list){
  for (int i = 0; i < list.length; i++){
    for (int j = 0; j < list.length - 1; j++){
      if (list[j][list[j].length-1] < list[j + 1][list[j+1].length-1]){
        List<dynamic> tem = list[j];
        list[j] = list[j + 1];
        list[j + 1] = tem;
      }
    }
  }
}

void addMenu (List<dynamic> menuList,List<dynamic> tem_result,String foodname,int language_index){
  for(int i = 0;i<menuList.length;i++){
    if(menuList[i][language_index].toLowerCase().contains(foodname.toLowerCase())){
      double accuracy_percent = ((foodname.length/menuList[i][language_index].length)*10000).round()/100;
      tem_result.add([menuList[i][language_index],menuList[i][2],menuList[i][4],accuracy_percent]);
    }
  }
}

List<dynamic> getRange(List<dynamic> tem_result,int endpoint){
  List<dynamic> result = [];
  for(int i = 0;i<tem_result.length && i < endpoint;i++){
    tem_result[i].removeLast();
    result.add(tem_result[i]);
  }
  return(result);
}



List<dynamic> searchingFood(String foodname){
  bool isEnglish = alphabet.contains(foodname.toLowerCase()[0]);
  int language_index = 1;
  if (isEnglish){ language_index = 0;}
  List<dynamic> tem_result = [];
  addMenu(FoodData.dessertList,tem_result,foodname,language_index);
  addMenu(FoodData.drinksList,tem_result,foodname,language_index);
  addMenu(FoodData.ingredientsList,tem_result,foodname,language_index);
  addMenu(FoodData.mealList,tem_result,foodname,language_index);
  addMenu(FoodData.snackList,tem_result,foodname,language_index);

  bubbleSort(tem_result);
  List<dynamic> result = getRange(tem_result,20);
  print(result.toString());
  print(result);
  return result;

}
//print(searching("cheese"));


