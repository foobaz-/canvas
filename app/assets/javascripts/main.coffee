window.mousedown = false
window.dots = []
window.mousePos = {x: 0, y: 0}

window.requestAnimFrame = do () ->
  window.requestAnimationFrame       or
  window.webkitRequestAnimationFrame or
  window.mozRequestAnimationFrame    or
  window.oRequestAnimationFrame      or
  window.msRequestAnimationFrame     or
  (callback) ->
    window.setTimeout(callback, 1000 / 60)

class Dot
  constructor: (@pos, @canvas) ->
    @ctx = canvas.getContext("2d")
    @radius = 5
    @color = 'black'
    @draw()

  draw: () ->
    @ctx.beginPath()
    @ctx.arc(@pos.x, @pos.y, @radius, 0, 2 * Math.PI, false)
    @ctx.closePath()
    @ctx.fillStyle = @color
    @ctx.fill()

  move: (toPosition) ->
    @pos = toPosition

  getPos: () ->
    @pos

animate = () ->
  window.requestAnimFrame(animate)
  draw()

draw = () ->
  window.ctx.clearRect(0, 0, window.canvas.width, window.canvas.height)
  for dot in window.dots
    do (dot) ->

      dx = (window.mousePos.x - dot.getPos().x)
      dy = (window.mousePos.y - dot.getPos().y)

      magn = Math.sqrt(Math.pow(dx, 2) + Math.pow(dy, 2))
      console.log(magn)

      if not magn < 1
        ndx = dx/magn
        ndy = dy/magn
        newPos = {x: dot.getPos().x + ndx, y: dot.getPos().y + ndy}
        dot.move(newPos)

        window.ctx.lineWidth = 1
        window.ctx.beginPath()
        window.ctx.moveTo(dot.getPos().x, dot.getPos().y)
        window.ctx.lineTo(window.mousePos.x, window.mousePos.y)
        window.ctx.stroke()
        dot.draw()

onMouseDown = (e) ->
  # e.preventDefault()
  mousedown = true
  window.dots.push new Dot {x: e.pageX, y: e.pageY}, window.canvas
  $('#mouseCoords').html(e.pageX + ', ' + e.pageY)
  $('#mouseCoords').append "<p>Click!</p>"

onMouseUp = (e) ->
  mousedown = false

onMouseMove = (e) ->
  $('#mouseCoords').html(e.pageX + ', ' + e.pageY)
  window.mousePos = {x: e.pageX, y: e.pageY}


$(document).ready ->
  window.canvas = $('#mycanvas').get(0)
  window.ctx = window.canvas.getContext("2d")

  document.addEventListener "mousedown", onMouseDown
  # document.addEventListener "mouseup", onMouseDown
  document.addEventListener "mousemove", onMouseMove

  centerX = window.canvas.width / 2
  centerY = window.canvas.height / 2

  animate()




