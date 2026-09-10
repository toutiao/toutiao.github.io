---
layout: none
---

var target = document.getElementsByClassName("sticky-top")[0];

document.onscroll = function(e){
  var percent = Math.max(document.body.scrollTop, document.documentElement.scrollTop) / 100;

  if (percent > 0.95) { percent = 0.95; }
  if (percent < 0) { percent = 0.0; }

  target.style.backgroundColor = 'rgba(255, 255, 255, ' + percent + ')';
};

document.querySelectorAll(".post-content").forEach(function(el){
  el.innerHTML = el.innerHTML.replace(/\[c:(\d+)\]/g, function(_, id){
    return '<sup><a class="c-ref" href="https://news.ycombinator.com/item?id=' + id +
      '" title="HN comment ' + id + '">⌘</a></sup>';
  });
});
