
$('#id_password').is(":visible") // sometimes not enough
e = $('#id_password'); (e.is(":hidden") || e.css("visibility") == "hidden" || e.css("opacity") == 0) // visible, maybe better, checked in one case and seemd indeed better

$(this).attr('title') // attribute value
$(this).text();
$(this).html();
