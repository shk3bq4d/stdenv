/* ex: set filetype=javascript fenc=utf-8 expandtab ts=4 sw=4 : */

```markdown
* https://jquery.com/download/
* https://api.jquery.com/category/selectors/
* https://code.jquery.com/jquery-3.6.0.js
* https://code.jquery.com/jquery-3.6.0.min.js
You can also use the slim build, which excludes the ajax and effects modules:
* https://code.jquery.com/jquery-3.6.0.slim.js
* https://code.jquery.com/jquery-3.6.0.slim.min.js
```

```js
$('#pwd').css('color', 'white'); // style="
$('#pwd').val('setvalue');
$('#pwd').length > 0 // test if element worked
$('#id_password').is(":visible") // sometimes not enough
$('[title="Ticket ID"]:visible').length
$('[name="remember_me"]').prop('checked', true);
e = $('#id_password'); (e.is(":hidden") || e.css("visibility") == "hidden" || e.css("opacity") == 0) // visible, maybe better, checked in one case and seemd indeed better
$('.id-number:visible > [title="Ticket ID"]').length

remove() - Removes the selected element (and its child elements)
empty() - Removes the child elements from the selected element.

$(this).attr('title') // attribute value
$(this).text(); // read text
$(this).text('write text');
$(this).html();
$(this).html('hehe<br />habon'); // setInnerHTML

jQuery.fn.jquery # show version



$(t).children().eq(1);     # grab the second child:
$(t).children('td').eq(1); # grab the second child <td>:

$('p:contains("mytext")').click() # p element that contains my text


$(document).ready(function() { });
  $( "tr" ).odd().addClass("odd");
  $( "tr" ).even().addClass("even");
$('a.logo-wrapper').append($('<span>').text(okta_env.toUpperCase()));
$('a.logo-wrapper').parent().append($('<span>').text(" " + okta_env.toUpperCase()));


# selectors
> # direct child, the any descendant selector is simply the space

