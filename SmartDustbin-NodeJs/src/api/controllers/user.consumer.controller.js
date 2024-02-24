
const {getAllCategories,saveMyCategories,getMyDashboard,getAllActivities,getMyCategories,getAllNotifications,getMyProfile,updateProfile,getMyTags,updateMyTags,updateMyCategories,getAllTags,getWastePrediction,getPreOrderSummary}=require("../services/user.consumer.service");

const {success,error}=require("../helpers/response");


module.exports={
    getAllCategories:(req,res)=>{
        getAllCategories(null,function(err,result){
            if(err){
                res.json(error(500,"Database connection error"));
            }else{
                res.json(success(result.code,result.message,result.data));
            }
        })
    },

    saveMyCategories:(req,res)=>{
        const body=req.body;

        console.log(body);

        if(body.consumer_id==null){
            res.json(error(400,"consumer_id is required"));
        }

        if(body.selected_categories==null||body.selected_categories.length==0){
            res.json(error(400,"selected_categories is required"))
        }

        console.log("tets");

        saveMyCategories(body,function(err,result){
            if(err){
                console.log(err);
                res.json(error(500,"Database connection error"));
            }else{
                res.json(success(result.code,result.message,result.data));
            }
        })
    },

    getMyDashboard:(req,res)=>{
        const body=req.body;

        if(body.consumer_id==null){
            res.json(error(400,"consumer_id is required"));
        }

        getMyDashboard(body,function(err,result){
            if(err){
                res.json(error(500,"Database connection error"));
            }else{
                res.json(success(result.code,result.message,result.data));
            }
        })
    },

    getWastePrediction:(req,res)=>{
        const body=req.body;

        if(body.consumer_id==null){
            res.json(error(400,"consumer_id is required"));
        }

        if(body.category_ids==null){
            res.json(error(400,"category_ids required"));
        }

        getWastePrediction(body,function(err,result){
            if(err){
                res.json(error(500,"Database connection error"));
            }else{
                res.json(success(result.code,result.message,result.data));
            }
        })
    },
    
    getPreOrderSummary:(req,res)=>{
        const body=req.body;

        if(body.consumer_id==null){
            res.json(error(400,"consumer_id is required"));
        }

        if(body.category_ids==null||body.category_ids.length==0){
            res.json(error(400,"category_ids is required"));
        }

        if(body.dustbin_ids==null||body.dustbin_ids.length==0){
            res.json(error(400,"dustbin_ids is required"));
        }

        if(body.date==null||body.date==""){
            res.json(error(400,"date is required"));
        }

        getPreOrderSummary(body,function(err,result){
            if(err){
                res.json(error(500,"Database connection error"));
            }else{
                res.json(success(result.code,result.message,result.data));
            }
        })
    },

    getAllActivities:(req,res)=>{
        const body=req.body;

        if(body.consumer_id==null){
            res.json(error(400,"consumer_id is required"));
        }

        if(body.from_id==null){
            res.json(error(400,"from_id is required"));
        }

        getAllActivities(body,function(err,result){
            if(err){
                req.json(error(500,"Database connection error"));
            }else{
                res.json(success(result.code,result.message,result.data));
            }
        })
    },

    getMyCategories:(req,res)=>{
        const body=req.body;

        if(body.consumer_id==null){
            res.json(error(400,"consumer_id is required"));
        }

        getMyCategories(body,function(err,result){
            if(err){
                res.json(error(500,"Database connection error"));
            }else{
                res.json(success(result.code,result.message,result.data));
            }
        })
    },

    getAllNotifications:(req,res)=>{
        const body=req.body;

        if(body.consumer_id==null){
            res.json(error(400,"consumer_id is required"));
        }

        if(body.from_id==null){
            res.json(error(400,"from_id is required"));
        }

        getAllNotifications(body,function(err,result){
            if(err){
                res.json(error(500,"Database connection error"));
            }else{
                res.json(success(result.code,result.message,result.data));
            }
        })
    },

    getMyProfile:(req,res)=>{
        const body=req.body;

        if(body.consumer_id==null){
            res.json(error(400,"consumer_id is required"));
        }

        getMyProfile(body,function(err,result){
            if(err){
                res.json(error(500,"Database connection error"));
            }else{
                res.json(success(result.code,result.message,result.data));
            }
        })
    },

    updateProfile:(req,res)=>{
        var body=req.body;

        if(body.consumer_id==null){
            res.json(error(400,"consumer_id is required"));
        }

        if(body.consumer_name==null||body.consumer_name==""){
            res.json(error(400,"consumer_address is required"));
        }

        if(body.consumer_address==null||body.consumer_address==""){
            res.json(error(400,"consumer_address is required"));
        }

        if(req.file==null){
            body.profile="";
        }else{
            body.profile=req.file.filename;
        }


        updateProfile(body,function(err,result){
            if(err){
                res.json(error(500,"Database connection error"));
            }else{
                res.json(success(result.code,result.message,result.data));
            }
        })
    },

    getMyTags:(req,res)=>{
        const body=req.body;

        if(body.consumer_id==null){
            res.json(error(400,"consumer_id is requied"));
        }

        getMyTags(body,function(err,result){
            if(err){
                console.log(err);
                res.json(error(500,"Database connection error"));
            }else{
                res.json(success(result.code,result.message,result.data));
            }
        })
    },

    updateMyTags:(req,res)=>{
        const body=req.body;

        if(body.consumer_id==null){
            res.json(error(400,"consumer_id is required"));
        }

        if(body.tag_ids==null||body.tag_ids.length==0){
            res.json(error(400,"tag_ids are required"));
        }

        updateMyTags(body,function(err,result){
            if(err){
                res.json(error(400,"Database connection error"));
            }else{
                res.json(success(result.code,result.message,result.data));
            }
        })
    },

    updateMyCategories:(req,res)=>{
        const body=req.body;

        if(body.consumer_id==null){
            res.json(error(400,"consumer_id is required"));
        }

        if(body.selected_categories==null||body.selected_categories.length==0){
            res.json(error(400,"selected_categories are required"));
        }

        updateMyCategories(body,function(err,result){
            if(err){
                res.json(error(500,"Database connection error"));
            }else{
                res.json(success(result.code,result.message,result.data));
            }
        })
    },

    getAllTags:(req,res)=>{
        getAllTags(null,function(err,result){
            if(err){
                res.json(error(500,"Database connection error"));
            }else{
                res.json(success(result.code,result.message,result.data));
            }
        })
    }
}