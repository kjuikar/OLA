
Parse.Cloud.define("validatesms", function(request, response) {
    var driverusername = request.params.username;
    var smscode = request.params.code;
    
    var query = new Parse.Query("SMSCode");
    var result = false;
    query.equalTo("driver_username", driverusername);
      query.each(function(user) {
      // Update to plan value passed in
        var dbcode = user.get("code");
        
        if(dbcode === smscode){
            result = true;
        }
      });
        
    response.success(result);

});
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example: 
Parse.Cloud.define("sendsms", function(request, response) {
  
  var driverusername = request.params.username;
  var text = "";
    var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

    for( var i=0; i < 6; i++ )
        text += possible.charAt(Math.floor(Math.random() * possible.length));

    // Set up to modify user data
    
  
    Parse.Cloud.httpRequest({
        method: 'POST',
        url: 'http://api.mVaayoo.com/mvaayooapi/MessageCompose',
        body: {
          user: 'k.juikar12@gmail.com:Swami@123',
          receipientno: '9881234950',
          senderID: 'OLA Cabs',
          msgtxt: 'text'
        },
        success: function(httpResponse) {
          //response.success(httpResponse.text);
          Parse.Cloud.useMasterKey();
          var query = new Parse.Query("SMSCode");
          query.equalTo("driver_username", driverusername);
            query.each(function(user) {
            // Update to plan value passed in
            user.set("code", text);
            user.save(); 
            response.success(user);
            });
        },
        error: function(httpResponse) {
          response.success('Request failed with response code ' + httpResponse.status);
        }
    });
});


Parse.Cloud.define("confirmbooking", function(request, response) {
    var status = request.params.status;

    var pushQuery = new Parse.Query(Parse.Installation);
    pushQuery.equalTo('channels', 'user');

    Parse.Push.send({
      where: pushQuery, // Set our Installation query
      data: {
        sound:"Chalonikalo.m4a",
        type:"confirm",
        status:status
      }
    }, {
      success: function() {
        response.success(status);
      },
      error: function(error) {
        throw "Got an error " + error.code + " : " + error.message;
      }
    });

});


Parse.Cloud.define("getdriverbyvehiclenumber", function(request, response) {
    var vehicleNumber = request.params.vehicle;
    var username = request.params.username;
    var userQuery = new Parse.Query(Parse.User);
    userQuery.equalTo("username", username);
    userQuery.find({
        success: function(results) {
            if(results.length > 0){
                
                var name = results[0].get("name");
                var mob = results[0].get("mobno");
                var username = results[0].get("username");

//send push notification to nearest driver
 
                var pushQuery = new Parse.Query(Parse.Installation);
                pushQuery.equalTo('channels', 'driver');

                Parse.Push.send({
                  where: pushQuery, // Set our Installation query
                  data: {
                    alert: name + " (" + mob + ")" + " wants to book a ride!!",
                    sound:"Chalonikalo.m4a",
                    username:username,
                    name:name,
                    mob:mob,
                    type:"booking"
                  }
                }, {
                  success: function() {
                    // Push was successful
                  },
                  error: function(error) {
                    throw "Got an error " + error.code + " : " + error.message;
                  }
                });
                
                var driverQuery = new Parse.Query(Parse.User);
                driverQuery.equalTo("vehicleNo", vehicleNumber);
                  driverQuery.find({
                    success: function(results) {
                      response.success(results);
                    },
                        error: function() {
                      response.error("user lookup failed");
                    }
                });
            }
        },
        error: function() {
              response.error("No Driver found.");
            }
        });
});

Parse.Cloud.define("getnearestdriver", function(request, response) {
    var username = request.params.username;
    var userQuery = new Parse.Query(Parse.User);
    userQuery.equalTo("username", username);
    userQuery.find({
        success: function(results) {
            if(results.length > 0){
                
                var name = results[0].get("name");
                var mob = results[0].get("mobno");
                var username = results[0].get("username");

//send push notification to nearest driver
 
                var pushQuery = new Parse.Query(Parse.Installation);
                pushQuery.equalTo('channels', 'driver');

                Parse.Push.send({
                  where: pushQuery, // Set our Installation query
                  data: {
                    alert: name + " (" + mob + ")" + " wants to book a ride!!",
                    sound:"Chalonikalo.m4a",
                    username:username,
                    name:name,
                    mob:mob,
                    type:"booking"
                  }
                }, {
                  success: function() {
                    // Push was successful
                  },
                  error: function(error) {
                    throw "Got an error " + error.code + " : " + error.message;
                  }
                });
                
                var driverQuery = new Parse.Query(Parse.User);
                driverQuery.equalTo("type", "driver");
                  driverQuery.find({
                    success: function(results) {
                      response.success(results);
                    },
                        error: function() {
                      response.error("user lookup failed");
                    }
                });
            }
        },
        error: function() {
              response.error("No Driver found.");
            }
        });
});