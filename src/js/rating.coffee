window.App =

  initialize: ->

    @getRating()
    @highlightRating()

    $('#clear-rating').click =>
      @clearRating()

  highlightRating: ->

    $(document).on 'mouseover', '.b-rating_vote .b-rating__item', ->
      parent = $(this).closest('.b-rating')
      value = $(this).attr('data-value') || $(this).attr('value') || $(this).find('input[type="radio"]').attr('value')
      if value
        parent.attr("class", parent.attr("class").replace(/\s*b-rating_state-[1-9]/g, "")).addClass('b-rating_state-'+value)

    $(document).on 'focus', '.b-rating_vote .b-rating__item', ->
      $(this).blur()

    $(document).on 'mouseleave', '.b-rating_vote', ->
      value = $(this).attr('data-value')
      if !value
        $(this).attr("class", $(this).attr("class").replace(/\s*b-rating_state-[1-9]/g, ""))
      else
        $(this).attr("class", $(this).attr("class").replace(/\s*b-rating_state-[1-9]/g, "")).addClass 'b-rating_state-'+value

    $(document).on 'click', '.b-rating_vote .b-rating__item', ->
      parent = $(this).closest('.b-rating')
      value = $(this).attr('data-value') || $(this).attr('value') || $(this).find('input[type="radio"]').attr('value')
      if value
        parent.attr('data-value', value)
        App.setRating value
      false

  setRating: (value)->
    #Тут должен быть какой-то ajax запрос к серверу
    #Мы для удобства просто сохраним все в localStorage

    @ratingLocalStorage.score += parseInt(value)
    @ratingLocalStorage.marks += 1

    localStorage.setItem('rating', JSON.stringify(@ratingLocalStorage))

    @showRating()

  getRating: ->

    @ratingLocalStorage = JSON.parse(localStorage.getItem('rating')) || {}
    if !@ratingLocalStorage.score || !@ratingLocalStorage.marks
      @ratingLocalStorage =
        score: 0
        marks: 0

    @showRating()

  showRating: ->

    averageVote = (if (@ratingLocalStorage.marks > 0) then @ratingLocalStorage.score / @ratingLocalStorage.marks else 0)

    $('.b-rating_results').attr("class", $('.b-rating_results').attr("class").replace(/\s*b-rating_state-[1-9]/g, "")).addClass('b-rating_state-'+Math.ceil(averageVote))
    if averageVote%1 > 0
      $('.b-rating_results').addClass 'b-rating_state-half'
    else
      $('.b-rating_results').removeClass 'b-rating_state-half'

  clearRating: ->
    @ratingLocalStorage =
      score: 0
      marks: 0
    localStorage.setItem('rating', JSON.stringify(@ratingLocalStorage))

    @showRating()


$ -> App.initialize()
