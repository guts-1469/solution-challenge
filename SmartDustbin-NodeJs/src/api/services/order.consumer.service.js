var config=require('../../config/db');
var db=config.getConnection;
var dbPromise=config.getPromiseConnection;
var jwt = require('jsonwebtoken');
const moment = require('moment');
const { now } = require('moment');


module.exports={
    bookOrder:(data,callback)=>{
        const consumerId=data.consumer_id;
        const totalDistance=data.total_distance;
        const totalWeight=data.total_weight;
        const producerIds=data.producer_ids;
        const totalLocation=producerIds.length;
        const dustbinIds=data.dustbin_ids;
        const totalDustbin=dustbinIds.length;
        const totalCost=data.total_cost;
        const categoriesName=data.categories_name;
        const timeFrom=data.time_from;
        const timeTo=data.time_to;
        const pickupDate=data.pickup_date;
        const pickupStatus=0;
        const nowTime=moment().utc().format("YYYY-MM-DD HH:mm:ss");

        const createdAt=nowTime;
        const updatedAt=nowTime;

        const dustbinPickupData={
            consumer_id:consumerId,
            total_distance:totalDistance,
            total_weight:totalWeight,
            total_location:totalLocation,
            total_dustbin:totalDustbin,
            total_cost:totalCost,
            categories_name:categoriesName,
            time_from:timeFrom,
            time_to:timeTo,
            pickup_date:pickupDate,
            pickup_status:pickupStatus,
            created_at:createdAt,
            updated_at:updatedAt
        }

        dbPromise(async function(err,connection){
            if(err){
                return callback({code:500,error:err});
            }else{
                try{
                    await connection.beginTransaction();

                    const [dustbin_pickup]=await connection.query("INSERT INTO dustbin_pickups SET ?",dustbinPickupData);

                    const pickupId=dustbin_pickup.insertId;

                    dustbinIds.forEach(async dustbinId => {

                        var [lastPickupDustbin]=await connection.query("SELECT dustbin_id, max(DATE_FORMAT(to_date,'%Y-%m-%d')) as max_date FROM pickup_locations WHERE dustbin_id=?",[dustbinId]);
                        var lastPickup=lastPickupDustbin[0];
                        var [dayWiseDustbinOne]=await connection.query("SELECT dustbin_id FROM pickup_locations WHERE dustbin_id=? AND to_date=? AND pickup_status=1 LIMIT 1",[lastPickup.dustbin_id,lastPickup.max_date]);
                        var [dayWiseDustbinZero]=await connection.query("SELECT dustbin_id FROM pickup_locations WHERE dustbin_id=? AND to_date=? AND pickup_status=0 LIMIT 1",[lastPickup.dustbin_id,lastPickup.max_date]);
                   
                        var fromDatePrediction="";
                        var totalWeightSum=0;

                        if(dayWiseDustbinZero.length>0){
                            const zeroDustbinId=dayWiseDustbinZero[0].dustbin_id;

                            const [zeroDustbin]=await connection.query("SELECT current_capacity, DATE_FORMAT(updated_at,'%y-%m-%d') as date FROM dustbins WHERE id="+zeroDustbinId);

                            totalWeightSum+=zeroDustbin[0].current_capacity;

                            fromDatePrediction=moment(zeroDustbin[0].date, "YYYY-MM-DD").utc().add(1,'days').format("YYY-MM-DD");
                        
                        }else if(dayWiseDustbinOne.length>0){
                            fromDatePrediction=lastPickup.max_date;
                        }

                        const [predictionData]=await connection.query("SELECT sum(predicted_weight) as predicted_weight FROM dustbin_predictions WHERE date>=? AND date<=? AND dustbin_id=?",[fromDatePrediction,pickupDate,lastPickup.dustbin_id]);
                        
                        totalWeightSum+=predictionData[0].predicted_weight;

                        const [dustbins]=await connection.query("SELECT * FROM dustbins WHERE id="+dustbinId);
                        const dustbin=dustbins[0];

                        const [consumerCategory]=await connection.query("SELECT price_per_unit FROM consumer_categories WHERE consumer_id="+consumerId+" AND category_id="+dustbin.category_id);

                        const pickupLocationData={
                            pickup_id:pickupId,
                            consumer_id:consumerId,
                            category_id:dustbin.category_id,
                            producer_id:dustbin.producer_id,
                            dustbin_id:dustbinId,
                            from_date:pickupDate,
                            to_date:pickupDate,
                            total_weight:totalWeightSum,
                            total_cost:consumerCategory[0].price_per_unit,
                            pickup_status:0,
                            pickup_at:null,
                            created_at:nowTime,
                            updated_at:nowTime
                        }

                        const [pickup_location]=await connection.query("INSERT INTO pickup_locations SET ?",pickupLocationData);
                    });

                    connection.commit();
                    return callback(null,{code:200,message:"Pickup created successfully",data:null});

                }catch(error){
                    if(connection) await connection.rollback();
                    return callback({code:500,error:error});
                }finally{
                    if(connection) await connection.release();
                }
                
            }
        })
    },

    getOrderDetails:(data,callback)=>{
        const orderId=data.order_id;

        db(function(err,connection){
            if(err){
                return callback({code:500,error:err});
            }else{
                connection.query("SELECT * FROM dustbin_pickups WHERE id="+orderId,function(err,results){
                    if(err){
                        return callback({code:500,error:err});
                    }else{
                        if(results.length>0){
                            const orderDetails=results[0];

                            connection.query("SELECT categories.category_name,(consumer_categories.price_per_unit * COALESCE(sum(pickup_locations.total_weight),0)) as cost,COALESCE(sum(pickup_locations.total_weight),0) total_weight FROM pickup_locations LEFT JOIN categories ON pickup_locations.category_id=categories.id LEFT JOIN consumer_categories ON (pickup_locations.consumer_id=consumer_categories.consumer_id AND pickup_locations.category_id=consumer_categories.category_id) WHERE pickup_locations.pickup_id="+orderDetails.id+" AND pickup_locations.consumer_id="+orderDetails.consumer_id+" GROUP BY categories.category_name,pickup_locations.category_id,consumer_categories.price_per_unit",function(err,results){
                                if(err){
                                    connection.release();
                                    return callback({code:500,error:err});
                                }else{
                                    connection.release();
                                    return callback(null,{code:200,message:"Order details fetched successfully",data:results});
                                }
                            })

                        }else{
                            connection.release();
                            return callback(null,{code:301,message:"Order not found",data:null});
                        }
                    }
                })
            }
        })

    },

    getAllOrders:(data,callback)=>{
        const consumerId=data.consumer_id;
        const fromId=data.from_id;
        const maxCount=20;

        db(function(err,connection){
            if(err){
                return callback({code:500,error:err});
            }else{
                var sql="";

                if(fromId==0){
                    sql="SELECT * FROM dustbin_pickups WHERE consumer_id="+consumerId+" ORDER BY id DESC LIMIT "+maxCount;
                }else{
                    sql="SELECT * FROM dustbin_pickups WHERE consumer_id="+consumerId+" AND id<"+fromid+" ORDER BY id DESC LIMIT "+maxCount;
                }

                connection.query(sql,function(err,results){
                    if(err){
                        connection.release();
                        return callback({code:500,error:err});
                    }else{
                        connection.release();
                        return callback(null,{code:200,message:"All orders fetched successfully",data:results});
                    }
                })
            }
        })
    },

    getPickupLocations:(data,callback)=>{
        const pickupId=data.pickup_id;

        dbPromise(async function(err,connection){
            if(err){
                return callback({code:500,error:err});
            }else{

                const [dustbins]=await connection.query("SELECT pickup_locations.*,categories.category_name FROM pickup_locations LEFT JOIN categories ON pickup_locations.category_id=categories.id WHERE pickup_locations.pickup_id="+pickupId);

                var producers=[];
                var dustbinColl={};

                dustbins.forEach(dustbin => {
                    if(dustbin.producer_id in dustbinColl){
                        var dust=dustbinColl[dustbin.producer_id];
                        dust.push(dustbin);
                        dustbinColl[dustbin.producer_id]=dust;
                    }else{
                        var dust=[];
                        dust.push(dustbin);
                        dustbinColl[dustbin.producer_id]=dust;
                    }
                });


                for(key in dustbinColl){
                    const [producer]=await connection.query("SELECT id,name,phone,address,lat,lng FROM producer_user WHERE id="+key);

                    const pp={
                        producer:producer[0],
                        dustbins:dustbinColl[key]
                    }

                    producers.push(pp);
                }

                connection.release();
                return callback(null,{code:200,message:"Pickup locations fetched successfully",data:producers});
            }
        })
    },

    markPickedUp:(data,callback)=>{
        const pickupId=data.pickup_id;
        const producerId=data.producer_id;
        const nowTime=moment().utc().format("YYYY-MM-DD HH:mm:ss");

        dbPromise(async function(err,connection){
            if(err){
                return callback({code:500,error:err});
            }else{

                try{
                    await connection.beginTransaction();

                    const [pickupLocations]=await connection.query("SELECT * FROM pickup_locations WHERE pickup_id="+pickupId+" AND producer_id="+producerId);
                    const pickupLocation=pickupLocations[0];

                    if(pickupLocation.pickup_status==1){
                        await connection.rollback();
                        return callback(null,{code:300,message:"Already pickuped",data:null});
                    }

                    const [] =await connection.query("UPDATE pickup_locations SET pickup_status=1, pickup_at='"+nowTime+"', updated_at='"+nowTime+"' WHERE pickup_id="+pickupId+" AND producer_id="+producerId);

                    const [remainingPickups]=await connection.query("SELECT * FROM pickup_locations WHERE pickup_id="+pickupId+" AND pickup_status=0");
    
                    if(remainingPickups.length==null||remainingPickups.length==0){
                        const []=await connection.query("UPDATE dustbin_pickups SET pickup_status=1,updated_at='"+nowTime+"' WHERE id="+pickupId);
                    }

                
                    const title="Amount credited for waste Pickup";
                    console.log(pickupLocation.total_weight,pickupLocation.total_cost);
                    const txnAmount=(parseFloat(pickupLocation.total_weight)*parseFloat(pickupLocation.total_cost));

                    const transaction={
                        producer_id:producerId,
                        consumer_id:pickupLocation.consumer_id,
                        dustbin_id:pickupLocation.dustbin_id,
                        txn_title:title,
                        txn_amount:txnAmount,
                        txn_type:1,
                        created_at:nowTime
                    }

                    const []=await connection.query("INSERT INTO transactions SET ?",transaction);

                    const [producer]=await connection.query("UPDATE producer_user SET wallet_balance=wallet_balance+"+txnAmount+", green_balance=green_balance+"+(10*txnAmount)+" WHERE id="+producerId);


                    connection.commit();

                    const responseData={
                        pickup_id:pickupId,
                        remaining_pickups:remainingPickups.length
                    }

                    return callback(null,{code:200,message:"Pickup marked successfully",data:responseData});
                }catch(error){
                    if(connection) await connection.rollback();
                    return callback({code:500,error:error});
                }finally{
                    if(connection) await connection.release();
                }
            }
        })
    },

    getConsumerStatistics:(data,callback)=>{
        const consumerId=data.consumer_id;

        dbPromise(async function(err,connection){
            if(err){
                return callback({code:500,error:err});
            }else{
                const [total_dustbin_pickups]=await connection.query("SELECT COALESCE(sum(total_distance),0) as total_distance, COALESCE(sum(total_weight),0) as total_weight, COALESCE(sum(total_cost),0) as total_cost FROM dustbin_pickups WHERE consumer_id="+consumerId+" GROUP BY consumer_id");

                const startDate=moment().subtract(1,'weeks').utc().format("YYYY-MM-DD HH:mm:ss");
                const endDate=moment().utc().format("YYYY-MM-DD hh:mm:ss");;

                const startD=moment().subtract(1,'weeks').utc().format("YYYY-MM-DD");
                const endD=moment().utc().format("YYYY-MM-DD");;

                const [category_distribution]=await connection.query("SELECT COALESCE(sum(pickup_locations.total_weight),0) as total_weight, tags.tag_name,DATE_FORMAT(created_at,'%a') as day FROM pickup_locations LEFT JOIN consumer_tags ON consumer_tags.consumer_id=pickup_locations.consumer_id INNER JOIN tags ON tags.id=consumer_tags.tag_id WHERE pickup_locations.consumer_id="+consumerId+" AND pickup_locations.created_at>='"+startDate+"' AND pickup_locations.created_at<='"+endDate+"' AND pickup_locations.pickup_status=1 GROUP BY tags.tag_name,DATE_FORMAT(created_at,'%a')");

                const [food_waste_distribution]=await connection.query("SELECT COALESCE(sum(total_weight),0) as total_weight, DATE_FORMAT(pickup_date,'%d %M') as date FROM dustbin_pickups WHERE consumer_id="+consumerId+" AND pickup_status=1 GROUP BY pickup_date ORDER BY pickup_date LIMIT 7");

                const [day_cost_distribution]=await connection.query("SELECT COALESCE(sum(total_cost),0) as total_cost, DATE_FORMAT(pickup_date,'%d %M') as date FROM dustbin_pickups WHERE consumer_id="+consumerId+" AND pickup_date>='"+startD+"' AND pickup_date<='"+endD+"' AND pickup_status=1 GROUP BY pickup_date ORDER BY pickup_date DESC LIMIT 7");
                
                const [distance_distribution]=await connection.query("SELECT COALESCE(sum(total_distance),0) as total_distance, DATE_FORMAT(pickup_date,'%d %M') as date FROM dustbin_pickups WHERE consumer_id="+consumerId+" AND pickup_date>='"+startD+"' AND pickup_date<='"+endD+"' AND pickup_status=1 GROUP BY pickup_date ORDER BY pickup_date DESC LIMIT 7");

                const responseData={
                    total_dustbin_pickups:total_dustbin_pickups[0],
                    category_distribution:category_distribution,
                    food_waste_distribution:food_waste_distribution,
                    day_cost_distribution:day_cost_distribution,
                    distance_distribution:distance_distribution
                }

                connection.release();
                return callback(null,{code:200,message:"Consumer statistics fetched successfully",data:responseData});
            }
        })
    }
}