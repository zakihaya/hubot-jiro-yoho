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

        robot.http("http://jiroyoho.us/apiend.php/v3/latencys").get() (err, res, latBody) ->
          # today string for using key of latencys
          today = new Date()
          today_key = today.getFullYear() + "-" + format2Digits(today.getMonth() + 1) + "-" + format2Digits(today.getDate())

          latencys = JSON.parse(latBody)[today_key]
          for key, latency of latencys
            if key == target_shop.shopId
              target_latency = latency

          if target_latency.hours == "定休日"
            msg.send "#{shop_name}店は本日定休日です。"
          else
            msg.send "#{shop_name}店の今日の営業時間は、#{target_latency.hours} です。"
          #msg.send target_latency.latency

format2Digits = (input) ->
  ("0" + input).slice(-2)
