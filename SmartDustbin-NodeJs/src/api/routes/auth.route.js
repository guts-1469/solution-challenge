const express=require('express');

const router=express.Router();

const {sendOtp,verifyOtp,registerUser,verifyWebOtp}=require('../controllers/auth.controller');

router.post('/send-otp',sendOtp);
router.post('/verify-otp',verifyOtp);
router.post('/register-user',registerUser);
router.post('/verify-web-otp',verifyWebOtp);

module.exports=router;