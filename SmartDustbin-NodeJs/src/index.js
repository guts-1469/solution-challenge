var express=require('express');
var bodyParser = require('body-parser');
var cors = require('cors')

const multer=require('multer');
const upload=multer();
var app=express();

var http = require('http').Server(app);
var io = require('socket.io')(http);

const successlog = require('./logger');

const { now } = require('moment');

var auth=require('./api/routes/auth.route');
var dustbin=require('./api/routes/dustbin.route');
var user=require('./api/routes/user.route');

var authConsumer=require('./api/routes/auth.consumer.route');
var userConsumer=require('./api/routes/user.consumer.route');
var orderConsumer=require('./api/routes/order.consumer.route');

app.set('socket',io);


var onlineConsumers=[];
var onlineProducers=[];
var userOnlineMap={};
var onlineSocketMap={};

app.set('online_consumers',onlineConsumers);
app.set('online-producers',onlineProducers);
app.set('user_online',userOnlineMap);
app.set('online_socket',onlineSocketMap);

app.use(cors());
app.use(bodyParser.json());
app.use(maybe(upload.array()));
app.use(bodyParser.urlencoded({ extended: false }));

function maybe(fn) {
    return function(req, res, next) {
        next();
    }
}

app.use('/auth',auth);
app.use('/dustbin',dustbin);
app.use('/user',user);
app.use('/consumer/auth',authConsumer);
app.use('/consumer/user',userConsumer);
app.use('/consumer/order',orderConsumer);


io.on('connection', function(socket){
    console.log('A user connected');
    var handshakeData = socket.request;
    var userType=handshakeData._query['user_type'];
    var userId=handshakeData._query['user_id'];
    if(userType=="consumer"){
        onlineConsumers.push(socket.id);
    }else{
        onlineProducers.push(socket.id);
    }
    userOnlineMap.set(""+userId,socket.id);
    onlineSocketMap.set(""+socket.id,""+userId);

    //Whenever someone disconnects this piece of code executed
    socket.on('disconnect', function () {
       console.log('A user disconnected');
       
       const userId=onlineSocketMap.get(""+socket.id);
       if(userId!=null){
            userOnlineMap.delete(""+userId);
       }
       if(onlineConsumers.indexOf(socket.id)!=null){
        onlineConsumers.slice(onlineConsumers.indexOf(socket.id),1);
       }

       if(onlineProducers.indexOf(socket.id)!=null){
        onlineProducers.slice(onlineProducers.indexOf(socket.id),1);
       }
    });
 });


http.listen(3000,function(){
    console.log("Connected");
})