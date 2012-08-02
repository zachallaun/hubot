# Description:
#   Hubot support for leaving messages for users.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   TBA
#
# Author:
#   zachallaun

addMessage = (data, to, from, message) ->
  if data[to.name]
    data[to.name].push [from.name, message]
  else
    data[to.name] = [[from.name, message]]

module.exports = (robot) ->
  robot.brain.on 'loaded', =>
    robot.brain.data.messages ||= {}

  robot.respond /message for (.*): (.*)/i, (msg) ->
    users = robot.usersForFuzzyName msg.match[1]
    if users.length is 1
      user = users[0]
      addMessage(robot.brain.data.messages, user, msg.message.user, msg.match[2])
      msg.send "I'll let 'em know."
    else if users.length > 1
      msg.send "Too many users could have that name!"
    else
      msg.send "I've never heard of #{msg.match[1]}"

  robot.respond /messages\?/i, (msg) ->
    if (messages = robot.brain.data.messages[msg.message.user.name])
      msg.send "from #{messg[0]}: #{messg[1]}" for messg in messages
      delete robot.brain.data.messages[msg.message.user.name]
    else
      msg.send "I've got nothin' for ya."

  robot.enter (response) ->
    if (messages = robot.brain.data.messages[response.message.user.name])
      msg.send "Hey #{response.message.user.name}, I have some messages for you."
