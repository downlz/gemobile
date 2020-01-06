import 'package:graineasy/model/order.dart';

getShippingAddress(Order orderitem){
  String shipaddr;
  if (orderitem.isshippingbillingdiff == true) {

    shipaddr =  orderitem.shippingaddress.addridentifier.partyname +
        " " +
        orderitem.shippingaddress.addridentifier.gstin +
        " " +
        orderitem.shippingaddress.text +
        " " +
        orderitem.shippingaddress.state.name +
        " " +
        orderitem.shippingaddress.pin +
        " " +
        orderitem.shippingaddress.phone;
  } else if (orderitem.isshippingbillingdiff == false) {
    shipaddr =  orderitem.shippingaddress.addridentifier.partyname +
        " " +
        orderitem.buyer.name +
        " " +
        orderitem.buyer.gst +
        " " +
        orderitem.address +
        " " +
        orderitem.buyer.phone;
  } else {
    shipaddr =  orderitem.buyer.name +
        " " +
        orderitem.buyer.gst +
        " " +
        orderitem.buyer.addresses[0].text +
        " " +
        orderitem.buyer.addresses[0].city.name +
        " " +
        orderitem.buyer.addresses[0].city.state.name +
        " " +
        orderitem.buyer.addresses[0].pin +
        " " +
        orderitem.buyer.phone;
  }
  return shipaddr;
}