// =======================02/08/2021=======================================
// Managing auth locally
// Wrap the material app in a consumer<Auth> in main.dart: this is to ensure that it rebuild when ever auth changes
// Go to auth.dart and create a getter isAuth for checking authentcation status
// also create token for getting token
//using ternary operator to display auth_screen or product_overview_screen depending on the auth status
//set the _token and _userId if there is no error in the auth.dart : _token = resonseData.['idToken'] and notify listener

// using proxyprovider and attaching token to our request
//For us to attach token into our requests we must add paramater into the classes and accept it throught its constructors
// add  final String authToken in products.dart and initialize it through the constructor
//You can now append auth to the request urls
// To append request token to togglefavroutestatus() you will need to accept the token in the method at product.dart
// retrieve the token through provider at product_item.dart and pass it to where you called the function

//We will also need to make the token available to the orders screen
//accept the token through the orders constructor
//supply the token to orders through changenotifierproxyprovider() as we did in products

// adding logout feature
// go to auth.dart and create a logout method that resets _token, _userId and _expiryDate
//add logout buton in the app drawer and call logout method through the provider

//Adding auto logout
//add autoLogout method in auth.dart
// you can achieve that by setting up a timer found in dart:async


//=====================28/07/2021========================================
//1. adding login
//get the sign url from firebase auth api: the paramter are thesame as signup
//go to auth.dart and add login method
//add authenticate method that handles both signup and login because there request is identical
// go to auth_screen.dart and start using the sign : login should work now
//2. Handling errors during signup and login
// wrap the request in a try ... catch.. blocks
//use if statements to check if the response message contains any error message
//create a custom exception class for throwing errors
//in the auth_screen wrap the login and sign calls in try catch block under _submit()
//catch any http error
//create _showErrorDialog to display error message in error occurs in auth_screen




//==================== 26/07/2021=========================================
//Adding sign and login to our app
//Go to Realtime database and change the rules to "auth!=null"
// go to authentication tab and enable emal/password sign-in option unser sign-in methods
// add AuthScreen
//create auth.dart provider
//provide it in main.dart so that it will be available to different part of your app
//create signup method that accept email and password
//send a sign up request to firebase auth rest api: docs @ https://firebase.google.com/docs/reference/rest/auth
//you can get your web api key from settings in firebase


// =================== 24/07/2021=========================================
// fetching and setting orders
// 1. add fetchAndSetOrders() method in  orders.dart
// 2. create _isLoading variable to wait for fetching and setting in orders_screen.dart
// 3. use ternary operatory to display spinner while fetching orders


// =================== 20/07/2021=========================================
// 1. updating favorite status on the web
// modify  toggleFavouriteStatus() in product.dart
// 2. Storing orders in the web
// modify the addOrder in the orders.dart by making it future async
// make order now() button not clickable if the cart is empty in cart_screen.dart
// extract the flatbutton in cart_screen to stateful widget to display spinner with order is clicked



// ===============================================================================================================
// using asyc and await
//to use async and await in add async before the body of the code
// ... async { ...}
//with this you can get rid of .then() instead you add await to any future event ...{ await http.post()}
//async  function return something by default therefore there is no need for return keyword
// when using async function, then catchError function will be replace by 
// try{...}
// catch(error){...} finall{...} blocks

// fetching records from firebase
// 1. create fechAndSetProduct() in the products provider
// 2. in the product overview screen, call the function in the initstate using future delay helper function
// 3. display loading spinners when fetching data

// adding pull and refresh to part of our app
// 1. in the userproduct.dart page
// 2. Wrap the body with RefreshIndicator() widget
// 3. add onRefresh function  the widget
// 4. from function make a call to fetchAndSetProduct

//updating  product using patch
// 1. convert updateProduct to Future by adding async keyword and 
// 2. make a patch request to firebase and pass the id of the product
// 3. add await keyworkd to provider at EditProductScreen

//Deleteing data

