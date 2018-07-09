@begin=javascript@
setTimeout(function() {alert(1);}, 10)


var bA = document._getElementsByXPath("//input[@type='checkbox']"); for (var k = bA.length - 1; k >= 0; --k) {bA[k].checked = true;} // zabbix template import select all box



try{
    // Try something wrong here
}
catch(e){
    var xcb="http://stackoverflow.com/search?q=[js]+"+e.message;
    window.open(xcb, '_blank');
	// https://github.com/gautamkrishnar/tcso/blob/master/javascript/tcso.js
}
@end=javascript@


# https://stackoverflow.com/questions/12977661/is-there-a-way-to-suppress-jshint-warning-for-one-given-line
@begin=javascript@
// Code here will be linted with JSHint.
// /* jshint ignore:start */
// // Code here will be ignored by JSHint.
// /* jshint ignore:end */
// // Code here will be linted with JSHint.
// You can also ignore a single line with a trailing comment like this:
//
// ignoreThis(); // jshint ignore:line
@end=javascript@

