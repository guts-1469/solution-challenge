const express=require('express');

const router=express.Router();

const {getOrderDetails,getAllOrders,getPickupLocations,markPickedUp,getConsumerStatistics,bookOrder}=require('../controllers/order.consumer.controller');


router.post('/details',getOrderDetails);
router.post('/orders',getAllOrders);
router.post('/pickup-locations',getPickupLocations);
router.post('/mark-pickup',markPickedUp);
router.post('/statistics',getConsumerStatistics);

router.post('/book-order',bookOrder);

module.exports=router;