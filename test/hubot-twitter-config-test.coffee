expect = require 'expect.js'
config = require '../lib/hubot-twitter-config'

describe 'hubot-twitter-config', ->
  describe '.ntwitter()', ->
    dummyEnv = ->
      {
        HUBOT_TWITTER_CONSUMER_KEY: 'consumerkey'
        HUBOT_TWITTER_CONSUMER_SECRET: 'consumersecret'
        HUBOT_TWITTER_ACCESS_TOKEN_KEY_FOO: 'fookey'
        HUBOT_TWITTER_ACCESS_TOKEN_SECRET_FOO: 'foosecret'
      }

    it 'gives back an ntwitter instance', ->
      twitter = config(dummyEnv()).ntwitter({})
      expect(twitter.verifyCredentials).to.be.a('function')
