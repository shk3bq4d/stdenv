grep -l # only print matching files

grep -text

The `\' character, when followed by certain ordinary characters, takes
a special meaning:
`\b' Match the empty string at the edge of a word.  For example, `\brat\b' matches the separate word `rat', `\Brat\B' matches `crate' but not `furry rat'.
`\B' Match the empty string provided it's not at the edge of a word.
`\<' Match the empty string at the beginning of word.
`\>' Match the empty string at the end of word.
`\w' Match word constituent, it is a synonym for `[_[:alnum:]]'.
`\W' Match non-word constituent, it is a synonym for `[^_[:alnum:]]'.
`\s' Match whitespace, it is a synonym for `[[:space:]]'.
`\S' Match non-whitespace, it is a synonym for `[^[:space:]]'.
'\K' 
`[:alnum:]' Alphanumeric characters: `[:alpha:]' and `[:digit:]'; in the `C' locale and ASCII character encoding, this is the same as `[0-9A-Za-z]'.
`[:alpha:]' Alphabetic characters: `[:lower:]' and `[:upper:]'; in the `C' locale and ASCII character encoding, this is the same as `[A-Za-z]'.
`[:blank:]' Blank characters: space and tab.  
`[:cntrl:]' Control characters.  In ASCII, these characters have octal codes 000 through 037, and 177 (DEL).  In other character sets, these are the equivalent characters, if any.  
`[:digit:]' Digits: `0 1 2 3 4 5 6 7 8 9'.
`[:graph:]' Graphical characters: `[:alnum:]' and `[:punct:]'.
`[:lower:]' Lower-case letters; in the `C' locale and ASCII character encoding, this is `a b c d e f g h i j k l m n o p q r s t u v w x y z'.
`[:print:]' Printable characters: `[:alnum:]', `[:punct:]', and space.  
`[:punct:]' Punctuation characters; in the `C' locale and ASCII character encoding, this is `! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~'.  
`[:space:]' Space characters: in the `C' locale, this is tab, newline, vertical tab, form feed, carriage return, and space.  *Note Usage::, for more discussion of matching newlines.
`[:upper:]' Upper-case letters: in the `C' locale and ASCII character encoding, this is `A B C D E F G H I J K L M N O P Q R S T U V W X Y Z'.  
`[:xdigit:]' Hexadecimal digits: `0 1 2 3 4 5 6 7 8 9 A B C D E F a b c d e f'.


grep -Po 'export\K.*' ~/.bashrc # with both P (perl) and o (only print matching part), \K discards what has been matched so far. Which allow positive look behind of variable size

grep -Poz '<invoice:remark>[^<]*http[^<]*</invoice:remark>' log.txt
