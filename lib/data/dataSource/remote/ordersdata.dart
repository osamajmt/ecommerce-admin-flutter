
import 'package:admin_app/core/class/crud.dart';
import 'package:admin_app/api_link.dart';
class OrderData {
  Crud crud = Crud();
  OrderData(this.crud);
  getPendingOrders() async {
    try {
      final response = await crud.getData(AppLink.pendingOrders,
       {
        'Accept': 'application/json', 
        'Content-Type': 'application/json',
      });
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
  getBeaingPreparedOrders() async {
    try {
      final response = await crud.getData(AppLink.beingPreparedOrders,
       {
        'Accept': 'application/json', 
        'Content-Type': 'application/json',
      });
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
  getArchivedOrders() async {
    try {
      final response = await crud.getData(AppLink.archivedOrders,
       {
        'Accept': 'application/json', 
        'Content-Type': 'application/json',
      });
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
    approveOrder(int orderId) async {
    try {
      final response = await crud.postData("${AppLink.approveOrder}/$orderId",
      {
      },
       {
        'Accept': 'application/json', 
        'Content-Type': 'application/json',
      });
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
   finishOrder(int orderId) async {
    try {
      final response = await crud.postData("${AppLink.finishOrder}/$orderId",
      {
      },
       {
        'Accept': 'application/json', 
        'Content-Type': 'application/json',
      });
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
   moveToDelivery(int orderId) async {
    try {
      final response = await crud.postData("${AppLink.moveOrderToDelivery}/$orderId",
      {
      },
       {
        'Accept': 'application/json', 
        'Content-Type': 'application/json',
      });
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
  getOrderDetails(int orderId) async {
    try {
      final response = await crud.getData("${AppLink.orderData}/$orderId",
       {
        'Accept': 'application/json', 
        'Content-Type': 'application/json',
      });
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
}