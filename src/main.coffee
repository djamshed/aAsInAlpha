$ ->
  init()



map = {
  a:'lpha (Al fah)',
  b:'ravo (Brah Voh)',
  c:'harlie (Char Lee)',
  d:'elta (Dell Tah)',
  e:'cho (Eck Oh)',
  f:'oxtrot (Foks Trot)',
  g:'olf (Golf)',
  h:'otel (Hoh Tell)',
  i:'ndia (In Dee Ah)',
  j:'uliett (Jew Lee Ett)',
  k:'ilo (Key Loh)',
  l:'ima (Lee Mah)',
  m:'ike (Mike)',
  n:'ovember (No Vem Ber)',
  o:'scar (Oss Car)',
  p:'apa (Pah Pah)',
  q:'uebec (Keh Beck)',
  r:'omeo (Row Me Oh)',
  s:'ierra (See Air Ah)',
  t:'ango (Tang Go)',
  u:'niform (You Nee Form)',
  v:'ictor (Vik Tah)',
  w:'hiskey (Wiss Key)',
  x:' Ray (Ecks Ray)',
  y:'ankee (Yang Key)',
  z:'ulu (Zoo Loo)'
}

fontSize = (len) ->
  switch
    when len < 5 then 100
    when len < 10 then 90
    when len < 15 then 85
    when len < 20 then 80
    when len < 25 then 75
    when len < 30 then 70
    else 50

addWord = ($container, i, letter) ->
  placeholder = $container.find '.word-'+ i
  word = if map[letter.toLowerCase()]? then '<span class="oversize">'+letter.toUpperCase()+'</span>'+ map[letter.toLowerCase()] else ''
  html = '<div class="word word-' + i + '" data-letter="'+letter+'"><div class="undersize">'+(i+1)+'</div>' + word + '</div>'

  if placeholder.length > 0
    if placeholder.attr('data-letter') isnt letter
      # existing letter changed, update the word
      placeholder.attr 'data-letter':letter
      placeholder.html html

  else
    $container.append html



removeUnused = ($container, max) ->
  words = $container.find '.word'

  if words.length > max
    $('.word-'+i).remove() for i in [max..words.length]


init = () ->

  $letters = $ '#letters'
  $words = $ '#words'

  # input key handler
  $letters.keyup (e) ->
    txt = $letters.val()
    newSize = fontSize txt.length

    #dynamically change the input width and font size
    $letters.css fontSize: newSize + 'px', width: (txt.length + 1) + 'ch'

    # add words
    addWord $words, i, letter for letter, i in txt.split ''

    # remove unused words (in case user deletes)
    removeUnused $words, txt.length

    # set URL hash, so that it is bookmarkable
    window.location.hash = txt


  # set initial value and trigger keyup
  txt = decodeURIComponent window.location.hash.replace '#',''
  $letters.val(txt).keyup()

