                              sed
                    sed  sed  -r
               sed  Free -r   Free
               GNU  BSD  GNU  BSD
\s              x    x    o    x
[[:blank:]]     ?    x    o    o
$1              ?    ?    ?    x
'\1'            ?    ?    ?    o
"\1"            ?    ?    ?    o


POSIX	Description	ASCII	Unicode	Shorthand	Java
[:alnum:]	Alphanumeric characters	[a-zA-Z0-9]	[\p{L}\p{Nl}
 \p{Nd}]		\p{Alnum}
[:alpha:]	Alphabetic characters	[a-zA-Z]	\p{L}\p{Nl}		\p{Alpha}
[:ascii:]	ASCII characters	[\x00-\x7F]	\p{InBasicLatin}		\p{ASCII}
[:blank:]	Space and tab	[ \t]	[\p{Zs}\t]	\h	\p{Blank}
[:cntrl:]	Control characters	[\x00-\x1F\x7F]	\p{Cc}		\p{Cntrl}
[:digit:]	Digits	[0-9]	\p{Nd}	\d	\p{Digit}
[:graph:]	Visible characters (anything except spaces and control characters)	[\x21-\x7E]	[^\p{Z}\p{C}]		\p{Graph}
[:lower:]	Lowercase letters	[a-z]	\p{Ll}	\l	\p{Lower}
[:print:]	Visible characters and spaces (anything except control characters)	[\x20-\x7E]	\P{C}		\p{Print}
[:punct:]	Punctuation (and symbols).	[!"\#$%&'()*+,
\-./:;<=>?@\[
\\\]^_`{|}~]	\p{P}		\p{Punct}
[:space:]	All whitespace characters, including line breaks	[ \t\r\n\v\f]	[\p{Z}\t\r\n\v\f]	\s	\p{Space}
[:upper:]	Uppercase letters	[A-Z]	\p{Lu}	\u	\p{Upper}
[:word:]	Word characters (letters, numbers and underscores)	[A-Za-z0-9_]	[\p{L}\p{Nl}
 \p{Nd}\p{Pc}]	\w	\p{IsWord}
[:xdigit:]	Hexadecimal digits	[A-Fa-f0-9]	[A-Fa-f0-9]		\p{XDigit}


https://puppet.com/docs/puppet/5.0/lang_data_regexp.html
puppet sucks balls, use \A instead of ^ and \z instead of $

ipadress (vim): \(\d\+\.\)\{3\}\d\{1,3\}

if [[ "$line" =~ [a-zA-Z]+.$ ]] ; then echo "hello"; fi # regexp. Do not surrou
bar=${foo/ /.} # pseudo-regexp pattern replacement
bar=${foo// /.} # pseudo-regexp pattern replacement
grep -Po "(?<=syntaxHighlighterConfig\.)[a-zA-Z]+Color" file # look-beind zero
(?=X)       X, via zero-width positive lookahead  regexp
(?!X)       X, via zero-width negative lookahead  regexp
(?<=X)      X, via zero-width positive lookbehind regexp
(?<!X)      X, via zero-width negative lookbehind regexp
^((?!my string).)*$ # regexp not containt substring 'my string'

Construct     Matches

Characters
x     The character x
\\     The backslash character
\0n     The character with octal value 0n (0 <= n <= 7)
\0nn     The character with octal value 0nn (0 <= n <= 7)
\0mnn     The character with octal value 0mnn (0 <= m <= 3, 0 <= n <= 7)
\xhh     The character with hexadecimal value 0xhh
\uhhhh     The character with hexadecimal value 0xhhhh
\t     The tab character ('\u0009')
\n     The newline (line feed) character ('\u000A')
\r     The carriage-return character ('\u000D')
\f     The form-feed character ('\u000C')
\a     The alert (bell) character ('\u0007')
\e     The escape character ('\u001B')
\cx     The control character corresponding to x

Character classes
[abc]     a, b, or c (simple class)
[^abc]     Any character except a, b, or c (negation)
[a-zA-Z]     a through z or A through Z, inclusive (range)
[a-d[m-p]]     a through d, or m through p: [a-dm-p] (union)
[a-z&&[def]]     d, e, or f (intersection)
[a-z&&[^bc]]     a through z, except for b and c: [ad-z] (subtraction)
[a-z&&[^m-p]]     a through z, and not m through p: [a-lq-z](subtraction)

Predefined character classes
.     Any character (may or may not match line terminators)
\d     A digit: [0-9]
\D     A non-digit: [^0-9]
\s     A whitespace character: [ \t\n\x0B\f\r]
\S     A non-whitespace character: [^\s]
\w     A word character: [a-zA-Z_0-9]
\W     A non-word character: [^\w]

POSIX character classes (US-ASCII only)
\p{Lower}     A lower-case alphabetic character: [a-z]
\p{Upper}     An upper-case alphabetic character:[A-Z]
\p{ASCII}     All ASCII:[\x00-\x7F]
\p{Alpha}     An alphabetic character:[\p{Lower}\p{Upper}]
\p{Digit}     A decimal digit: [0-9]
\p{Alnum}     An alphanumeric character:[\p{Alpha}\p{Digit}]
\p{Punct}     Punctuation: One of !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~
\p{Graph}     A visible character: [\p{Alnum}\p{Punct}]
\p{Print}     A printable character: [\p{Graph}\x20]
\p{Blank}     A space or a tab: [ \t]
\p{Cntrl}     A control character: [\x00-\x1F\x7F]
\p{XDigit}     A hexadecimal digit: [0-9a-fA-F]
\p{Space}     A whitespace character: [ \t\n\x0B\f\r]

java.lang.Character classes (simple java character type)
\p{javaLowerCase}     Equivalent to java.lang.Character.isLowerCase()
\p{javaUpperCase}     Equivalent to java.lang.Character.isUpperCase()
\p{javaWhitespace}     Equivalent to java.lang.Character.isWhitespace()
\p{javaMirrored}     Equivalent to java.lang.Character.isMirrored()

Classes for Unicode blocks and categories
\p{InGreek}     A character in the Greek block (simple block)
\p{Lu}     An uppercase letter (simple category)
\p{Sc}     A currency symbol
\P{InGreek}     Any character except one in the Greek block (negation)
[\p{L}&&[^\p{Lu}]]      Any letter except an uppercase letter (subtraction)

Boundary matchers
^     The beginning of a line
$     The end of a line
\b     A word boundary
\B     A non-word boundary
\A     The beginning of the input
\G     The end of the previous match
\Z     The end of the input but for the final terminator, if any
\z     The end of the input

Greedy quantifiers
X?     X, once or not at all
X*     X, zero or more times
X+     X, one or more times
X{n}     X, exactly n times
X{n,}     X, at least n times
X{n,m}     X, at least n but not more than m times

Reluctant quantifiers
X??     X, once or not at all
X*?     X, zero or more times
X+?     X, one or more times
X{n}?     X, exactly n times
X{n,}?     X, at least n times
X{n,m}?     X, at least n but not more than m times

Possessive quantifiers
X?+     X, once or not at all
X*+     X, zero or more times
X++     X, one or more times
X{n}+     X, exactly n times
X{n,}+     X, at least n times
X{n,m}+     X, at least n but not more than m times

Logical operators
XY     X followed by Y
X|Y     Either X or Y
(X)     X, as a capturing group

Back references
\n     Whatever the nth capturing group matched, However in replaceAll, refer to groups as $n

Quotation
\     Nothing, but quotes the following character
\Q     Nothing, but quotes all characters until \E
\E     Nothing, but ends quoting started by \Q

Special constructs (non-capturing)
(?:X)     X, as a non-capturing group
(?idmsux-idmsux)      Nothing, but turns match flags i d m s u x on - off
(?idmsux-idmsux:X)       X, as a non-capturing group with the given flags i d m s u x on - off
(?=X)     X, via zero-width positive lookahead
(?!X)     X, via zero-width negative lookahead
(?<=X)     X, via zero-width positive lookbehind
(?<!X)     X, via zero-width negative lookbehind
(?>X)     X, as an independent, non-capturing group

re.search(r'\bmyword\b', mH['name']): # python word boundary
re.match(r'^debug1: (?P<mygroup1>.+) line ([0-9]+): Applying options for (.*)', s).groupdict() # python named group
