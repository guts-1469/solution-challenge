var path = require('path')
const multer=require('multer');
const fs = require('fs-extra');
const { now } = require('moment');


const fileStrogrageEngine=multer.diskStorage({
    destination:(req,file,cb)=>{
        var type="mis";
        if(req.originalUrl==='/user/update-profile'){
            type="producer";
        }else if(req.originalUrl==='/consumer/user/update-profile'){
            type="consumer";
        }
        const dir="./images/"+type+"/";
        fs.ensureDirSync(dir);
        cb(null,dir)
    },
    filename:(req,file,cb)=>{
        var id=now();
        if(req.originalUrl==='/user/update-profile'){
            id=req.body.producer_id;
        }else if(req.originalUrl==='/consumer/user/update-profile'){
            id=req.body.consumer_id;
        }
        cb(null,id+path.extname(file.originalname));
    }
})

const upload =multer({storage:fileStrogrageEngine});

module.exports=upload;