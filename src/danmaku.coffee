
class Danmaku
    constructor: (@config) ->
        @el = $ @config.el
        @contents = @config.contents
        @colors = @config.colors || @config.colours
        @amount = @config.amount
        @speed = @config.speed
        @size = @config.size || "1em"
        @stop_flag = false
    start: ()->
        self = @
        @stop_flag = false
        $(@el).css "overflow-x", "hidden"
        pW = parseInt $(@el).width()
        for [0...@amount]
            setTimeout((->
                self.next_dammaku()
            ), Math.ceil(pW / @speed  * Math.random()) )
    stop: ()->
        @stop_flag = true
    next_dammaku: ->
        @new_dammaku(@sample(@contents), @sample(@colors), @next_dammaku)
    
    sample: (array)->
        array[ Math.floor array.length*Math.random() ]
        
    new_dammaku: (content, color, callback)->
        self = @
        d = document.createElement "p"
        d.innerHTML = if typeof content == "string" 
            content 
        else
            content.call()
        $(@el).append d
        d.style.position = "absolute"
        d.style.color = color
        d.style.fontSize = @size
        d.style.whiteSpace = "nowrap"
        pH = parseInt $(@el).height()
        pW = parseInt $(@el).width()
        sH = parseInt $(d).height()
        sW = parseInt $(d).width()
        d.style.left= left = pW
        d.style.top = Math.floor Math.random() * (pH - sH)
        timerId = setInterval((->
            if left > -sW
                left -= Math.ceil self.speed * 10
                d.style.left = left
            else if self.stop_flag
                clearInterval timerId
                d.remove()
            else
                clearInterval timerId
                callback and callback.call(self)
                d.remove()
        ), 10)
        