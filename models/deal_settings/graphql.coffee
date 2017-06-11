import {composeWithMongoose} from 'graphql-compose-mongoose'
import DealSettings from './mongoose'

export TC =
  DealSettingsTC: composeWithMongoose(DealSettings)