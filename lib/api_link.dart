
class AppLink {
  // Base Url
  // static const baseURL = 'http://192.168.1.103:8000/api';
  static const baseURL = 'http://10.0.2.2:8000/api';
  // Images
  // static const baseImagesURL = 'http://192.168.1.103:8000/images';
  static const baseImagesURL = 'http://10.0.2.2:8000/images';
  static const categoriesImages = baseImagesURL + '/categories';
  static const itemsImages = baseImagesURL + '/items';
  static const usersImages = baseImagesURL + '/users';
  // Auth
  static const loginURL = baseURL + '/admin/login';
  static const registerURL = baseURL + '/register';
  static const updateUserImage = baseURL + '/image/update';
  static const verifyEmail = baseURL + '/verifyEmail';
  static const sendCode = baseURL + '/sendCode';
  static const resetPassword = baseURL + '/resetPassword';
  
  //settings
   static const settings = baseURL + "/settings";
  static const order = baseURL + "/order";
  static const orderData = baseURL + '/orders';
  static const logoutURL = baseURL + '/logout';


  // static const orderData = baseURL + "/orders";
  static const deleteOrder = baseURL + "/orders/delete";
  // static const rateOrder = baseURL + "/orders/rate";
  //notifications
  static const notifications = baseURL + "/notifications";





///// Admin App
///
 // categories
   static const categories = baseURL + '/admin/categories';

 // items
  static const items = baseURL + '/admin/items';
   static const getItems = baseURL + '/admin/item/index';
   static const addItem = baseURL + '/admin/item/add';
   static const editItem= baseURL + '/admin/items/edit';
   static const deleteItem = baseURL + '/admin/item/remove';


 // orders
   static const approveOrder = baseURL + '/admin/orders/approve';
   static const pendingOrders = baseURL + "/admin/orders/pending";
   static const beingPreparedOrders = baseURL + "/admin/orders/beingPrepared";
   static const finishOrder = baseURL + '/admin/orders/finish';
   static const moveOrderToDelivery = baseURL + '/admin/orders/moveToDelivery';
   static const archivedOrders = baseURL + "/admin/orders/archive";


  //
  static const serverError = 'error';

  static const unauthorized = 'Unauthorized';
  static const somethingWentwrong = 'something went wrong';
}
