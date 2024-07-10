import express from "express"
import mongoose from "mongoose"
import cors from "cors"

const app = express()
const port = 8000
const mongourl = "mongodb://user:user@192.168.2.144:27017/us?authSource=admin"

app.use(express.json())
app.use(cors())

mongoose.connect(mongourl)
.then(()=>console.log("connected to db"))
.catch((err)=>{console.error("error connecting to db",err)})

const CitySchema = new mongoose.Schema({
  type:{type:String,required:true},
  properties:{
    name:{type:String,required:true},
    state:{type:String,required:true}
  },
  geometry:{
    type:{type:String,enum:['Point'],required:true},
    coordinates:{type:[Number],required:true,index:'2dsphere'}
  }
},{collection:'cities'})

const Cities = mongoose.model('US',CitySchema)

app.get("/search",async(req,res)=>{
  try{
    const {name} = req.query
    const results = await Cities.find({'properties.name':new RegExp(name,'i')})
    res.json(results)
  }
  catch(err){res.status(500).send(err.message)}
})

app.get("/coordinates",async(req,res)=>{
  try{
    const {latitude,longitude} = req.query
    if (!latitude || !longitude) return res.status(400).send("Latitude and longitude are required")

    const results = await Cities.find({
      geometry:{
        $near:{
          $geometry:{type:"Point",coordinates:[parseFloat(longitude), parseFloat(latitude)]},
          $maxDistance: 50000
        }
      }
    }).limit(1)

    if(results.length === 0){res.status(404).send("No cities found near the provided coordinates")}
    else{res.json(results[0])}
  }catch(err){res.status(500).send(err.message)}
})

app.listen(port,()=>console.log(`Server@${port}`))
