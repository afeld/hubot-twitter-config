# Description:
#   Normalized Twitter integration for hubot
#
# Notes
#   Scripts can access an ntwitter object that's authenticated via `robot.twitter`.
#   They should check that it's defined first though.
#
#   Named 1-twitter.coffee for load order
#
# Dependencies:
#    "ntwitter" : "https://github.com/sebhildebrandt/ntwitter/tarball/master",
#
# Configuration:
#   HUBOT_TWITTER_CONSUMER_KEY
#   HUBOT_TWITTER_CONSUMER_SECRET
#   HUBOT_TWITTER_ACCESS_TOKEN_KEY_<USERNAME>
#   HUBOT_TWITTER_ACCESS_TOKEN_SECRET_<USERNAME>

ntwitter = require 'ntwitter'
util = require "util"
preConfig = require("./twitter-config")


module.exports = (env) ->
  twitterConfig = preConfig(env)
  credentials = twitterConfig.defaultCredentials()
  if credentials
    credentials.rest_base = 'https://api.twitter.com/1.1'

  createNTwitter = (robot) ->
    if credentials
      new ntwitter(credentials)
    else
      robot.logger.warning("[twitter] Missing Twitter configuration, disabling twitter support : HUBOT_TWITTER_CONSUMER_KEY, HUBOT_TWITTER_CONSUMER_SECRET, HUBOT_TWITTER_ACCESS_TOKEN_KEY_<USERNAME>, and HUBOT_TWITTER_ACCES_TOKEN_SECRET_<USERNAME> are required.")
      null

  {
    credentialsFor: (username) ->
      twitterConfig.credentialsFor(username)

    defaultCredentials: credentials

    ntwitter: (robot) ->
      createNTwitter(robot)

    respondWithTwitterUsersRandomStatus: (robot, regex, screen_name) ->
      twitter = null
      robot.respond regex, (msg) ->
        twitter ||= createNTwitter(robot)
        unless twitter
          msg.send "Couldn't connect to twitter :("
          return

        twitter.getUserTimeline {screen_name: screen_name}, (err, data) ->
          if err
            msg.send "Encountered a problem getting #{screen_name}'s timeline", util.inspect(err)
            return

          status = msg.random data
          msg.send "http://twitter.com/#!/#{status.user.screen_name}/status/#{status.id_str}"
  }
