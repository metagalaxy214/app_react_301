class @Gifts
  constructor: (url)->
    @resource_url = url

  load_gifts: (callback)->
    jQuery.ajax
      url: @resource_url
      method: "GET"
      success: (response, status, xhr)=>
        @gifts = for gift in response.gifts
          {
            id:    gift.id,
            name:  gift.title,
            value: "#{gift.weeks}_week#{if gift.weeks > 1 then 's' else ''}",
            image: gift.image['url'],
            title: gift.title,
            description: gift.description,
            duration: "#{gift.weeks} week#{if gift.weeks > 1 then 's' else ''}",
            weeks: gift.weeks,
            price: parseFloat(gift.amount)
          }
        callback(@gifts)


$(document).ready ->
  window.R = React.DOM

  gifts = new Gifts("/api/gifts")

  gifts.load_gifts (gifts)->
    if $("body#gift").length
      React.renderComponent GiftPage({
        meals: gifts
        referral_code: "SOMEREFERRALCODE"
      }), $("body#gift main")[0]
