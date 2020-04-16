import 'package:ROSystem/screens/AddSlot.dart';
import 'package:ROSystem/screens/addUser.dart';
import 'package:ROSystem/screens/add_category.dart';
import 'package:ROSystem/screens/add_icons.dart';
import 'package:ROSystem/screens/subCategory.dart';

import './models/home_Category_modal.dart';

List<Category> categoryList =[
  Category(
    title: 'ICON', 
    subTitle: 'April , Monday',
    imgLink: 'assets/images/addIcon.png',
    routeAddress: AddIcon.routeName
  
  ),
  Category(
    title: 'CATEGORIES',
    subTitle: 'April , Monday',
    imgLink: 'assets/images/AddCategory.png',
    routeAddress: AddCategories.routeName,
  ),
  Category(
    title: 'SUB CAT.',
    subTitle: 'HELLO',
    imgLink: 'assets/images/addSubCategory.jpg',
    routeAddress: SubCategory.routeName,
  ),
  Category(
    title: 'USER',
    subTitle: 'HELLOHII',
    imgLink: 'assets/images/createUser.png',
    routeAddress: AddUsers.routeName,
  ),
  Category(
    title: 'BUSINESS',
    subTitle: 'April , Monday',
    imgLink: 'assets/images/addBusinessType.png',
    routeAddress:'/add-business-type'
  ),
  Category(
    title: 'PERMISSIONS',
    subTitle: 'April , Moncday',
    imgLink: 'assets/images/userPermission.png',
  ),
    Category(
    title: 'SLOT',
    subTitle: 'April , Moncday',
    imgLink: 'assets/images/Slot.png',
    routeAddress:AddSlot.routeName
  ),
      Category(
    title: '',
    subTitle: '',
    imgLink: '',
  ),
      Category(
    title: '',
    subTitle: '',
    imgLink: '',
  ),

];


    