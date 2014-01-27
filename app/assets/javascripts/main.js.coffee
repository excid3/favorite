jQuery ->
  $("#preview").on "click", (e) ->
    terms = $.map $(".search-term"), (elem, i) ->
      $(elem).text()
    query = terms.join(" OR ") + " -RT -from:#{$(this).data("username")}"
    window.open "https://twitter.com/search?src=typd&f=realtime&q=#{encodeURIComponent(query)}", "_blank"
