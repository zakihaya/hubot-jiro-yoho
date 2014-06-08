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
        shop_names = []

        shops = JSON.parse(body)
        for key, shop of shops
          shop_names.push shop.shopName
          if shop.shopName == shop_name
            target_shop = shop

        unless target_shop
          msg.send "#{shop_name}店が見つかりませんでした。検索可能な店舗一覧：#{shop_names.join(',')}"
          return


        msg.send target_shop.shopName

