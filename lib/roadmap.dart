// connecting our app to extenral database
// 1. firebase
// 2. Go  to firebase console
// 3. create new app and test mode create a realtime database
// 4. install http package for sending http request: flutter pub add http
      // using http package
// sending posting Request
// waiting for response using then function
//working with futures 
// void main(){
  // var myFuture = Future((){
  //   return "hello";
  // });

  // print("this runs first");
  // myFuture.then((result)=>{print(result)});
  // print("This also runs before the future is done!");
// }

//showing loading indicator
//1. in products.dart return futures in addProducts() and return http.post()
//2. In the edit_product_screen.dart call then function in addProduct() in the provider
//3. add var isLoading: false in the 
//4. set isLoading to true in the saveform() function
//5. in the body render conditional widget if isLoading: CircularProgressIndicator():the main screen()