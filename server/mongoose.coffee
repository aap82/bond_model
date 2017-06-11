import getenv from 'getenv'
import models from '../models/mongoose'
import mongoose from 'mongoose'
import promise from 'bluebird'

mongoose.Promise = promise


mongoose.connect getenv('MONGO_DB')