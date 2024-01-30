
var copy_html_to_clipboard = async function() { try {console.log('trying to copy, ensure page is focused'); await navigator.clipboard.writeText(document.documentElement.outerHTML);console.log('success!');}catch (e) {console.log(e); console.log("try to focus page"); setTimeout(arguments.callee, 1000);}}; setTimeout(copy_html_to_clipboard, 0);
<script type="text/javascript">
