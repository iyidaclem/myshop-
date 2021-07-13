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

