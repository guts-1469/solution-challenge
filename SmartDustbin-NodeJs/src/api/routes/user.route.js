const express=require('express');

const router=express.Router();
const uploader =require('../middlewares/upload.profile');

const {getUserActivities,getUserNotifications,updateProfile,getTransactions,getDashboard,getStatistics,getAverageWaste,getWasteDistribution,getRecoveryDistribution,testArduino}=require("../controllers/user.controller");

router.post('/activities',getUserActivities);
router.post('/notifications',getUserNotifications);
router.post('/update-profile',uploader.single("image"),updateProfile);
router.post('/transactions',getTransactions);

router.post('/dashboard',getDashboard);
router.post('/statistics',getStatistics);

router.post('/statistics/average-waste',getAverageWaste);
router.post('/statistics/waste-distribution',getWasteDistribution);
router.post('/statistics/recovery-distribution',getRecoveryDistribution);

router.get('/test',testArduino);

module.exports=router;