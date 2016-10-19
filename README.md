# Web Static Danmaku
A simple text barrage lib for web page.

[Here is an example.](https://kaltzk.github.io/web_static_danmaku)

# Useage 

```javascript
var dmk = new Danmaku({
    amount: 30,
    speed: 15, //px per ms
    el: "#danmaku",
    contents: [
        "wwwwwwwww",
        function(){
        	return "2" + "3".repeat(Math.ceil(Math.random()*15));
        },
    ],
    colors: [
        "black",
        "red",
    ],
});
dmk.start();
```
