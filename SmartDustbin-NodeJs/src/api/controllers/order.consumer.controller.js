
const {getOrderDetails,getAllOrders,getPickupLocations,markPickedUp,getConsumerStatistics,bookOrder}=require("../services/order.consumer.service");

const {success,error}=require("../helpers/response");


module.exports={
    bookOrder:(req,res)=>{
        const body=req.body;

        if(body.consumer_id==null){
            res.json(error(400,"consumer_id is required"));
        }

        if(body.total_distance==null){
            res.json(error(400,"total_distance is required"));
        }

        if(body.total_weight==null){
            res.json(error(400,"total_weight is required"));
        }

        if(body.producer_ids==null||body.producer_ids.length==0){
            res.json(error(400,"producer_ids is required"));
        }

        if(body.dustbin_ids==null||body.dustbin_ids.length==0){
            res.json(error(400,"dustbin_ids is required"));
        }

        if(body.total_cost==null){
            res.json(error(400,"total_cost is required"));
        }

        if(body.categories_name==null){
            res.json(error(400,"categories_name is required"));
        }

        if(body.time_from==null){
            req.json(error(400,"time_from is required"));
        }

        if(body.time_to==null){
            res.json(error(400,"time_to is required"));
        }

        if(body.pickup_date==null){
            res.json(error(400,"pickup_date is required"));
        }

        bookOrder(body,function(err,result){
            if(err){
                console.log(err);
                res.json(error(500,"Database connection error"));
            }else{
                res.json(success(result.code,result.message,result.data));
            }
        })

    },
    getOrderDetails:(req,res)=>{
        const body=req.body;

        if(body.order_id==null){
            res.json(error(400,"order_id is requied"));
        }

        getOrderDetails(body,function(err,result){
            if(err){
                res.json(error(400,"Database connection error"));
            }else{
                res.json(success(result.code,result.message,result.data));
            }
        })
    },

    getAllOrders:(req,res)=>{
        const body=req.body;

        if(body.consumer_id==null){
            res.json(error(400,"consumer_id is required"));
        }

        if(body.from_id==null){
            res.json(error(400,"from_id is required"));
        }

        getAllOrders(body,function(err,result){
            if(err){
                res.json(error(500,"Database connection error"));
            }else{
                res.json(success(result.code,result.message,result.data));
            }
        })
    },

    getPickupLocations:(req,res)=>{
        const body=req.body;

        if(body.pickup_id==null){
            res.json(error(400,"pickup_id is required"));
        }

        getPickupLocations(body,function(err,result){
            if(err){
                res.json(error(500,"Database connection error"));
            }else{
                res.json(success(result.code,result.message,result.data));
            }
        })
    },

    markPickedUp:(req,res)=>{
        const body=req.body;

        if(body.pickup_id==null){
            res.json(error(400,"pickup_id is required"));
        }

        if(body.producer_id==null){
            res.json(error(400,"producer_id is required"));
        }

        markPickedUp(body,function(err,result){
            if(err){
                console.log(err);
                res.json(error(500,"Database connection error"))
            }else{
                res.json(success(result.code,result.message,result.data));
            }
        })
    },

    getConsumerStatistics:(req,res)=>{
        const body=req.body;

        if(body.consumer_id==null){
            res.json(error(400,"consumer_id is required"));
        }

        getConsumerStatistics(body,function(err,result){
            if(err){
                res.json(error(500,"Database connection error"));
            }else{
                res.json(success(result.code,result.message,result.data));
            }
        })
    }
}