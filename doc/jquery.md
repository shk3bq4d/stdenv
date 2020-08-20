
$('#pwd').val('setvalue');
$('#id_password').is(":visible") // sometimes not enough
$('[name="remember_me"]').prop('checked', true);
e = $('#id_password'); (e.is(":hidden") || e.css("visibility") == "hidden" || e.css("opacity") == 0) // visible, maybe better, checked in one case and seemd indeed better

$(this).attr('title') // attribute value
$(this).text(); // read text
$(this).text('write text');
$(this).html();

jQuery.fn.jquery # show version



$(t).children().eq(1);     # grab the second child:
$(t).children('td').eq(1); # grab the second child <td>:
