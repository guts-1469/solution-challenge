const express=require('express');

const router=express.Router();
const uploader =require('../middlewares/upload.profile');


const {getAllCategories,saveMyCategories,getMyDashboard,getAllActivities,getMyCategories,getAllNotifications,getMyProfile,updateProfile,getMyTags,updateMyTags,updateMyCategories,getAllTags,getWastePrediction,getPreOrderSummary}=require('../controllers/user.consumer.controller');

router.get('/categories',getAllCategories);
router.post('/categories',saveMyCategories);
router.post('/dashboard',getMyDashboard);
router.post('/activities',getAllActivities);
router.post('/my-categories',getMyCategories);
router.post('/notifications',getAllNotifications);

router.post('/my-profile',getMyProfile);
router.post('/update-profile',uploader.single("image"),updateProfile);

router.post('/my-tags',getMyTags);
router.post('/update-tags',updateMyTags);

router.post('/update-categories',updateMyCategories);

router.get('/all-tags',getAllTags);

router.post('/waste-prediction',getWastePrediction);
router.post('/pre-order-summary',getPreOrderSummary);

module.exports=router;