module.exports = (robot) ->
  robot.respond /i\'?ve made a (huge )?mistake/i, (msg) ->
    msg.send "http://media.tumblr.com/tumblr_m7g1lknxyj1r9d28t.gif"
