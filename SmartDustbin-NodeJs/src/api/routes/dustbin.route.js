const express=require('express');

const router=express.Router();

const {getAllDustbins,getDustbinDetails,requestNewDustbin,getAllCategories,getDustbinWasteDistribution,addDustbinData,getDustbinWebDetail}=require("../controllers/dustbin.controller");


router.get('/get-my-dustbins/:producer_id',getAllDustbins);
router.get('/get-dustbin-detail/:dustbin_id',getDustbinDetails);

router.post('/request-dustbin',requestNewDustbin);
router.get('/get-categories',getAllCategories);

router.post('/waste-distribution',getDustbinWasteDistribution);

router.post('/add-data',addDustbinData);

router.get('/get-web-dustbin-detail/:dustbin_id',getDustbinWebDetail);

module.exports=router;