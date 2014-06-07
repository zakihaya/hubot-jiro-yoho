# Description:
#   Shop info of Jiro.
#
# Commands:
#   hubot jiro-yoho <query> - Searches jiro shop info.

module.exports = (robot) ->
  # store    http://jiroyoho.us/apiend.php/v3/shops
  # waiting  http://jiroyoho.us/apiend.php/v3/latencys
  robot.respond /JIRO-YOHO (.*)$/i, (msg) ->
    shop_name = msg.match[1]
    robot.http("http://jiroyoho.us/apiend.php/v3/shops")
      .get() (err, res, body) ->
        shops = JSON.parse(body)
        msg.send msg.match[1]

