GFM: GitLab Flavored Markdown

https://docs.gitlab.com/ee/user/markdown.html

GitLab Documentation

Search
 Community Edition  Enterprise Edition  Omnibus  Runner
GitLab Enterprise Edition documentation Markdown
Markdown
GitLab Flavored Markdown (GFM)
Newlines
Multiple underscores in words
URL auto-linking
Multiline Blockquote
Code and Syntax Highlighting
Inline Diff
Emoji
Special GitLab References
Task Lists
Videos
Math
Standard Markdown
Headers
Header IDs and links
Emphasis
Lists
Links
Images
Blockquotes
Inline HTML
Horizontal Rule
Line Breaks
Tables
Footnotes
Wiki-specific Markdown
Wiki - Direct page link
Wiki - Direct file link
Wiki - Hierarchical link
Wiki - Root link
References
Markdown 

GitLab Flavored Markdown (GFM) 

Note: Not all of the GitLab-specific extensions to Markdown that are described in this document currently work on our documentation website.

For the best result, we encourage you to check this document out as rendered by GitLab: markdown.md

GitLab uses the Redcarpet Ruby library for Markdown processing.

GitLab uses "GitLab Flavored Markdown" (GFM). It extends the standard Markdown in a few significant ways to add some useful functionality. It was inspired by GitHub Flavored Markdown.

You can use GFM in the following areas:

comments
issues
merge requests
milestones
snippets (the snippet must be named with a .md extension)
wiki pages
markdown documents inside the repository
You can also use other rich text files in GitLab. You might have to install a dependency to do so. Please see the github-markup gem readme for more information.

Newlines 

If this is not rendered correctly, see https://gitlab.com/gitlab-org/gitlab-ce/blob/master/doc/user/markdown.md#newlines

GFM honors the markdown specification in how paragraphs and line breaks are handled.

A paragraph is simply one or more consecutive lines of text, separated by one or more blank lines. Line-breaks, or softreturns, are rendered if you end a line with two or more spaces:

Roses are red [followed by two or more spaces]
Violets are blue

Sugar is sweet
Roses are red
Violets are blue

Sugar is sweet

Multiple underscores in words 

If this is not rendered correctly, see https://gitlab.com/gitlab-org/gitlab-ce/blob/master/doc/user/markdown.md#multiple-underscores-in-words

It is not reasonable to italicize just part of a word, especially when you're dealing with code and names that often appear with multiple underscores. Therefore, GFM ignores multiple underscores in words:

perform_complicated_task

do_this_and_do_that_and_another_thing
perform_complicated_task

do_this_and_do_that_and_another_thing

URL auto-linking 

If this is not rendered correctly, see https://gitlab.com/gitlab-org/gitlab-ce/blob/master/doc/user/markdown.md#url-auto-linking

GFM will autolink almost any URL you copy and paste into your text:

* https://www.google.com
* https://google.com/
* ftp://ftp.us.debian.org/debian/
* smb://foo/bar/baz
* irc://irc.freenode.net/gitlab
* http://localhost:3000
https://www.google.com
https://google.com/
ftp://ftp.us.debian.org/debian/
smb://foo/bar/baz
irc://irc.freenode.net/gitlab
http://localhost:3000
Multiline Blockquote 

If this is not rendered correctly, see https://gitlab.com/gitlab-org/gitlab-ce/blob/master/doc/user/markdown.md#multiline-blockquote

On top of standard Markdown blockquotes, which require prepending > to quoted lines, GFM supports multiline blockquotes fenced by >>>:

>>>
If you paste a message from somewhere else

that

spans

multiple lines,

you can quote that without having to manually prepend `>` to every line!
>>>
If you paste a message from somewhere else

that

spans

multiple lines,

you can quote that without having to manually prepend > to every line!

Code and Syntax Highlighting 

If this is not rendered correctly, see https://gitlab.com/gitlab-org/gitlab-ce/blob/master/doc/user/markdown.md#code-and-syntax-highlighting

GitLab uses the Rouge Ruby library for syntax highlighting. For a list of supported languages visit the Rouge website.

Blocks of code are either fenced by lines with three back-ticks ```, or are indented with four spaces. Only the fenced code blocks support syntax highlighting:

Inline `code` has `back-ticks around` it.
Inline code has back-ticks around it.

Example:

```javascript
var s = "JavaScript syntax highlighting";
alert(s);
```

```python
def function():
    #indenting works just fine in the fenced code block
    s = "Python syntax highlighting"
    print s
```

```ruby
require 'redcarpet'
markdown = Redcarpet.new("Hello World!")
puts markdown.to_html
```

```
No language indicated, so no syntax highlighting.
s = "There is no highlighting for this."
But let's throw in a <b>tag</b>.
```
becomes:

var s = "JavaScript syntax highlighting";
alert(s);
def function():
    #indenting works just fine in the fenced code block
    s = "Python syntax highlighting"
    print s
require 'redcarpet'
markdown = Redcarpet.new("Hello World!")
puts markdown.to_html
No language indicated, so no syntax highlighting.
s = "There is no highlighting for this."
But let's throw in a <b>tag</b>.
Inline Diff 

If this is not rendered correctly, see https://gitlab.com/gitlab-org/gitlab-ce/blob/master/doc/user/markdown.md#inline-diff

With inline diffs tags you can display {+ additions +} or [- deletions -].

The wrapping tags can be either curly braces or square brackets [+ additions +] or {- deletions -}.

However the wrapping tags cannot be mixed as such:

{+ additions +]
[+ additions +}
{- deletions -]
[- deletions -}
Emoji 

If this is not rendered correctly, see https://gitlab.com/gitlab-org/gitlab-ce/blob/master/doc/user/markdown.md#emoji

Sometimes you want to :monkey: around a bit and add some :star2: to your :speech_balloon:. Well we have a gift for you:

:zap: You can use emoji anywhere GFM is supported. :v:

You can use it to point out a :bug: or warn about :speak_no_evil: patches. And if someone improves your really :snail: code, send them some :birthday:. People will :heart: you for that.

If you are new to this, don't be :fearful:. You can easily join the emoji :family:. All you need to do is to look up on the supported codes.

Consult the [Emoji Cheat Sheet](http://emoji.codes) for a list of all supported emoji codes. :thumbsup:
Sometimes you want to :monkey: around a bit and add some :star2: to your :speech_balloon:. Well we have a gift for you:

:zap: You can use emoji anywhere GFM is supported. :v:

You can use it to point out a :bug: or warn about :speak_no_evil: patches. And if someone improves your really :snail: code, send them some :birthday:. People will :heart: you for that.

If you are new to this, don't be :fearful:. You can easily join the emoji :family:. All you need to do is to look up on the supported codes.

Consult the Emoji Cheat Sheet for a list of all supported emoji codes. :thumbsup:

Special GitLab References 

GFM recognizes special references.

You can easily reference e.g. an issue, a commit, a team member or even the whole team within a project.

GFM will turn that reference into a link so you can navigate between them easily.

GFM will recognize the following:

input	references
@user_name	specific user
@group_name	specific group
@all	entire team
#123	issue
!123	merge request
$123	snippet
~123	label by ID
~bug	one-word label by name
~"feature request"	multi-word label by name
%123	milestone by ID
%v1.23	one-word milestone by name
%"release candidate"	multi-word milestone by name
9ba12248	specific commit
9ba12248...b19a04f5	commit range comparison
[README](doc/README)	repository file references
GFM also recognizes certain cross-project references:

input	references
namespace/project#123	issue
namespace/project!123	merge request
namespace/project%123	milestone
namespace/project$123	snippet
namespace/project@9ba12248	specific commit
namespace/project@9ba12248...b19a04f5	commit range comparison
namespace/project~"Some label"	issues with given label
It also has a shorthand version to reference other projects from the same namespace:

input	references
project#123	issue
project!123	merge request
project%123	milestone
project$123	snippet
project@9ba12248	specific commit
project@9ba12248...b19a04f5	commit range comparison
project~"Some label"	issues with given label
Task Lists 

If this is not rendered correctly, see https://gitlab.com/gitlab-org/gitlab-ce/blob/master/doc/user/markdown.md#task-lists

You can add task lists to issues, merge requests and comments. To create a task list, add a specially-formatted Markdown list, like so:

- [x] Completed task
- [ ] Incomplete task
    - [ ] Sub-task 1
    - [x] Sub-task 2
    - [ ] Sub-task 3
- [x] Completed task
- [ ] Incomplete task
- [ ] Sub-task 1
- [x] Sub-task 2
- [ ] Sub-task 3
Task lists can only be created in descriptions, not in titles. Task item state can be managed by editing the description's Markdown or by toggling the rendered check boxes.

Videos 

If this is not rendered correctly, see https://gitlab.com/gitlab-org/gitlab-ce/blob/master/doc/user/markdown.md#videos

Image tags with a video extension are automatically converted to a video player.

The valid video extensions are .mp4, .m4v, .mov, .webm, and .ogv.

Here's a sample video:

![Sample Video](img/markdown_video.mp4)
Here's a sample video:

Sample Video

Math 

If this is not rendered correctly, see https://gitlab.com/gitlab-org/gitlab-ce/blob/master/doc/user/markdown.md#math

It is possible to have math written with the LaTeX syntax rendered using KaTeX.

Math written inside $``$ will be rendered inline with the text.

Math written inside triple back quotes, with the language declared as math, will be rendered on a separate line.

Example:

This math is inline $`a^2+b^2=c^2`$.

This is on a separate line
```math
a^2+b^2=c^2
```
Becomes:

This math is inline $a^2+b^2=c^2$.

This is on a separate line

a^2+b^2=c^2
Be advised that KaTeX only supports a subset of LaTeX.

Note: This also works for the asciidoctor :stem: latexmath. For details see the asciidoctor user manual.

Standard Markdown 

Headers 

# H1
## H2
### H3
#### H4
##### H5
###### H6

Alternatively, for H1 and H2, an underline-ish style:

Alt-H1
======

Alt-H2
------
Header IDs and links 

All Markdown-rendered headers automatically get IDs, except in comments.

On hover a link to those IDs becomes visible to make it easier to copy the link to the header to give it to someone else.

The IDs are generated from the content of the header according to the following rules:

All text is converted to lowercase
All non-word text (e.g., punctuation, HTML) is removed
All spaces are converted to hyphens
Two or more hyphens in a row are converted to one
If a header with the same ID has already been generated, a unique incrementing number is appended, starting at 1.
For example:

# This header has spaces in it
## This header has a :thumbsup: in it
# This header has Unicode in it: 한글
## This header has spaces in it
### This header has spaces in it
Would generate the following link IDs:

this-header-has-spaces-in-it
this-header-has-a-in-it
this-header-has-unicode-in-it-한글
this-header-has-spaces-in-it
this-header-has-spaces-in-it-1
Note that the Emoji processing happens before the header IDs are generated, so the Emoji is converted to an image which then gets removed from the ID.

Emphasis 

Emphasis, aka italics, with *asterisks* or _underscores_.

Strong emphasis, aka bold, with **asterisks** or __underscores__.

Combined emphasis with **asterisks and _underscores_**.

Strikethrough uses two tildes. ~~Scratch this.~~
Emphasis, aka italics, with asterisks or underscores.

Strong emphasis, aka bold, with asterisks or underscores.

Combined emphasis with asterisks and underscores.

Strikethrough uses two tildes. Scratch this.

Lists 

1. First ordered list item
2. Another item
  * Unordered sub-list.
1. Actual numbers don't matter, just that it's a number
  1. Ordered sub-list
4. And another item.

* Unordered list can use asterisks
- Or minuses
+ Or pluses
First ordered list item
Another item
Unordered sub-list.
Actual numbers don't matter, just that it's a number
Ordered sub-list
And another item.
Unordered list can use asterisks
Or minuses
Or pluses
If a list item contains multiple paragraphs, each subsequent paragraph should be indented with four spaces.

1.  First ordered list item

    Second paragraph of first item.
2.  Another item
First ordered list item

Second paragraph of first item.

Another item

If the second paragraph isn't indented with four spaces, the second list item will be incorrectly labeled as 1.

1. First ordered list item

   Second paragraph of first item.
2. Another item
First ordered list item
Second paragraph of first item.

Another item
Links 

There are two ways to create links, inline-style and reference-style.

[](https://link.in.vim.with.com/correct/_/undescore/highlighting)
[I'm an inline-style link](https://www.google.com)

[I'm a reference-style link][Arbitrary case-insensitive reference text]

[I'm a relative reference to a repository file](LICENSE)

[I am an absolute reference within the repository](/doc/user/markdown.md)

[I link to the Milestones page](/../milestones)

[You can use numbers for reference-style link definitions][1]

Or leave it empty and use the [link text itself][]

Some text to show that the reference links can follow later.

[arbitrary case-insensitive reference text]: https://www.mozilla.org
[1]: http://slashdot.org
[link text itself]: https://www.reddit.com
I'm an inline-style link

I'm a reference-style link

I'm a relative reference to a repository file1

I am an absolute reference within the repository

I link to the Milestones page

You can use numbers for reference-style link definitions

Or leave it empty and use the link text itself

Some text to show that the reference links can follow later.

Note

Relative links do not allow referencing project files in a wiki page or wiki page in a project file. The reason for this is that, in GitLab, wiki is always a separate git repository. For example:

[I'm a reference-style link](style)

will point the link to wikis/style when the link is inside of a wiki markdown file.

Images 

Here's our logo (hover to see the title text):

Inline-style:
![alt text](img/markdown_logo.png)

Reference-style:
![alt text1][logo]

[logo]: img/markdown_logo.png
Here's our logo:

Inline-style:

alt text

Reference-style:

alt text

Blockquotes 

> Blockquotes are very handy in email to emulate reply text.
> This line is part of the same quote.

Quote break.

> This is a very long line that will still be quoted properly when it wraps. Oh boy let's keep writing to make sure this is long enough to actually wrap for everyone. Oh, you can *put* **Markdown** into a blockquote.
Blockquotes are very handy in email to emulate reply text. This line is part of the same quote.

Quote break.

This is a very long line that will still be quoted properly when it wraps. Oh boy let's keep writing to make sure this is long enough to actually wrap for everyone. Oh, you can put Markdown into a blockquote.

Inline HTML 

You can also use raw HTML in your Markdown, and it'll mostly work pretty well.

See the documentation for HTML::Pipeline's SanitizationFilter class for the list of allowed HTML tags and attributes. In addition to the default SanitizationFilter whitelist, GitLab allows span elements.

<dl>
  <dt>Definition list</dt>
  <dd>Is something people use sometimes.</dd>

  <dt>Markdown in HTML</dt>
  <dd>Does *not* work **very** well. Use HTML <em>tags</em>.</dd>
</dl>
Definition list
Is something people use sometimes.
Markdown in HTML
Does *not* work **very** well. Use HTML tags.
Horizontal Rule 

Three or more...

---

Hyphens

***

Asterisks

___

Underscores
Three or more...

Hyphens

Asterisks

Underscores

Line Breaks 

My basic recommendation for learning how line breaks work is to experiment and discover -- hit <Enter> once (i.e., insert one newline), then hit it twice (i.e., insert two newlines), see what happens. You'll soon learn to get what you want. "Markdown Toggle" is your friend.

Here are some things to try out:

Here's a line for us to start with.

This line is separated from the one above by two newlines, so it will be a *separate paragraph*.

This line is also a separate paragraph, but...
This line is only separated by a single newline, so it's a separate line in the *same paragraph*.

This line is also a separate paragraph, and...  
This line is on its own line, because the previous line ends with two
spaces.
Here's a line for us to start with.

This line is separated from the one above by two newlines, so it will be a separate paragraph.

This line is also begins a separate paragraph, but... This line is only separated by a single newline, so it's a separate line in the same paragraph.

This line is also a separate paragraph, and...
This line is on its own line, because the previous line ends with two spaces.

Tables 

Tables aren't part of the core Markdown spec, but they are part of GFM and Markdown Here supports them.

| header 1 | header 2 |
| -------- | -------- |
| cell 1   | cell 2   |
| cell 3   | cell 4   |
Code above produces next output:

header 1	header 2
cell 1	cell 2
cell 3	cell 4
Note

The row of dashes between the table header and body must have at least three dashes in each column.

By including colons in the header row, you can align the text within that column:

| Left Aligned | Centered | Right Aligned | Left Aligned | Centered | Right Aligned |
| :----------- | :------: | ------------: | :----------- | :------: | ------------: |
| Cell 1       | Cell 2   | Cell 3        | Cell 4       | Cell 5   | Cell 6        |
| Cell 7       | Cell 8   | Cell 9        | Cell 10      | Cell 11  | Cell 12       |
Left Aligned	Centered	Right Aligned	Left Aligned	Centered	Right Aligned
Cell 1	Cell 2	Cell 3	Cell 4	Cell 5	Cell 6
Cell 7	Cell 8	Cell 9	Cell 10	Cell 11	Cell 12
Footnotes 

You can add footnotes to your text as follows.[^2]
[^2]: This is my awesome footnote.
You can add footnotes to your text as follows.2

Wiki-specific Markdown 

The following examples show how links inside wikis behave.

Wiki - Direct page link 

A link which just includes the slug for a page will point to that page, at the base level of the wiki.

This snippet would link to a documentation page at the root of your wiki:

[Link to Documentation](documentation)
Wiki - Direct file link 

Links with a file extension point to that file, relative to the current page.

If this snippet was placed on a page at <your_wiki>/documentation/related, it would link to <your_wiki>/documentation/file.md:

[Link to File](file.md)
Wiki - Hierarchical link 

A link can be constructed relative to the current wiki page using ./<page>, ../<page>, etc.

If this snippet was placed on a page at <your_wiki>/documentation/main, it would link to <your_wiki>/documentation/related:

[Link to Related Page](./related)
If this snippet was placed on a page at <your_wiki>/documentation/related/content, it would link to <your_wiki>/documentation/main:

[Link to Related Page](../main)
If this snippet was placed on a page at <your_wiki>/documentation/main, it would link to <your_wiki>/documentation/related.md:

[Link to Related Page](./related.md)
If this snippet was placed on a page at <your_wiki>/documentation/related/content, it would link to <your_wiki>/documentation/main.md:

[Link to Related Page](../main.md)
Wiki - Root link 

A link starting with a / is relative to the wiki root.

This snippet links to <wiki_root>/documentation:

[Link to Related Page](/documentation)
This snippet links to <wiki_root>/miscellaneous.md:

[Link to Related Page](/miscellaneous.md)
References 

This document leveraged heavily from the Markdown-Cheatsheet.
The Markdown Syntax Guide at Daring Fireball is an excellent resource for a detailed explanation of standard markdown.
Dillinger.io is a handy tool for testing standard markdown.
This link will be broken if you see this document from the Help page or docs.gitlab.com ↩

This is my awesome footnote. ↩

Improve this documentation on GitLab.com
View the source code of this site


# languages syntax hightlight
markdown
Ruby
PHP
Perl
python
profile - python profiler output
xml - XML and also used for HTML with inline CSS and Javascript
css
json
javascript
coffeescript
django
apache
sql
java
delphi
applescript
cpp - C++
objectivec
ini
cs
vala
d - RDMD
rsl - RenderMan RSL
rib - RenderMan RIB
mel - Maya Embedded Language
smalltalk
lisp
clojure
nginx
diff
dos - dos batch files
bash
cmake
axapta
glsl
lc
avrasm - AVR Assembler
vhdl
parser3
tex
brainfuck
haskell
erlang
erlang-repl
rust
matlab
r
