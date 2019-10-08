changelog upgrade version latest update # https://confluence.atlassian.com/doc/confluence-release-notes-327.html
upgrade version latest update # https://www.atlassian.com/software/confluence/download-archives 

www_confluence_help.sh
http://confluence/renderer/notationhelp.action?section=all

Notation Guide
Print Help Tips
Sections
ALL
Headings
Text Effects
Text Breaks
Links
Lists
Images
Tables
Advanced Formatting
Confluence Content
External Content
Misc
Macros
Help Tips Headings
To create a header, place "hn. " at the start of the line (where n can be a number from 1-6).

Notation	Comment
h1. Biggest heading	
Biggest heading
h2. Bigger heading	
Bigger heading
h3. Big Heading	
Big Heading
h4. Normal Heading	
Normal Heading
h5. Small Heading	
Small Heading
h6. Smallest Heading	
Smallest Heading
Help Tips Text Effects
Text effects are used to change the formatting of words and sentences.

Notation	Comment
*strong*	Makes text strong. bold
_emphasis_	Makes text emphasis. 
??citation??	Makes text in citation.
-strikethrough-	Makes text as strikethrough.
+underlined+	Makes text as underlined.
^superscript^	Makes text in superscript.
~subscript~	Makes text in subscript.
{{text will be monospaced}}	Makes text as code text.
bq. Some block quoted text	To make an entire paragraph into a block quotation, place "bq. " before it.
Example:

Some block quoted text
{quote}
here is quoteable
content to be quoted
{quote}	
Quote a block of text that's longer than one paragraph.

Example:
here is quoteable
content to be quoted
{color:red} 
look ma, red text! 
{color}	 Changes the color of a block of text.
Example: look ma, red text!

Help Tips Text Breaks
Most of the time, explicit paragraph breaks are not required - Confluence will be able to paginate your paragraphs properly.

Notation	Comment
(empty line)	Produces a new paragraph
\\	Creates a line break. Not often needed, most of the time Confluence will guess new lines for you appropriately.
----	creates a horizontal ruler
---	Produces — symbol.
--	Produces – symbol.
Help Tips Links
Links are the heart of Confluence, so learning how to create them quickly is important.

Notation	Comment
[#anchor]
[^attachment.ext]
or
[pagetitle]
[pagetitle#anchor]
[pagetitle^attachment.ext]
or
[spacekey:pagetitle]
[spacekey:pagetitle#anchor]
[spacekey:pagetitle^attachment.ext]	Creates an internal hyperlink to the specified page in the desired space (or the current one if you don't specify any space). Appending the optional '#' sign followed by an anchor name will lead into a specific bookmarked point of the desired page. Also having the optional '^' followed by the name of an attachment will lead into a link to the attachment of the desired page.
Example: pagetitle

If such a page doesn't already exist, it will allow you to create the page in the current space. Create page links will have a Create new page: anewpage after them.

Example: anewpageCreate new page: anewpage

[link alias|#anchor|link tip]
[link alias|^attachment.ext|link tip]
or
[link alias|pagetitle|link tip]
[link alias|pagetitle#anchor|link tip]
[link alias|pagetitle^attachment.ext|link tip]
or
[link alias|spacekey:pagetitle|link tip]
[link alias|spacekey:pagetitle#anchor|link tip]
[link alias|spacekey:pagetitle^attachment.ext|link tip]	Creates an internal hyperlink to the specified page in the desired space (or the current one if you don't specify any space) where the link text is different from the actual hyperlink link. Also you can have an optional link tip which will apear as tooltip. Appending the optional '#' sign followed by an anchor name will lead into a specific bookmarked point of the desired page. Also having the optional '^' followed by the name of an attachment will lead into a link to the attachment of the desired page.
Example: link alias

[/2004/01/12/Blog Post] [spacekey:/2004/01/12/Blog Post]	Creates an internal hyperlink to the specified blog post in the desired space (or the current one if you don't specify any space). You must specify the date the post was made in /year/month/day form as shown. Anchors and link text can be added the same way as described above.
If you attempt to link to a blog post that doesn't exist, no link will be created.

Example:

/2004/01/12/Blog Post
my link name
[/2004/01/12]
[spacekey:/2004/01/12]
or
[my link name|/2004/01/12]
[my link name|spacekey:/2004/01/12]	Creates an internal hyperlink to a view of a whole day's news. Specify the date you wish to link to as year/month/day. Link titles can be supplied as with other links. It is possible to link to days with no news items on them: the destination page will just be empty.
Examples:

/2004/01/12/Blog Post
my link name
[$12345]
or
[my link name|$12345]	Creates a link to a piece of content by its internal database ID. This is currently the only way to link to a mail message.
Examples:

Re: Webwork 2 Upgrade
my link name
[spacekey:]
[custom link title|spacekey:]
Creates a link to the space homepage, or space summary page of a particular space. Which of these the link points to depends on the configuration of the space being linked to. If the space does not exist, the link will be drawn with a strike-through to indicate it is an invalid space.
Examples:

spacekey
custom link title
[nosuchspace:]
[~username]
[custom link title|~username]
Creates a link to the user profile page of a particular user. By default, will be drawn with a user icon and the user's full name, but if you supply a custom link text, the icon will not be drawn. If the user being linked to does not exist, the link will be drawn with a strike-through.
Examples:

User Full Name
custom link title
[~nosuchuser]
[phrase@shortcut]
[custom link text|phrase@shortcut]	Creates a shortcut link to the specified shortcut site. Shortcuts are configured by the site administrator. You can add a link title to shortcuts in the same manner as other links.
Examples:

confluence@Google
custom link text
[http://confluence.atlassian.com]
[Atlassian|http://atlassian.com]	Creates a link to an external resource, special characters that come after the URL and are not part of it must be separated with a space. External links are denoted with an arrow icon.
Note: the [] around external links are optional in the case you do not want to use any alias for the link.

Examples:

http://confluence.atlassian.com>>
Atlassian>>
[mailto:legendaryservice@atlassian.com]	Creates a link to an email address, complete with mail icon.
Example:  >>legendaryservice@atlassian.com

[file://c:/temp/foo.txt]
[file://z:/file/on/network/share.txt]	
This only works on Internet Explorer 
Creates a link to file on your computer or on a network share that you have mapped to a drive

{doc:/display/DOC/Confluence+Documentation+Home}Confluence Documentation{doc}	
A macro that allows you to quickly create links to content at http://confluence.atlassian.com.

Default parameter — The link to the content relative to http://confluence.atlassian.com.
Macro body — The link text, interpreted as wiki markup.
{anchor:anchorname}	 Creates a bookmark anchor inside the page. You can then create links directly to that anchor. So the link [My Page#here] will link to wherever in "My Page" there is an {anchor:here} macro, and the link [#there] will link to wherever in the current page there is an {anchor:there} macro.
Help Tips Lists
Lists allow you to present information as a series of ordered items.

Notation	Comment
* some 
* bullet 
** indented 
** bullets 
* points	A bulleted list (must be in first column). Use more (**) for deeper indentations.
Example: 
some
bullet
indented
bullets
points
- different 
- bullet 
- types	A list item (with -), several lines create a single list.
Example: 
different
bullet
types
# a 
# numbered 
# list	A numbered list (must be in first column). Use more (##, ###) for deeper indentations.
Example: 
a
numbered
list
# a 
# numbered 
#* with 
#* nested 
#* bullet 
# list

* a 
* bulletted 
*# with 
*# nested 
*# numbered 
* list

You can even go with any kind of mixed nested lists:
Example: 
a
numbered
with
nested
bullet
list

a
bulletted
with
nested
numbered
list
{dynamictasklist:thingsToDo}	
The Dynamic Tasklist Macro displays a task list which can be modified in the page as it is viewed. Despite the fact that this plugin has an ajax UI, it is still fully versioned like a normal Confluence page.

Example: 
What you need to type	What you will get
{dynamictasklist:Arthurs To-Do's}	
{checklist:name=The animals| parent=Animals|checklabels=mammal, oviparous, pets}

{checklist:name=Oviparious|parent=Animals|excerpt-heading=Classification|label=oviparous|checklabels=fish, amphibians, reptiles, birds|mutuallyexclusive=true}

{checklist:name=The pets| parent=demo:Animals| label=pets| excerpt-heading=Classification| comment-heading=Comments}

Generates a checklist for a subset of pages. The rows are children pages of a given page (parent) and can be filtered by a label. The columns can be labels that are set/un-set for the pages, the excerpt or a text.

The columns of the checklist can also be defined using the {checklist-label}, {checklist-input}, {checklist-wikiinput}, {checklist-select}, {checklist-excerpt}, {checklist-include}, {checklist-wiki}, {checklist-metadata} macros.

Generates a checklist for a subset of pages. The rows are children pages of a given page (parent) and can be filtered by a label.

The columns can be labels that are set/un-set for the pages, the excerpt or a text. You can set/unset the tag in the row pages and edit the text.

Parameters value can have any of the following keywords that will be replace when rendering the page:

Keyword	 Value
@user@	 current user's name
@userfullname@	 current user's full name
@self@ or title	 the title of the page owning the checklist
@creator@	 the page creator's user name
@modifier@	 the last modifier's user name
@any other value name@	 the given metadata value in the page owning the checklist

parameter	 Mandatory?	 Default	 description
name or unnamed
first parameter	 no	 current page's name	 the name of the checklist
parent	 no	 	 the parent page, if not set, and there is no label set either, then the page containing the checklist will be used as such
label	 no	 	 the label the selected must have
space	 no	 	 the space to reduce the query to, when using label only and no parent
depth	 no	0	 depth of the search for children ('0' for no limit)
childrenonly	 no	false	 whether or not parent-children are to be included
sort	 no	name	 How the table should be sorted: name to sort by name, created to sort by page creation date, or modified to sort by last modification date
checklabels	 no	 	 a comma separated list of labels to be used to 'check' the pages
mutuallyexclusive	 no	false	 whether or not the checklabels are mutually exclusive
excerpt-heading	 no	 	 the heading for the excerpt column
comment	 no	 	 the heading for a column to be used for comments
class	 no	grid	 the style sheet (CSS) class to use for the table
pagelink	 no	true	 whether or not to include a link to the pages as the first column of the table
Examples

Lets say we have a page Animals as parent of the pages Dog, Cat, Shark, Elephant, Turtle, Salmon, Snake, Whale, Frog, Toad, Lizard, Platypus and Eagle.

In the first example, all the children of Animals are shown. The checks are for the labels mammal, oviparous and pets. Whenever any the check is selected, the appropriate label is added/removed to/from the page on the row.


In the second example, the excerpt of each page is shown, and it will show only the children of Animals that have the label oviparous and the check labels bird, fish, amphibian and reptile are mutually exclusive.


In the third example, only the children of Animals that have the label pets are shown. The excerpt of each page is shown and a comment can be added to each page in the checklist


Note how the comment text can be actual wiki content.

{checklist-label:Mammal?|label=mammal}	
When used within a {checklist} macro, it defines a column as a label check. Every time a cell of this column is selected, the label will be added/removed to/from the referred page

parameter	 Mandatory?	 Default	 description
heading or unnamed
first parameter	 yes	 	 The heading of the column
label	 no	 the heading	 The label to be used to 'check' the pages
width	 no	 	 width of the column
class	 no	 	 the style sheet (CSS) class to use for the cells
readonly	 no	false	 whether or not the column is read-only
Example

{checklist:name=Pets|parent=Animals|label=pets}
   {checklist-label:Mammal?|label=mammal}
{checklist}
Will render as:

{checklist-input:Common pet names|cols=20}	
When used within a {checklist} macro, it defines a column as a text input.

parameter	 Mandatory?	 Default	 description
heading or unnamed
first parameter	 yes	 	 The heading of the column
cols	 yes	 	 The maximum number of characters read
width	 no	 	 width of the column
class	 no	 	 the style sheet (CSS) class to use for the cells
readonly	 no	false	 whether or not the column is read-only
sorttype	 no	S	 Type of value to be used to sort the table by this column. Values could be any of A, C, D, F, I, S, as defined in the Table Plugin
store	no	rows	 Determines where to store the value. Use rows to store the values for this column into the pages representing each row (metadata value name is <Column Heading>), or checklist to store the values into the page containing the checklist (metadata value name is <Column Heading>.<Row page title>)
Example

{checklist:name=Pets names|parent=Animals|label=pets}
   {checklist-input:Common pet names|cols=20}
{checklist}
Will render as:

{checklist-wikiinput:Comments| rows=5| cols=20| width=90%}	
When used within a {checklist} macro, it defines a column as a wiki-text input.

parameter	 Mandatory?	 Default	 description
heading or unnamed
first parameter	 yes	 	 The heading of the column
cols	 yes	 	 The number of columns in the text area when editing the value
rows	 no	1	 The number of rows in the text area when editing the value
width	 no	 	 width of the column
class	 no	 	 the style sheet (CSS) class to use for the cells
readonly	 no	false	 whether or not the column is read-only
sorttype	 no	S	 Type of value to be used to sort the table by this column. Values could be any of A, C, D, F, I, S, as defined in the Table Plugin
store	no	rows	 Determines where to store the value. Use rows to store the values for this column into the pages representing each row (metadata value name is <Column Heading>), or checklist to store the values into the page containing the checklist (metadata value name is <Column Heading>.<Row page title>)
Example

{checklist:name=The pets| parent=Animals| label=pets}
    {checklist-wikiinput:Comments|rows=5|cols=20|width=90%}
{checklist}
Will render as:

{checklist-select:Can swim?}
yes
no
{checklist-select}

{checklist-select:Type|uselabels=true}
fish|It's a fish
amphibians|It's an amphibian
reptiles|It's a reptile
birds|It's a bird
{checklist-select}

{checklist-select:Who owns one?|usersgroup=all}
When used within a {checklist} macro, it defines a column as a selection (drop-down menu). The selection can be from a list of options, a list of labels or a list of users.

parameter	 Mandatory?	 Default	 description
heading or unnamed
first parameter	 yes	 	 The heading of the column
uselabels	 no	false	 instead of setting a metadata value, add the selected label
usersgroup	 no	 	 instead of listing the value, use the given users group to select from a list of users. Use all for listing all the users
width	 no	 	 width of the column
class	 no	 	 the style sheet (CSS) class to use for the cells
readonly	 no	false	 whether or not the column is read-only
sorttype	 no	S	 Type of value to be used to sort the table by this column. Values could be any of A, C, D, F, I, S, as defined in the Table Plugin
store	no	rows	 Determines where to store the value. Use rows to store the values for this column into the pages representing each row (metadata value name is <Column Heading>), or checklist to store the values into the page containing the checklist (metadata value name is <Column Heading>.<Row page title>)
macro body	 	 	 If no usersgroup is given, the options to select from have to be defined as part of the body. Each line of the body define an option. Each option could have a different value from the actual caption by defining it as <value>|<caption>
If store is set to checklist and there is only one option to select from, then the column is handled as a checkbox.

Examples

{checklist:name=Swimmers|parent=Animals|label=oviparous}
   {checklist-select:Can swim?}
      yes
      no
   {checklist-select}
{checklist}
Will render as:

{checklist:name=The oviparious|parent=Animals|label=oviparous}
   {checklist-select:Type|uselabels=true}
       fish|It's a fish
       amphibians|It's an amphibian
       reptiles|It's a reptile
       birds|It's a bird
   {checklist-select}
{checklist}
Will render as:

{checklist:name=Pets on the team|parent=Animals|label=pets}
   {checklist-select:Who owns one?|usersgroup=all}
{checklist}

Will render as:

{checklist-wiki:Photo}
!photo.jpg!
{checklist-wiki}
When used within a {checklist} macro, it defines a column as a wiki segment to be rendered for each of the pages on the checklist.

parameter	 Mandatory?	 Default	 description
heading or unnamed
first parameter	 yes	 	 The heading of the column and the metadata value name
width	 no	 	 width of the column
class	 no	 	 the style sheet (CSS) class to use for the cells
sorttype	 no	S	 Type of value to be used to sort the table by this column. Values could be any of A, C, D, F, I, S, as defined in the Table Plugin
macro body	 	 	 the wiki segment to be rendered for each page on the checklist
Example

Assuming each of the pages contains an attachment photo.jpg

{checklist:name=Da pets|parent=Animals|label= pets}
   {checklist-wiki:Photo}
       !photo.jpg!
   {checklist-wiki}
{checklist}
Will render as:

{checklist-excerpt:Classification|width=10%}	
When used within a {checklist} macro, it defines a column as the excerpt of each of the pages.

parameter	 Mandatory?	 Default	 description
heading or unnamed
first parameter	 yes	 	 The heading of the column
width	 no	 	 width of the column
class	 no	 	 the style sheet (CSS) class to use for the cells
sorttype	 no	S	 Type of value to be used to sort the table by this column. Values could be any of A, C, D, F, I, S, as defined in the Table Plugin
Example

{checklist:name=pets| parent=Animals| label=pets}
    {checklist-excerpt:Classification|width=10%}
{checklist}
Will render as:

{checklist-pagelink:Edit|destination=view|width=10%}	
When used within a {checklist} macro, it defines a column as a link to each of the pages.

parameter	 Mandatory?	 Default	 description
heading or unnamed
first parameter	 yes	 	 The heading of the column
destination	 no	view	 the link should go to (view or edit)
width	 no	 	 width of the column
class	 no	 	 the style sheet (CSS) class to use for the cells
sorttype	 no	S	 Type of value to be used to sort the table by this column. Values could be any of A, C, D, F, I, S, as defined in the Table Plugin
{checklist-include:Full page}	
When used within a {checklist} macro, it defines a column as the entire content of each of the pages.Use with caution, it can get really messy.

parameter	 Mandatory?	 Default	 description
heading or unnamed
first parameter	 yes	 	 The heading of the column
width	 no	 	 width of the column
class	 no	 	 the style sheet (CSS) class to use for the cells
sorttype	 no	S	 Type of value to be used to sort the table by this column. Values could be any of A, C, D, F, I, S, as defined in the Table Plugin
Example

{checklist:name=All the pet's pages|parent=Animals|label= pets}
   {checklist-include:Full page}
{checklist}
Will render as:

{checklist-metadata:Comments}
When used within a {checklist} macro, it defines a column as a lookup of existing metadata for each page.

parameter	 Mandatory?	 Default	 description
heading or unnamed
first parameter	 yes	 	 The heading of the column and the metadata value name
width	 no	 	 width of the column
class	 no	 	 the style sheet (CSS) class to use for the cells
sorttype	 no	S	 Type of value to be used to sort the table by this column. Values could be any of A, C, D, F, I, S, as defined in the Table Plugin
Example

{checklist:name=The pets names|parent=Animals|label=pets}
   {checklist-metadata:Comments}
{checklist}
Will render as:

{checklist-attribute:attribute=Common pet names}

{checklist-attribute:page=confluence:Cat| attribute=Comments}

Displays the value of an attribute set on a page through a {checklist}

parameter	 description
page	 (optional) title of the page to lookup. If none set, then the current page will be used
attribute	Name of the attribute (column) set in the checklist


The first example on the side will display fido, dino... if the segment is in the Dog page
The second example on the side will display If you are a cat person... from any page

{checklist-log:format=useranddate| maxentries=1|Comments}	
Generates a checklist change report for a given page.

parameter	 Mandatory?	 Default	 description
page	 no	 current page	 The title of the page to generate the report from
maxentries	 no	0 (no limit)	 The maximum number of entries to report (0 for no limit)
maxentriespername	 no	0 (no limit)	 The maximum number of entries per value name (0 for no limit)
mostrecentfirst	 no	false	 whether or not display the most recent entry first
format	 no	detailed	 Defines the way each of log entries is to be reported:
date : display only the date
dateanduser: display the date and use
detailed: display all the available information
newvalue: display only the new value
oldvalue: display only the last value
simple: display date, user and new value in a single line
user: display only the user
useranddate: display the user and date
remaining 
unnamed parameters	 no	 	 each remaining unnamed parameters in the macro indicate what name values are to be included in the report. If none set, the report will include all the value names
Example

{checklist-log:format=useranddate|maxentries=1|Comments}
Will render as:

{checklist-column:heading=Classification| type=excerpt| width=5%}
{checklist-column:heading=Mammal| type=label| label=mammal}
{checklist-column:heading=Comments| type=text| cols=30| readonly=true}
{checklist-column:heading=Common pet names| type=text| rows=5| cols=20}
This macro is being deprecated. Use {checklist-label}, {checklist-excerpt} or {checklist-wikiinput} instead.

Defines more detailed column information for a {checklist}.

parameter	 Mandatory?	 Default	 description
heading	 yes	 	 Heading of the column
type	 yes	 	 type of column. It can be any of label, text or excerpt
label	 yes, if
type=label	 	 the label to be used to 'check' the pages
rows	 yes, if
type=text	 	 rows when editing text area
cols	 yes, if
type=text	 	 cols when editing text area
width	 no	 	 width of the of column
readonly	 no	false	 whether or not the column is read-only
Note that the {checklist-column} macro must be contained within a {checklist} macro.

Help Tips Images
Images can be embedded into Confluence pages from attached files or remote sources.

Notation	Comment
!http://www.host.com/image.gif! 
or 
!attached-image.gif!	Inserts an image into the page.
If a fully qualified URL is given the image will be displayed from the remote source, otherwise an attached image file is displayed.

!spaceKey:pageTitle^image.gif! 

!/2007/05/23/My Blog Post^image.gif!	Inserts an image that is attached on another page or blog post.
If no space key is defined, the current is space is used by default.

!image.jpg|thumbnail!	
Insert a thumbnail of the image into the page (only works with images that are attached to the page). Users can click on the thumbnail to see the full-sized image.

Thumbnails must be enabled by the site administrator for this to work.

!image.gif|align=right, vspace=4!	
For any image, you can also specify attributes of the image tag as a comma separated list of name=value pairs like so.

{gallery} 

{gallery:columns=3} 

{gallery:title=Some office photos, and a waterfall|columns=3} 

{gallery:title=Some office photos, without the waterfall|exclude=waterfall.jpg} 

{gallery:title=One office photo, and a waterfall|include=office1.jpg,waterfall.jpg} 

{gallery:title=Some office photos, and a waterfall|page=Gallery of Pictures} 

{gallery:title=Some office photos, and a waterfall|page=DOC:Gallery of Pictures} 

{gallery:title=Some office photos, and a waterfall|sort=name} 

{gallery:title=Some office photos, and a waterfall|sort=date|reverse=true}	
Create a gallery of thumbnails of all images attached to a page. This will only work on pagesthat allow attachments, obviously.

The title parameter allows you to supply a title for the gallery

The columns parameter allows you to specify the number of columns in the gallery (by default, 4)

The exclude parameter allows you to specify the name of attached images to ignore (i.e., they will not be included in the gallery). You can specify more than one picture, separated by commas. Example: exclude=my picture.png,my picture2.gif

The include parameter allows you to specifically include one or more attached images. The gallery will show only those pictures. You can specify more than one picture, separated by commas. Example: include=my picture.png,my picture2.gif

The page parameter allows you specify the title of one or more pages which contains the images you want displayed. If a page is in the same space as the page containing the macro, use the format page=My Page Name. To specify a page in a different space, use page=SPACEKEY:My Page Name, such as page=DOC:Gallery Macro. You can specify more than one page, separated by commas. Example: page=Image Gallery,STAFF:Group Photos

If a page or attachment file name contains a comma, you can use it in the include, exclude, or page parameters by enclosing it in single or doublequotes. Example: include="this,that.jpg",theother.png

The sort parameter allows you to control the order of the images. The options are name,comment, date, or size.

The reverse parameter is used in conjunction with the sort parameter to reverse the order of the specified sort. Valid values are true and false.

Previous versions of the Gallery macro had an additional slideshow parameter. This is no longer used in the latest version, and the slide show is always enabled. We have left the parameter here for compatibility with older versions of the macro.

Help Tips Tables
Tables allow you to organise content in a rows and columns, with a header row if required.

Notation	Comment
||heading 1||heading 2||heading 3|| 
|col A1|col A2|col A3| 
|col B1|col B2|col B3|	Makes a table. Use double bars for a table heading row. Note that each table-row has to be defined on a single line.
The code given here produces a table that looks like:

heading 1	heading 2	heading 3
col A1	col A2	col A3
col B1	col B2	col B3
{column:width=50%}
Text in this column.
{column}	
Defines a single column.

width: - (optional) the width of the column.
Must be defined in a section macro.
{section}

{column:width=30%}
Column one text goes here
{column}

{column:width=70%}
Column two text goes here
{column}

{section}


{section:border=true}
...
{section}	
If you want to use columns instead of tables, you can define them first by marking a {section}, and then placing any number of {column}s inside.

border: - (optional) set to "true" to draw a border around the section and columns.
{csv} 
, January, February, March, April 
Max, 37.5, 32.7, 28.0, 25.3 
Min, 31.3, 26.8, 25.1, 18.7 
{csv} 

{csv:output=wiki|width=900|border=15|delimiter=whitespace} 
Month Max Min Average 
January 25.5	*6.3* 15.9 
February 32.4	12.8 22.6 
March 44.6	24.5 34.6 
April 59.7	37.1 48.4 
May 72.5	48.7 60.6 
June 81.3	57.9 69.6 
July 85.2	62.8 74 
August 82.5	60.7 71.6 
September 73.7	51.7 62.7 
October 61.1	40.1 50.6 
November 43.6	27.4 35.5 
December 29.9 13.6 21.8 
{csv} 
Converts csv and other deliminated data into a table. CSV is not a formal standard, but the best reference is The Comma Separated Value (CSV) File Format. The support in this macro comes close to following this pseudo-standard. For more details see SCRP-16. This macro shares common table capabilities with other table based macros (excel, table-plus, and sql).

output - Determines how the output is formated:
html - Data is output as a HTML table (default).
wiki - Data is output as a Confluence wiki table. Use this option if you want data within the table to be formated by the Confluence wiki renderer.
script - Location of csv data. Default is the macro body only. If a location of data is specified, the included data will follow the body data.
#filename - Data is read from the file located in confluence home directory/script/filename. Subdirectories can be specified.
global page template name - Data is read from a global page template.
space:page template name - Data is read from a space template.
^attachment - Data is read from an attachment to the current page.
page^attachment - Data is read from an attachment to the page name provided.
space:page^attachment - Data is read from an attachment to the page name provided in the space indicated.
url - Specifies the URL of an csv file. If a url location is specified, the included data will follow the body and script data. Use of this parameter may be restricted for security reasons. See your administrator for details.
heading - Number of rows to be considered heading rows (default is 1 row). Specify heading=false or heading=0 to not show any heading lines.
border - The border width in pixels. Defaults to normal table border width.
width - The table width in pixels. Default is 100%.
delimiter - Delimiter that separates columns. Note that trailing delimiters on a line result in a blank column at the end of the row.
, or "," (comma) - The default column separator.
whitespace - Blanks, tabs, and other white space are used to separate columns.
blanks - Blank or blanks only.
other single character delimiter - may be within double quotes with some restictions. Examples: ";", "=",
quote - the character used to represent quoted data. Quoted data may contain delimiters or new lines. Quote character data must be doubled inside a quoted string.
double - Double quote character (default).
single - Single quote character.
escape - When wiki output is requested (output=wiki), some special characters (like '|', '[', ']', '{', '}') in data may cause undesirable formatting of the table. Set escape=true to allow these special characters to be escaped so that it will not affect the formatting. The default is false so that data that has wiki markup will be handled correctly.
showWiki - Default is false. Set to true to show a non-formatted version of the wiki table following the formatted table. This is used to help resolve formating issues.
{table-plus} 
|| || January || February || March || April || 
| Max | 37.5 | 32.7 | 28.0 | 25.3 | 
| Min | 31.3 | 26.8 | 25.1 | 18.7 | 
{table-plus} 

{table-plus:width=500|border=15|enhableHighlighting=false|columnTypes=S,F,F,F}
|| Month || Max || Min || Average || 
| January | 25.5 | *6.3* | 15.9 | 
| February | 32.4 | 12.8 | 22.6 | 
| March | 44.6 | 24.5 | 34.6 | 
| April | 59.7 | 37.1 | 48.4 | 

Other text can be here too! 

|| Another table || | more data | {table-plus} 

{table-plus:columnTypes=S,-,.|autoNumber=true|sortColumn=3 
|columnAttributes=,,style="background:yellow; font-size:14pt;"} 
|| Name || Phone || TCP || 
| John | 555-1234 | 192.168.1.10 | 
| Mary | 555-2134 | 192.168.1.12 | 
| Bob | 555-4527 | 192.168.1.9 | 

{table-plus} 
Adds column sorting and other attributes to one or more tables found in the body of the macro. The tables can be produced by wiki markup or other means. This macro shares common table capabilities with other table based macros (excel, csv, and sql).

heading - Number of rows to be considered heading rows (default is 1 row). Specify heading=false or heading=0 to not show any heading lines. Heading rows do not participate in sorting.
footing - Number of rows to be considered footing rows (default is 0). Footing rows do not participate in sorting. An auto total row is automatically treated as a footing row.
width - The table width in pixels. Default is 100%.
border - The border width in pixels. Defaults to normal table border width.
Other parameters - Other parameters are passed through to the html table markup for more advanced capabilities or to override the default class
Common table capabilities
A javascript enabled browser is required to enable these capabilities. A number of table based macros (table-plus, csv, excel, and sql) share these common capabilities.

Column sorting - sort a column by clicking on column heading. Clicking again will reverse the order. Auto sorting before display
Row highlighting on mouse over - row is highlighted when mouse goes over any row element for non-heading rows
Column attributes - ability to set the display attributes (color, font) on a column basis
Auto numbering - ability to automatically add a leading column with the data row count.
Auto totaling - ability to automatically add a footing row that totals all numeric columns.
Parameters - the following parameters control these common table capabilities:

enableSorting - Set enableSorting=false to prevent sorting.
enableHighlighting - As the mouse moves over a table row, the row will be highlighted by default. Set enableHighlighting=false to stop this behavior. This parameter was formerly known as highlightRow which still works.
sortColumn - The table can be auto sorted before it is displayed by any valid column name or number provided by this parameter. No auto sorting will be done if this value is not provided or is invalid. A column number is a 1-based count of columns (excluding auto number column).
sortDescending - If sortDescending=true, the sort indicated by the sortColumn will be done in reverse order.
sortTip - Text that is used to provide user feedback with mouse is over a column heading that is sortable. Default text is: "Click to sort" followed by the column name if available.
sortIcon - Default is false to not show a sort indicator icon. Set sortIcon=true to include a sort icon in the first heading row for sortable columns. An icon will show for the last column sorted indicating the direction the column was sorted.
highlightColor - Color of row when mouse is over a row element. See Colors for how to specify.
autoNumber - If autoNumber=true, an additional column will be added that will count each data row.
autoTotal - If autoTotal=true, an additional row will be appended to the end of the table that will contain totals of all numeric columns.
autoNumberSort - If autoNumberSort=true, the auto number column will be sortable and will retain the original data row count even after row sorting.
columnTypes - By default, all columns are treated as strings for sorting purposes unless a more specific sort type is provided either by the macro logic or by this parameter. The parameter is a comma separated list of column type indicators to identify column types.
S - string
I - integer
F - float
C - currency or similar where it is a float value with pre or post characters
D - date in the browser date format. More advanced date handling may be available on your server after installation of a date handling library. See online docmentation for more information.
X - exclude this column from user selectable sorting
. or - or : or / - separated numbers, like phone numbers or TCP addresses. Valid values are multiple integer numbers separated by one of the separators indicated by the type.
H - hide the column.
columnAttributes - A comma separated list of values used to modify cell attributes for all cells in a column. The position in the comma separated list corresponds to the column that the values apply to. Each value is a double semi-colon list of attributeName=value pairs that will be applied to the column cells.
enableHeadingAttributes - By default, any column attributes provided will be applied to the all column rows including heading rows. Set enableHeadingAttributes=false to have the column attributes apply only to data rows.
id - Sets the table id for the table for use in macros (like the chart macro) to identify a specific table.
Help Tips Advanced Formatting
More advanced text formatting.

Notation	Comment
{code:title=Bar.java|borderStyle=solid}
// Some comments here
public String getFoo()
{
    return foo;
}
{code} 

{code:xml} 
<test> 
  <another tag="attribute"/> 
</test> 
{code} 
Makes a preformatted block of code with syntax highlighting. All the optional parameters of {panel} macro are valid for {code} too. The default language is Java but you can specify JavaScript, ActionScript, XML, HTML and SQL too.
Example: 
Bar.java
// Some comments here
public String getFoo()
{
  return foo;
}

<test>
    <another tag="attribute"/>
</test>
{widget:url=http://au.youtube.com/watch?v=cOE8ukQoz6E} 
{widget:url=http://au.youtube.com/watch?v=cOE8ukQoz6E | width=500 | height=400}	
Widget Connector
url - (required) The URL to the widget you want to display in Confluence
{widget:url=http://au.youtube.com/watch?v=cOE8ukQoz6E}
width & height - (optional) Specify the width and height of your widget
{widget:url=http://au.youtube.com/watch?v=cOE8ukQoz6E | width=500 | height=400}
{macro-list}	
Prints a list of all enabled macros in this installation.

This is useful where you wish to let your users see exactly which macros are available for them to use.

{shortcut-list}	
Prints a list of all configured shortcuts in this installation.

This is useful where you wish to let your users see exactly which shortcuts are available for them to use.

{graph-from-table} 
| A | B | 
| A | C | 
{graph-from-table} 


{graph-from-table} 
|| heading 1 ignored || heading 2 ignored || 
| A node | B node | label="relationship 1", style=dashed | style=normal | fillcolor=lightblue | 
| A node | C node | 
| A node | D node | style=invis | 
{graph-from-table} 


{graph-from-table:node=fillcolor=lightblue,fontsize=20|edge=style=bold,color=red| replace=key1:'style=dashed, color=blue', key2:style=invis|ranksep=2.0} 
| A node | B node | | shape=polygon,sides=8,peripheries=3 | | 
| A node | B node | | style=dashed | 
| A node | C node | 
| A node | D node | key2 | 

Here is a second table 
| E | F | key1 | 
| F | G | key1 | 
{graph-from-table} 


{graph-from-table:direction=LR|ranksep=1.5|node=fillcolor=lightblue,fontsize=20| edge=style=bold,color=red|replace=key1:style=dashed} 
| A node | B node | label="r1" | | | cluster 1 | key1 | 
| F | G | key1 | | | cluster 1 | 
| X | Y | key1 | | | cluster 1 | | big cluster | 
{graph-from-table} 


{graph-from-table:direction=LR|edge=color=blue|displayData=true}

{sql:dataSource=ConfluenceDS} 
select PARENTID, TITLE from CONTENT where PARENTID is not NULL 
{sql} 

{graph-from-table} 
Converts a table into a Graphviz graph by rendering the body of the macro and then converting each row in each table to a node relationship. A flowchart macro is used for the rendering. This macro simplifies use of the Graphviz support by eliminating or significantly reducing the need to know the dot language. Advanced users will still need to consult the Graphviz documentation for the multitude of attributes and settings that are possible.

The table or tables specified in the body of the macro can be wiki markup or created as a result of other macros. Specifically, the sql, csv, and excel macros can be used to produce the tables.

The columns in the table are interpreted as follows:

Node with label equal to the column. The source of a relationship.
Node with label equal to the column. The target of a relationship.
Relationship attributes.
Source node attributes.
Target node attributes.
First cluster label. A cluster is a subgraph that contains the source and target nodes for this row.
First cluster attributes. For instance, if you do not want a label to show for the cluster, put label=""
Second cluster label. The second cluster is a subgraph that contains the first cluster.
Second cluster attributes.
Attributes are defined by Graphviz for nodes, relationships, and subgraphs (clusters). They are specified as comma separated list. Attribute values containing blanks must be surrounded by double quotes. Some commonly used attributes are:

label - text to display
style - examples: filled, bold, dotted, dashed, invis (for invisible)
fillcolor - node fill color
fontname - standard font name (enclosed in double quotes if contains a blank)
fontsize - standard font size
fontcolor - color usually specified as a color name like blue, grey, lightyellow
shape - examples: rect, box, circle, ellise, triangle, polygon (together with sides attibutes), diamond, ...
sides - number of sides for a polygon shape
peripheries - number of node boundaries
References:
Flowchart Macro.
Graphviz Documentation.
Parameters - all are optional:
displayData - Default is false. Set to true to show the rendered body data after the graph. This is useful to see the results of a sql macro for instance.
node - The default node attributes are: shape=rect, style=filled, fillcolor=lightyellow, fontname="Verdana", fontsize=9. The default attributes are taken from the default flowchart macro behavior. By specifying the node parameter, you can override these defaults or add additional default attributes. See the Graphviz Documentation for information on attributes and settings.
edge - The default edge attributes are: arrowsize=0.8. The default attributes are taken from the default flowchart macro behavior. By specifying the edge parameter, you can override these defaults or add additional default attributes. See the Graphviz Documentation for information on attributes and settings.
direction - The default layout direction is top to bottom (TB). Set direction=LR to layout in a left to right direction. This is equivalent to the rankdir setting.
tables - Comma separated list of table ids and/or table numbers contained within the body of the macro that will be used as the data for the graph. Defaults to all tables found in the body.
columns - Allows selection of the columns of the table that will be used for the graph. It must be a comma separated list of 1 or more positive integers in any order. The default is columns=1,2,3,4,5,6,7,8,9. If the table does not contain the column indicated, it will be ignored. For example, if columns=3,13 then column 3 will be used for the source node and column 13 will be used for the target node of the relationship. All other columns will be ignored.
replace - A comma separated list of key:value pairs that will be used to convert column values to attributes. If a column value for an attribute column matches one of the keys, the associated value will replace the column value. This makes it easy to associate attributes to column data. If more than one attribute needs to be specified for a key, enclose the value in a single quote so that the comma gets treated as a attribute separator.
... - All other parameters are passed through to Graphviz for setting any global Graphviz parameter. Some common examples are:
ranksep - Separation in inches between nodes.
bgcolor - Background color.
size - Size specified as width, height in inches. Example: size="3,5".
{graphviz}
digraph {
A -> B
A -> C
C -> D
}
{graphviz}	
Displays a graph drawn using the GraphViz language.

{flowchart}
A -> B
A -> C
C -> D
{flowchart}	
Displays a flowchart diagram drawn using the GraphViz language. Some defaults are set to match the Confluence look.

{word:file=^Report.doc}


{word:file=Year 2005^Report.doc|section=1,2}


{word:file=word/Report.xls}
Displays one or more sections from Microsoft Word document (Word 97, 2000, 2003).

Warning - this macro is alpah-level and not for production use. It only partially handles word documents with simple constructs.

file - A required parameter unless url is specified. It specifies the location of the Word document.
^attachment - Data is read from an attachment to the current page.
page^attachment - Data is read from an attachment to the page name provided.
space:page^attachment - Data is read from an attachment to the page name provided in the space indicated.
filename - Data is read from the file located in confluence home directory/script/filename. Subdirectories can be specified.
url - Only required if file is not specified. Specifies the URL of an Excel file. Use of this parameter may be restricted for security reasons. See your administrator for details.
sections - By default, each section in the document will be included. Use the sections parameter to control what sections of the document will be shown. The parameter value can be a comma separated list of section numbers (1-based counting)
{run:replace=greeting:Hello,who:Bob} 
{beanshell} 
System.out.println("$greeting $who"); 
{beanshell} 
{run} 

{run:replace=first:Bob:First name|exportFile=^bobs.html|titleExport=Archive result} 
{sql:datasource=NameDS} 
select * from NAMES where first='$first' 
{sql} 
{run} 

{run:autorun=true|hideRun=true|hideParameters=true|dateFormat=yyyy} 
{sql:datasource=NameDS} 
select * from NAMES where userid='$current_user_id' and year='$current_time'
{sql} 
{run} 

Allows user control over the rendering of the body of the macro. Parameters can be provided and they will be used to replace parameters in the body prior to rendering. Parameters can be provided as request parameters on the URL, enabling automatic running of content based on the incoming parameters. Any text in the macro body that begins with $ immediately followed by a key value found in the replace parameter list of comma separated key:value:description triples will be replaced by the value. Until the documentation can be improved, look at the url after pressing the run button or after an autorun.

Some pre-defined variables are available for use:
$current_user_id will be replaced with the current logged in user's id or blank if not logged in
$current_user_name will be replaced with the current user's full name or blank if not logged in
$current_user_email will be replaced with the current user's email address or blank if not logged in
$current_user_timezone_id will be replaced with the current user's time zone setting id (example: America/Chicago). The default time zone will be used if the user is not logged in.
$current_user_timezone_offset will be replaced with the current user's time zone setting offset (in hours) from GMT (examples: -6, 5.5) The default time zone will be used if the user is not logged in.
$page_title will be replaced with the page title of the page containing the macro
$page_id will be replaced with the page id of the page containing the macro
$page_url will be replaced with the full url to the page containing the macro
$page_tinyurl will be replaced with the tiny url to the page containing the macro
$space_name will be replaced with the space name of the page containing the macro
$space_key will be replaced with the space key of the page containing the macro
$current_time will be replaced with the current date and time in the format specified by the dateFormat parameter
The html, representing the rendered body of the macro, can be exported to a page attachment or to the file system. This enables the dynamic content to be captured at a point in time for later viewing. An attachment or file created by this type of export, can be used on a page by including it in the body of an {html} macro. For example: {html:script=^bobs.html} {html}

Advanced capabilities: If *exportVersion=keep* is used, the referenced attachment is already there, and the HTML macro is authorized for use on the page, then the macro body will not be rendered and the attachment will be included instead. This enables caching and automation capabilities.

Recursive use: Three identical macros run, run1, and run2 are provided to enable recursive use of the macro.

id - Optional. Can be specified as the default parameter. A way to specify a unique id to identify this instance of the run macro. By default, a numeric id is automatically assigned based on the order of the macro on the page.
replace - A comma separated list of key:value:description triples. Any string containing a comma (,) or colon (:) must be enclosed in single quotes (').
key is the parameter name. This must be non blank.
value is the initial replacement value. If not provided, blank will be used.
description is descriptive text used to provide prompt text for the parameter. If not provided, the key will be used.
inputSize - Size of the value entry fields. Default is 20.
autoRun - Default is false. Set to true to automatically render the macro body with the default parameter values.
heading - Heading that appears before the buttons. Default is blank.
prompt - Prompt text that appears above the parameters. Default is blank.
titleRun - Title for the run button. Default is Run
titleExport - Title for the export button. Default is Export. Exportfile parameter is required before the export button will show.
titleExportFile - Title for the export file input field. Default is blank. This will only be shown if exportfile parameter value starts with a question mark (?).
titleAttachmentComment - Title for the attachment comment input field. Default is blank. This will only be shown if attachmentComment parameter value starts with a question mark (?).
hideParameters - Hide the parameters. Default is false.
hideRun - Hide the Run button. Default is false.
hideExport - Hide the Export button. Default is true unless exportFile is non-blank.
exportFile - Location of the export partial html file representing the rendered macro body. For export to an attachment, the user must be authorized to add attachments to the page specified.
^attachment - The rendered html is exported as an attachment to the current page.
page^attachment - The rendered html is exported as an attachment to the page name provided.
space:page^attachment - The rendered html exported as an attachment to the page name provided in the space indicated.
filename - The rendered html is exported as a file located in confluence home directory/script/filename. Subdirectories can be specified.
Replacement keys are allowed in this field and will be replaced with values.
exportVersion - Defines the the versioning mechanism for exported reports.
new - (default) Creates new version of the attachment. For file based exports 'new' has the same effect as 'keep'.
replace - Replace (overwrites) existing rendered html and, for attachments, removes all previous versions! To replace an existing attachment, the user must be authorized to remove attachments for the page specified.
keep - Only creates an new export if an existing export of the same name does not exist. An existing attachment will not be changed and an existing file will not be updated.
attachmentComment - Comment used for an exported attachment. If it begins with a question mark (?) then an entry field with this value will appear next to the export button. Replacement keys are allowed in this field and will be replaced with values.
autoExport - Default is false. Set to true to have the rendered macro body automatically exported.
showKey - Show the key. The key is shown after the value entry field. Default is false.
dateFormat - Date format to use for replacement of $current_time. Default is server date format. See Date Format for how to specify this value.
keepRequestParameters - Default is false. Set to true to keep existing request parameters on the url after button is pressed. All requests parameters will be retained if *keepRequestIds* is not specified. Otherwise, non-run macro request parameters and those references by the *keepRequestIds* parameter will be retained.
keepRequestIds - List of run macro ids whose request parameters should be retained on the url after a button is pressed. button is pressed. This will be required for recursive use of this macro. Use of this parameter or *keepRequestParameters* parameter is required for recursive use of this macro.
{content-by-user:fred}	
Displays a simple table of all the content (pages, comments, news items, user profiles and space descriptions) created by a user (here 'fred').

{index}	
Displays an index of all the pages in the current space, cross linked and sorted alphabetically.

{include:Home}

{include:FOO:Home}

{include:spaceKey=FOO|pageTitle=Home}	 Includes one page within another (this example includes a page called "Home"). Pages from another space can be included by prefacing the page title with a space key and a colon.
The user viewing the page must have permission to view the page being included, or it will not be displayed.

{chart:title=Fish Sold}
|| Fish Type || 2004 || 2005 || 
|| Herring | 9,500 | 8,300 |
|| Salmon | 2,900 | 4,200 |
|| Tuna | 1,500 | 1,500 |
{chart} 

{chart:type=line|title=Temperatures in Brisbane|yLabel=Celcius 
|dataDisplay=true|dataOrientation=vertical} 
|| Month || Min || Max || 
| January | 31.3 | 37.5 | 
| February | 26.8 | 32.7 | 
| March | 25.1 | 28 | 
| April | 18.7 | 25.3 | 
{chart} 

{chart:type=timeSeries|dateFormat=MM.yyyy|timePeriod=Month| 
dataOrientation=vertical|rangeAxisLowerBound=0|colors=blue,gray} 
|| Month || Revenue || 
| 1.2005 | 31.8 | 
| 2.2005 | 41.8 | 
| 3.2005 | 51.3 | 
| 4.2005 | 33.8 | 
| 5.2005 | 27.6 | 
| 6.2005 | 49.8 | 
| 7.2005 | 51.8 | 
| 8.2005 | 77.3 | 
| 9.2005 | 73.8 | 
| 10.2005 | 97.6 | 
| 11.2005 | 101.2 | 
| 12.2005 | 113.7 | 

|| Month || Expenses || 
| 1.2005 | 41.1 | 
| 2.2005 | 43.8 | 
| 3.2005 | 45.3 | 
| 4.2005 | 45.0 | 
| 5.2005 | 44.6 | 
| 6.2005 | 43.8 | 
| 7.2005 | 51.8 | 
| 8.2005 | 52.3 | 
| 9.2005 | 53.8 | 
| 10.2005 | 55.6 | 
| 11.2005 | 61.2 | 
| 12.2005 | 63.7 | 
{chart} 
Displays a chart using data from the supplied table or tables.

Chart type parameters - These parameters change what type of chart to display and the way the chart looks.
type - The type of chart to display. The following chart types are available:
Standard charts

pie (default)
bar
line
area
XY plots - The standard XY plot has numerical x and y axes.The x values may optionally be time based. See timeSeries.

xyArea
xyBar
xyLine
xyStep
xyStepArea
scatter
timeSeries
Other charts

gantt - beta - See Gantt Charts.

orientation - A bar, line, or area chart will be displayed vertically (y axis is vertical) unless 'orientation=horizontal' is specified.
3D - A pie, bar, or line chart will be shown in 3D if 3D=true is specified.
stacked - A bar or area chart will be shown with stacked values if stacked=true is specified.
showShapes - Shapes will be shown at each data point in a line chart unless showShapes=false.
opacity - A percent value between 0 (not visible) and 100 (non-transparent) that determines how opaque the foreground areas and bars display. Defaults are:
75 percent for 3D charts
50 percent for non-stacked area charts
100 percent for all other charts
Display control parameters
width - The width of the chart in pixels (default is '300')
height - The height of the chart in pixels (default is '300')
dataDisplay - Default is false to not display the rendered body of the macro (usually the data tables). When dataDisplay=true or dataDisplay=after, the data will be displayed after the chart. When dataDisplay=before, the data will be displayed before the chart.
imageFormat - Default is png. Format of generated image. Valid formats are png and jpg. Other formats may be also be valid if installed on your server.
Title and label customization parameters
title - The title of the chart.
subTitle - A subtitle for the chart using a smaller font.
xLabel - The label to use for the x (domain) axis
yLabel - The label to use for the y (range) axis
legend - A legend will be displayed unless legend=false is specified.
Data specification parameters - The data for the chart is taken from tables found when the macro body is rendered. These options control how this data is interpreted. By default, numeric and date values are interpreted according to the Confluence global default language (locale) formats. If conversion fails, other languages defined to Confluence will be tried. Additional conversion options can be specified using the parameters below.
tables - Comma separated list of table ids and/or table numbers contained within the body of the macro that will be used as the data for the chart. Defaults to all first level tables. If data tables are embedded in other tables, then table selection will be required. This occurs when more complex formatting is done (for example using section and column macros).
columns - Comma separated list of column labels and/or column titles and/or column numbers for tables used for chart data. This applies to all tables processed. Defaults to all columns. Columns are enumerated starting at 1. Column label is the text for the column in the header row. Column title is the (html) title attribute for the column in the header row.
dataOrientation - The data tables will be interpreted as columns (horizontally) representing domain and x values unless 'dataOrientation=vertical'.
timeSeries - If 'true', the x values in an XY plot will be treated as time series data and so will be converted according date formats.
dateFormat - For time series data, the date format allows for additional customization of the conversion of data to date values. By default, the Confluence language defined date formats will be used. If a dateFormat is specified, it will be the first format used to interpret date values. Specify a format that matches the format of the time series data. See Date Format.
timePeriod - Specify the time period for time series data. Default is 'Day'. This defines the granularity of how the data is interpreted. Valid values are: Day, Hour, Millisecond, Minute, Month, Quarter, Second, Week, Year.
language - If provided, the language and country specification will be used to create additional number and date formats to be used for data conversion. This specification will be used before the default languages automatically used. Valid values are 2 character ISO 639-1 alpha-2 codes.
country - Used in combination with the language parameter. Valid values are 2 character ISO 3166 codes.
forgive - Default is true to try to convert numeric and date values that do not totally match any of the default or user specified formats. Specify forgive=false to enforce strict data format. Data format errors will cause the chart to not be produced.
Color customization parameters - See Colors for how to specify colors.
bgColor - Color (default is 'white') to use as the background of the chart.
borderColor - Color of a border around the chart. Default is to not show a border.
colors - Comma separated list of colors used to customize category, sections, and series colors.
Axis customization parameters - Depending on the chart type, the range and domain axis may be customized. These values are automatically generated based on the data but can be overridden by specifying one or more more of these paramters.
rangeAxisLowerBound - range axis lower bound
rangeAxisUpperBound - range axis upper bound
rangeAxisTickUnit - range axis units between axis tick marks
rangeAxisLabelAngle - angle for the range axis label in degrees
domainAxisLowerBound - domain axis lower bound. For a date axis, this value must be expressed in the date format specified by the dateFormat parameter
domainAxisUpperBound - domain axis upper bound. For a date axis, this value must be expressed in the date format specified by the dateFormat parameter
domainAxisTickUnit - domain axis units between axis tick marks. For a date axis, this value represents a count of the units specified in the timePeriod parameter. The time period unit can be overridden by specifying a trailing character: y for years, M for months, d for days, h for hours, m for minutes, s for seconds, u - milliseconds
domainAxisLabelAngle - angle for the domain axis label in degrees
categoryLabelPosition - allows axis label text position for categories to be customized
up45 - 45 degrees going upward
up90 - 90 degrees going upward
down45 - 45 degrees going downward
down90 - 90 degrees going downward
dateTickMarkPosition - placement of the date tick mark
start (default) - tick mark is at the start of the date period
middle - tick mark is in the middle of the date period
end - tick mark is at the end of the date period
Pie chart customization parameters
pieSectionLabel - Format for how pie section labels are displayed. :
%0% is replaced by the pie section key.
%1% is replaced by the pie section numeric value.
%2% is replaced by the pie section percent value.
Example 1: "%0% = %1%" would display something like "Independent = 20" 
Example 2: "%0% (%2%)" would display something like "Independent (20%)"
pieSectionExplode - Comma separated list of pie keys that are to be shown exploded. Defaults to no exploded sections. Note: requires jFreeChart version 1.0.3 or higher.
Attachment parameters - These are advanced options that can be used for chart versioning, automation enablement, and to improve performance. Use these options carefully! Normally, the chart image is regenerated each time the page is displayed. These options allow for the generated image to be saved as an attachment and have subsequent access re-use the attachment. This can be useful especially when combined with the cache macro to improve performance. Depending on the options chosen, chart images can be versioned for historical purposes.
attachment - Chart image will be saved in a attachment.
^attachment - chart.macro.param.attachment.attachment
page^attachment - The chart is saved as an attachment to the page name provided.
space:page^attachment - The chart is saved as an attachment to the page name provided in the space indicated.
attachmentVersion - Defines the the versioning mechanism for saved charts.
new - (default) Creates new version of the attachment.
replace - Replaces all previous versions of the chart. To replace an existing attachment, the user must be authorized to remove attachments for the page specified.
keep - Only saves a new attachment if an existing export of the same name does not exist. An existing attachment will not be changed or updated.
attachmentComment - Comment used for a saved chart attachment.
thumbnail - Default is false. If true, the chart image attachment will be shown as a thumbnail.
Colors
Colors can be specified by name or hex value. See Web-colors. The following are the valid color names that will automatically be converted.
Color	Hexadecimal	Color	Hexadecimal	Color	Hexadecimal	Color	Hexadecimal
black	#000000	silver	#c0c0c0	maroon	#800000	red	#ff0000
navy	#000080	blue	#0000ff	purple	#800080	fuchsia	#ff00ff
green	#008000	lime	#00ff00	olive	#808000	yellow	#ffff00
teal	#008080	aqua	#00ffff	gray	#808080	white	#ffffff
Date Format
Copied from Java SimpleDateFormat specification.

Date and time formats are specified by date and time pattern strings. Within date and time pattern strings, unquoted letters from 'A' to 'Z' and from 'a' to 'z' are interpreted as pattern letters representing the components of a date or time string. Text can be quoted using single quotes (') to avoid interpretation. "'" represents a single quote. All other characters are not interpreted; theyre simply copied into the output string during formatting or matched against the input string during parsing.

The following pattern letters are defined (all other characters from 'A' to 'Z' and from 'a' to 'z' are reserved):

Letter	Date or Time Component	Presentation	Examples
G	Era designator	Text	AD
y	Year	Year	1996; 96
M	Month in year	Month	July; Jul; 07
w	Week in year	Number	27
W	Week in month	Number	2
D	Day in year	Number	189
d	Day in month	Number	10
F	Day of week in month	Number	2
E	Day in week	Text	Tuesday; Tue
a	Am/pm marker	Text	PM
H	Hour in day (0-23)	Number	0
k	Hour in day (1-24)	Number	24
K	Hour in am/pm (0-11)	Number	0
h	Hour in am/pm (1-12)	Number	12
m	Minute in hour	Number	30
s	Second in minute	Number	55
S	Millisecond	Number	978
z	Time zone	General time zone	Pacific Standard Time; PST; GMT-08:00
Z	Time zone	RFC 822 time zone	-0800
Pattern letters are usually repeated, as their number determines the exact presentation.
Text: For formatting, if the number of pattern letters is 4 or more, the full form is used; otherwise a short or abbreviated form is used if available. For parsing, both forms are accepted, independent of the number of pattern letters.
Number: For formatting, the number of pattern letters is the minimum number of digits, and shorter numbers are zero-padded to this amount. For parsing, the number of pattern letters is ignored unless its needed to separate two adjacent fields.
Year: For formatting, if the number of pattern letters is 2, the year is truncated to 2 digits; otherwise it is interpreted as a number.
For parsing, if the number of pattern letters is more than 2, the year is interpreted literally, regardless of the number of digits. So using the pattern "MM/dd/yyyy", "01/11/12" parses to Jan 11, 12 A.D.

For parsing with the abbreviated year pattern ("y" or "yy"), SimpleDateFormat must interpret the abbreviated year relative to some century. It does this by adjusting dates to be within 80 years before and 20 years after the time the SimpleDateFormat instance is created. For example, using a pattern of "MM/dd/yy" and a SimpleDateFormat instance created on Jan 1, 1997, the string "01/11/12" would be interpreted as Jan 11, 2012 while the string "05/04/64" would be interpreted as May 4, 1964. During parsing, only strings consisting of exactly two digits, will be parsed into the default century. Any other numeric string, such as a one digit string, a three or more digit string, or a two digit string that isnt all digits (for example, "-1"), is interpreted literally. So "01/02/3" or "01/02/003" are parsed, using the same pattern, as Jan 2, 3 AD. Likewise, "01/02/-3" is parsed as Jan 2, 4 BC.

Month: If the number of pattern letters is 3 or more, the month is interpreted as text; otherwise, it is interpreted as a number.
General time zone: Time zones are interpreted as text if they have names. For time zones representing a GMT offset value, the following syntax is used:
     GMTOffsetTimeZone:
             GMT Sign Hours : Minutes

     Sign: one of
             + -
     Hours:
             Digit
             Digit Digit

     Minutes:
             Digit Digit
     Digit: one of
             0 1 2 3 4 5 6 7 8 9
Hours must be between 0 and 23, and Minutes must be between 00 and 59. The format is locale independent and digits must be taken from the Basic Latin block of the Unicode standard.
For parsing, RFC 822 time zones are also accepted.

RFC 822 time zone: For formatting, the RFC 822 4-digit time zone format is used:
     RFC822TimeZone:
             Sign TwoDigitHours Minutes
     TwoDigitHours:
             Digit Digit
TwoDigitHours must be between 00 and 23. Other definitions are as for general time zones.
For parsing, general time zones are also accepted.


{html:script=#example.html} 
{html} 

{html:script=^example.html} 
{html} 

{html:output=wiki|noPanel=true} 
Lorem ipsum dolor sit amet, consectetuer adipiscing elit. 
Aliquam fermentum vestibulum est. Cras rhoncus. 
{html} 

{html:script=#http://localhost/example.html} 
{html} 

Includes HTML data into a Confluence page. HTML and BODY tags are removed when output=html so the display of the Confluence page is not disrupted.

This macro may have restricted use for security reasons. See your administrator for details.

output - Determines how the output is formated:
html - Data is output as HTML (default).
wiki - Data is surrounded by a {noformat} macro.
script - Location of HTML data. Default is the macro body only. If a location of data is specified, the included data will follow the body data.
#filename - Data is read from the file located in confluence home directory/script/filename. Subdirectories can be specified.
#http://... - Data is read from the URL specified.
^attachment - Data is read from an attachment to the current page.
page^attachment - Data is read from an attachment to the page name provided.
space:page^attachment - Data is read from an attachment to the page name provided in the space indicated.
noPanel - When output=wiki, show the data within a panel (default) unless nopanel=true.
{xslt:style=^cdcatalog.xsl}
<catalog> 
    <cd>  
        <title>Empire Burlesque</title>  
        <artist>Bob Dylan</artist>  
        <country>USA</country>  
    </cd>  
    <cd>  
        <title>Maggie May</title>  
        <artist>Rod Stewart</artist>  
        <country>UK</country>  
    </cd>  
</catalog>
{xslt} 

{xslt:source=^cdcatalog.xml|style=#http://www.w3schools.com/xsl/cdcatalog.xsl}
{xslt} 
Transforms XML to a Confluence page via an XSLT style sheet. Note that macro parameters not recognized by the xslt macro are automatically passed through to the xslt engine.

This macro may have restricted use for security reasons. See your administrator for details.

output - Determines how the output is formated:
html - Data is output as a HTML (default).
wiki - Data is output as Confluence wiki text. Use this option if you want the data to be formated by the Confluence wiki renderer.
source - Location of source XML code. Default is the macro body.
#filename - Data is read from the file located in confluence home directory/script/filename. Subdirectories can be specified.
#http://... - Data is read from the URL specified.
global page template name - Data is read from a global page template.
space:page template name - Data is read from a space template.
^attachment - Data is read from an attachment to the current page.
page^attachment - Data is read from an attachment to the page name provided.
space:page^attachment - Data is read from an attachment to the page name provided in the space indicated.
style - Location of source XSL code. Required if source XML is in the macro body, otherwise defaults to the macro body.
#filename - Data is read from the file located in confluence home directory/script/filename. Subdirectories can be specified.
#http://... - Data is read from the URL specified.
global page template name - Data is read from a global page template.
space:page template name - Data is read from a space template.
^attachment - Data is read from an attachment to the current page.
page^attachment - Data is read from an attachment to the page name provided.
space:page^attachment - Data is read from an attachment to the page name provided in the space indicated.
{calendar:id=myCalendar|title=My Calendar|defaultView=week}	
Displays a calendar.

id - (required) The page-unique ID of the calendar.
title - (optional) The title of the initial sub-calendar.
defaultView - (optional) The view to display by default. May be 'event', 'day', 'week', or 'month' (the default).
firstDay - (optional) The first day of the week. Defaults to 'Monday'.
{noformat} 
preformatted piece of text
so *no* further _formatting_ is done here 
{noformat}	 Makes a preformatted block of text with no syntax highlighting. All the optional parameters of {panel} macro are valid for {noformat} too.
nopanel: If the value of "nopanel" is true, then the excerpt will be drawn without its surrounding panel.
Example:
preformatted piece of text
so *no* further _formatting_ is done here
{panel}Some text{panel} 

{panel:title=My Title}Some text with a title{panel} 

{panel:title=My Title| borderStyle=dashed| borderColor=#ccc| titleBGColor=#F7D6C1| bgColor=#FFFFCE} 
a block of text surrounded with a *panel* 
yet _another_ line 
{panel}	 Embraces a block of text within a fully customizable panel. The optional parameters you can define are the following ones: 
title: Title of the panel
borderStyle: The style of the border this panel uses (solid, dashed and other valid CSS border styles)
borderColor: The color of the border this panel uses
borderWidth: The width of the border this panel uses
bgColor: The background color of this panel
titleBGColor: The background color of the title section of this panel
Example:

My Title
a block of text surrounded with a panel
yet another line
{search-form} {search-input:type=text|match=query} {search-form}
{search-results}
Provides a configurable form mail system, submitting using AJAX / DWR.

See Also: Plugin Homepage and Documentation

{rsvp} 
{rsvp:Atlassian User Group} 
{rsvp:width=600px} 
{rsvp:admin=confluence-users} 
{rsvp:admin=john} 
{rsvp:sort=creation} 
{rsvp:sort=name|reverse=true} 
{rsvp:hide_replies=true} 
{rsvp:must_login=true|hide_replies=true} 
{rsvp:limit=10} 
{rsvp:custom=Company} 
{rsvp:url=true}	
Usage
Allows you to specify a title for your event.
{rsvp:Atlassian User Group}
Will display the title "Atlassian User Group".
{rsvp:title=Atlassian User Group}
Will display the title "Atlassian User Group".
admin - Allows you to specify a group or a user who can administrate the plugin.
{rsvp:admin=confluence-users}
allows all users in the confluence-users group to administrate this plugin.
{rsvp:admin=john_foo}
allows only john to administrate this plugin.
Confluence Administrators can always administrate this plugin.
width - Allows you to specify the width of the RSVP macro.
{rsvp:width=600px}
width of 600px
sort - Allows you to specify how to sort the displayed replies.
{rsvp:sort=name}
(default) sorts displayed replies by "name" field value
{rsvp:sort=creation}
sorts displayed replies by creation time
reverse - Allows you to specify the direction of the sort of the displayed replies.
{rsvp:reverse=false}
(default) ascending sort of displayed replies
{rsvp:reverse=true}
descending sort of displayed replies
hide_replies - Allows you to specify that the list of replies should be hidden from non-administrators.
{rsvp:hide_replies=false}
(default) do not hide replies from non-administrators
{rsvp:hide_replies=true}
hide replies from non-administrators
must_login - Allows you to specify that only logged-in users should be able to reply.
{rsvp:must_login=false}
(default) do not require login for replies
{rsvp:must_login=true}
require login for replies
limit - Allows you to specify a limit to the number of RSVP replies that are allowed.
{rsvp:limit=unlimited}
(default) allow unlimited replies
{rsvp:limit=10}
only allow ten replies
custom - Gives the option to display a custom field, eg. "Company", "Comment" or "Can Drive".
{rsvp:custom=Comment}
display a "Comment" field
url - Allows you to ask for a URL that will be linked to the custom field.
{rsvp:url=true}
display a "URL" field
button - Allows you to change the Attend button label.
{rsvp:button=Subscribe}
display a Subscibe button instead of Attend
time - Will display the time of entry to the administrator.
{rsvp:time=true}
shows the time in the admin view.
{note:title=Be Careful}
The body of the note here..
{note}	
Prints a simple note to the user.

title: - (optional) the title of the note.
icon: - (optional) if "false", dont display the icon.
	Be Careful

The body of the note here..
{warning:title=Warning}
Insert warning message here!
{warning}	
Prints a warning note to the user.

title: - (optional) the title of the warning.
icon: - (optional) if "false", dont display the icon.
	Warning

Insert warning message here!
{info:title=Be Careful}
This macro is useful for including helpful information in your confluence pages
{info}	
Prints an informational note.

title: - (optional) the title of the information box.
icon: - (optional) if "false", dont display the icon.
	Useful Information

This macro is useful for including helpful information in your confluence pages
{tip:title=Handy Hint}
Join the Confluence Mailing-List!
{tip}	
Prints a helpful tip for the user.

title: - (optional) the title of the tip.
icon: - (optional) if "false", dont display the icon.
	Handy Hint

Join the Confluence Mailing-List!
Help Tips Confluence Content
Ways to include, summarise or refer to other Confluence content.

Notation	Comment
!quicktime.mov! 

!spaceKey:pageTitle^attachment.mov! 

!quicktime.mov|width=300,height=400! 

!media.wmv|id=media!	 Embeds an object in a page, taking in a comma-separated of properties. 

Default supported formats:
Flash (.swf)
Quicktime movies (.mov)
Windows Media (.wma, .wmv)
Real Media (.rm, .ram)
MP3 files (.mp3)

Other types of files can be used, but may require the specification of the "classid", "codebase" and "pluginspage" properties in order to be recognised by web browsers. 

Common properties are:
width - the width of the media file
height - the height of the media file
id - the ID assigned to the embedded object

Due to security issues, files located on remote servers are not permitted
Styling 
By default, each embedded object is wrapped in a "div" tag. If you wish to style the div and its contents, override the "embeddedObject" CSS class. Specifying an ID as a property also allows you to style different embedded objects differently. CSS class names in the format "embeddedObject-ID" are used.
{userlister}

{userlister:groups=confluence-administrators}

{userlister:online=true}

{userlister:groups=confluence-users|online=true}	
Lists users registered in Confluence.

Either a group or groups value must be supplied. If you want all users in the system use groups=*.

Supplying a groups value will list only members of those groups. The groups value supports a comma separated list of group-names.

Group: confluence-administrators
 Tyler Durden (tdurden@example.com)
 Marla Singer (marla@example.com)
 Robert Paulson (bob@example.com)
Specifying the online value allows you to filter the user list by the user online status. Setting online=true will show only online users, whereas setting online=false will show only offline users.

If you've configured this macro to display groups which are black listed by the administrator, you will get a warning panel at the top. The warning will be automatically displayed by default. To disable the warning, you can specify showWarning=false.

{spacegraph} 

{spacegraph:spaceKey|showOutgoingLinks=true} 
Displays a diagram of the pages in a space. By default it displays the current space. If a spacekey is supplied as the default parameter, that space is displayed. Only pages that the current user is authorized to view are displayed.

default parameter - use current space unless the default parameter is set to a space key.
showOutgoingLinks - default is false. Set to true to show links to other Confluence pages. Outgoing links are shown as dotted lines.
{contributors-summary:order=edits|limit=3|showAnonymous=true}

{contributors-summary:columns=edits|order=editTime}

Creates a table of contributor information from the current page or a group of pages.

Table Options

groupby - (optional) Specify if the table should be grouped by contributors or pages. Default value is contributors
columns - (optional) Specify the columns that should appear in the table as a comma separated list. Default value is edits,comments,labels. Valid values:
edits Edit Count Column
edited List of pages or contributors
comments Comment Count Column
commented List of pages or contributors
labels Label Count Column
labeled List of pages or contributors
labellist List of labels
watches Watch Count Column
watching List of pages or contributors
lastupdate Last time a page was updated or a contributor changed some content.
order - (optional) The order the contributors or pages will appear in. By default the table is ordered by the number of edits.
edits Orders the list with the highest number of edits first in the list
name Orders the list by name alphabetically
editTime Orders the list by the time they last edit time
update Order by the last update time of any content
reverse - (optional) If true the sort order will be reversed.
limit - (optional) Limit the number of contributors displayed to this amount
showAnonymous - (optional) Show updates by anonymous users. Default is false.
showZeroCounts - (optional) If all the selected columns are zero, or empty should the contributor or page be displayed in the table. Default is false.
Page Searching Options The following parameters control what pages are used to build the contributors list.

page The page to count statistics from. If no spaces or labels are specified this will default to the current page.
labels The label to use to search for pages. Multiple labels can be specified in a comma separated list. (A page will match if it has any of the labels.)
spaces Specify the space for the page or labels parameter. Multiple spaces can be specified in a comma separated list. If no pages or labels are specified all pages from the space will be included. The following shortcut space names can also be used:
@all All Spaces
@global All Global Spaces
@personal All Personal Spaces
contentType Valid options are:
pages
blogposts
If not specified blog posts and pages are included.
publishDate specify the publish date for a blog post. The date format expected is: YYYY/mm/dd
scope For each of the pages found this parameter lets you include the children or decendants. (Each page will only be counted once if it is already in the list.)
children include statistics from the immediate children of the page
descendants include statistics from all descendants of the page
{contributors:order=edits}

{contributors:include=authors,labels|mode=list|showCount=true}

{contributors:order=editTime|limit=6}

Creates a list of contributors who have contributed to a page or a list of pages.

Display Options

include - (optional) What type of content from the pages to base the contributor list (and the counts) on. Multiple values can be specified with a comma separated list
authors Include page authors (default).
comments Include page comments
labels Include page labels
watches Include page watches
order - (optional) The order the contributors will appear in.
count Order by the total count (default)
name Order by the names of the contributors
update Order by the last update time
Both the count and update orderings will use values from only the content specified with the include parameter.
reverse - (optional) If true the sort order will be reversed.
limit - (optional) Limit the number of contributors initially displayed to this amount
mode - (optional) Sets the display mode of the macro
inline The contributors will be displayed across the screen (default)
list The contributors will be displayed in a list down the screen
showAnonymous - (optional) Show edits by anonymous users. Default is false.
showCount - (optional) Show the count for each user. Default is false.
showLastTime - (optional) Show the last time a contribution was made by each user for any content specified by the include parameter. Default is false.
Page Searching Options The following parameters control what pages are used to build the contributors list.

page The page to count statistics from. If no spaces or labels are specified this will default to the current page.
labels The label to use to search for pages. Multiple labels can be specified in a comma separated list. (A page will match if it has any of the labels.)
spaces Specify the space for the page or labels parameter. Multiple spaces can be specified in a comma separated list. If no pages or labels are specified all pages from the space will be included. The followingshortcut space names can also be used:
@all All Spaces
@global All Global Spaces
@personal All Personal Spaces
contentType Valid options are:
pages
blogposts
If not specified blog posts and pages are included.
publishDate specify the publish date for a blog post. The date format expected is: YYYY/mm/dd
scope For each of the pages found this parameter lets you include the children or decendants. (Each page will only be counted once if it is already in the list.)
children include statistics from the immediate children of the page
descendants include statistics from all descendants of the page
Advanced Options

showPages - show a list of pages returned above the list. Useful for debugging.
noneFoundMessage - override the default message that is displayed when no contributors are found.
{children} 

{children:all=true} 

{children:depth=x} 

{children:depth=x|style=h3} 

{children:excerpt=true} 

{children:page=Another Page} 

{children:page=/} 

{children:page=SPACEKEY:} 

{children:page=SPACEKEY:Page Title} 

{children:first=x} 

{children:sort=<mode>|reverse=<true or false>}	 Displays the children and descendants of the current page. Specify 'all=true' to show all descendants of this page, or depth=x (where x is any number > 0) to show that many levels of descendants.
The 'style' attribute can be any of 'h1' through 'h6'. If you specify a style, the top level of child pages will be displayed as headings of that level, with their children then displayed as lists below. A great way to throw together a quick contents page!

You can view the children of a different page in the same space with {children:page=Another Page Title}.

If you specify a page of '/', you will list all the pages in the space with no parent (i.e. the top-level pages), excluding the current page

If you specify a page of 'FOO:' (the colon is required), you will list all the pages with no parent in the space with key "FOO".

Specify 'excerpt=true' to also display the first line of the pages excerpt (see the excerpt macro) if it exists.

Example:

child
another child
child
first grandchild
another child
The 'sort' attribute is an optional attribute that allows you to configure how the children are sorted. Specify 'creation' to sort by content creation date, 'title' to sort alphabetically on title and 'modified' to sort of last modification date. Use the reverse attribute to optionally reverse the sorting.

The 'first' attribute allows you to restrict the number of children displayed at the top level.

{search:query=my_query} 

{search:query=my_query|maxLimit=x}	 Does an inline site search.
query: your query
maxLimit=x: (where x is any number > 0) to limit the search result to a number of results.
spacekey: specify the key of the space you want to search in
type: specify the content type (could be page, comment, blogpost, attachment, userinfo, spacedesc)
lastModified: specify a time period in which the content was last modified: (e.g. 3d = modified in the last 3 days, 1m3d = modified in the last month and three days)
contributor: specify the username of the contributor of the content to be retrieved
Example:

Found 2 result(s) for home
Home (Space Home Page) Home (My Space) 
This is the home page for My Space.
PDF File file-containing-home.pdf ( download)
{blog-posts:max=5} 

{blog-posts:max=5|content=excerpts} 

{blog-posts:max=5|content=titles} 

{blog-posts:time=7d|spaces=@all} 

{blog-posts:max=15|time=14d|content=excerpts} 

{blog-posts:labels=confluence,atlassian} 

{blog-posts:labels=+atlassian,+confluence,+content} 

Displays the most recent news items in this space.

content - lets you choose whether to display each news item in its entirety (the default), just short excerpts from each item (see the excerpt macro), or just a list of post titles.
time - lets you choose how far back to look for news items. For example, "time=12h" would show you those items made in the last twelve hours, and "time=7d" would show items made in the last week. (The default is no limit)
label/labels - (optional) search for content with these labels; prefix a label with '+' to require a match or '-' to exclude any content with that label. By default, at least one of the labels will be present on any matched content. Separate labels with commas or single-spaces.
spaces - (optional) spaces to search.
Accepted values:
space keys (case-sensitive)
@self: current space
@personal: personal spaces
@global: global spaces
@favorite/@favourite: user's favourite spaces
@all/*: all spaces (that the user has permission to view)

Prefix a space with '+' to require a match or '-' to exclude any matches from that space. By default,at least one of the named spaces must match. Separate spaces with commas or single-spaces.
type - (optional) search for types of content.
Accepted values:
page: basic pages
comment: comments on pages or blogs
blogpost/news: blog posts
attachment: attachments to pages or blogs
userinfo: personal information
spacedesc: space descriptions
personalspacedesc: personal space descriptions
mail: emails in a space

Prefix a type with '+' to require matches to be of that type, or '-' to exclude matches of that type.By default, matched content will be of at least one of the listed type. Separate types with commas or single-spaces.
max/maxResults - (optional) the maximum number of results to return. Defaults to 100.
sort - (optional) the sorting to apply to the results.
Accepted values:
title: by content title
creation: by time of creation
modified: by time of last modification (creation is the "first" modification)
reverse - (optional) reverses the currently applied sort. This parameter must be used in conjunction with the sort parameter.
{excerpt}Confluence is a knowledge-sharing application that enables teams to communicate more effectively{excerpt}

{excerpt:hidden=true}This excerpt will be recorded, but will not be displayed on the page.{excerpt}	 Marks some part of the page as the page's 'excerpt'. This doesn't change the display of the page at all, but other macros (for example children, excerpt-include and blog-posts) can use this excerpt to summarise the page's content.
hidden: If the value of "hidden" is true, then the contents of the excerpt macro will not appear on the page.
{excerpt-include:Home} 

{excerpt-include:Home|nopanel=true} 

{excerpt-include:blogPost=/2006/12/28/News Page}	 Includes the excerpt from one page (see the excerpt macro) within another. The included page must be in the same space as the page on which the macro is used.
nopanel: If the value of "nopanel" is true, then the excerpt will be drawn without its surrounding panel.
{popular-labels} 

{popular-labels:style=heatmap|count=15}	
Renders a list (or heatmap) of the most popular labels ordered by popularity (or name).

count - (optional) Specify the number of labels to be displayed. If not specified, a default of 100 is used.
spaceKey - (optional) Restrict the popular labels to a certain space.
style - (optional) Allows 'heatmap'. Specifying a heatmap style will use different font sizes depending on their rank of popularity, ordered by label names. If not specified, a default list style is used ordered by popularity (highest first).
{contentbylabel:labels=dogs,cats}
{contentbylabel:labels=dogs,cats|space=PETS}
{contentbylabel:labels=dogs,cats|type=page,blogpost}
{contentbylabel:labels=dogs,cats|showLabels=false|showSpace=false}
{contentbylabel:labels=dogs,cats|excerpt=true}
{contentbylabel:labels=+dogs,+cats}
{contentbylabel:labels=+lebowski,+bowling,-walter|space=@all|type=page,-blogpost}
Displays a list of content marked with the specified labels.

type - (optional) search for types of content.
Accepted values:
page: basic pages
comment: comments on pages or blogs
blogpost/news: blog posts
attachment: attachments to pages or blogs
userinfo: personal information
spacedesc: space descriptions
personalspacedesc: personal space descriptions
mail: emails in a space

Prefix a type with '+' to require matches to be of that type, or '-' to exclude matches of that type.By default, matched content will be of at least one of the listed type. Separate types with commas or single-spaces.
showLabels - (optional) display the labels for each results (enabled by default)
showSpace - (optional) display space name for each result (enabled by default)
title - (optional) add a title above the results list
max/maxResults - (optional) the maximum number of results to display (default is 5)
excerpt - (optional) display first line of excerpt for each result
space/spaces - (optional) spaces to search.
Accepted values:
space keys (case-sensitive)
@self: current space
@personal: personal spaces
@global: global spaces
@favorite/@favourite: user's favourite spaces
@all/*: all spaces (that the user has permission to view)

Prefix a space with '+' to require a match or '-' to exclude any matches from that space. By default,at least one of the named spaces must match. Separate spaces with commas or single-spaces.
label/labels - (optional) search for content with these labels; prefix a label with '+' to require a match or '-' to exclude any content with that label. By default, at least one of the labels will be present on any matched content. Separate labels with commas or single-spaces.
sort - (optional) the sorting to apply to the results.
Accepted values:
title: by content title
creation: by time of creation
modified: by time of last modification (creation is the "first" modification)
reverse - (optional) reverses the currently applied sort. This parameter must be used in conjunction with the sort parameter.
{related-labels} 

{related-labels:labels=labelone, labeltwo}	
Renders a list of labels related to the current page's labels.

labels - (optional) comma-separated list of labels whose related labels will be displayed.
{recently-updated} 
{recently-updated: spaces=sales,marketing | labels=timesheets,summaries} 
{recently-updated: labels=+confluence,-jira | spaces=@all} 
{recently-updated: spaces=NOVELS,SHORTSTORIES | sort=creation | reverse=true}	
Include a list of which Confluence content has changed recently Content will be listed from the current space or for each space defined in a comma separated list (space = x, y). The list will be rendered in a table with width matching the width argument (width=z) or defaulting to 100%

space/spaces - (optional) spaces to search.
Accepted values:
space keys (case-sensitive)
@self: current space
@personal: personal spaces
@global: global spaces
@favorite/@favourite: user's favourite spaces
@all/*: all spaces (that the user has permission to view)

Prefix a space with '+' to require a match or '-' to exclude any matches from that space. By default,at least one of the named spaces must match. Separate spaces with commas or single-spaces. Defaults to the current space (@self).
label/labels - (optional) search for content with these labels; prefix a label with '+' to require a match or '-' to exclude any content with that label. By default, at least one of the labels will be present on any matched content. Separate labels with commas or single-spaces.
width - (optional) width of table on Confluence page, defaults to 100%.
type/types - (optional) search for types of content.
Accepted values:
page: basic pages
comment: comments on pages or blogs
blogpost/news: blog posts
attachment: attachments to pages or blogs
userinfo: personal information
spacedesc: space descriptions
personalspacedesc: personal space descriptions

Prefix a type with '+' to require matches to be of that type, or '-' to exclude matches of that type.By default, matched content will be of at least one of the listed type. Separate types with commas or single-spaces. Defaults to all types. In shared mode, the personal information type is excluded from the defaults.
sort - (optional) the sorting to apply to the results.
Accepted values:
title: by content title
creation: by time of creation
modified: by time of last modification (creation is the "first" modification)
reverse - (optional) reverses the currently applied sort. This parameter must be used in conjunction with the sort parameter.
{recently-used-labels} 

{recently-used-labels:scope=space|count=15}	
Renders a list (or table) of labels most recently used in a specified scope.

count - (optional) Specify the number of labels to be displayed. If not specified, a default of 10 is used.
scope - (optional) Allows 'global', 'space' and 'personal'. If not specified, the 'global' scope is used. The global scope will show labels that were recently used within this confluence instance. The space scope will show labels that were recently used in the current space. The personal scope will show you personal labels that you recently used.
style - (optional) Allows 'table'. Specifying a table style will render the most recently used labels in a table form.
title - (optional) Allows you to specify a heading for the table view of this macro. See the 'style' option above.
{navmap:mylabel} 
{navmap:mylabel|wrapAfter=3|cellWidth=110|cellHeight=20|theme=mytheme}
Renders the list of pages associated with the specified label as a navigable map. 
A label must be specified for this macro. The following parameters are all optional:

title - the title for this navigation map.
wrapAfter - the number of cells to span horizontally before wrapping to the next line. (default: 5)
cellWidth - width of individual cells in the map in pixels. (default: 90px)
cellHeight - height of individual cells in the map in pixels. (default: 60px)
theme - if you want to create your own look and feel for the navmap (say one with rounded corners), you can do so by adding a file to the WEB-INF/classes/templates/macros directory. The file name convention to use is: navmap-mytheme.vm. You can use whatever name you like in place of mytheme. Just make sure you specify this when calling the macro using theme=mytheme.
Table of Contents
Documentation
Meeting Minutes
Staff Directory
{listlabels:spaceKey=@all} 
Renders the list of all labels or labels for a specific space sorted alphabetical.

spaceKey - (optional) list the labels in the specified space (current space by default). If '@all' is specified, labels in all spaces will be listed.
A-Z documentation, staff, events, books, music
{flotchart:type=line|showShapes=yes}
|| || Democrat || Republican || Independent ||
|| Mascots | 40 | 40 | 20 |
{flotchart}
        
Displays interactive charts using tables in the macro's body as data.

type — The type chart to show. Valid values are:

line — Line chart
area — Area chart
bar — Bar chart
pie — Pie chart
step — Step chart
tables — Selects the tables in the macro body to use as chart data. Values can be a comma-separated list of table numbers or an XPath expression. By default, all tables in the macro's body will be used.

To choose tables based on their numbers, you must to specify a comma-separated list of numbers as the 'tables' parameter. For instance, tables=1,2,3. That will select the first, second and third tables for the chart data.

To choose tables based on an XPath expression, you must specify the expression as the value to the 'tables' parameter. For instance, tables=//table. That will select all the tables in the macro's body. Please note that if you wish to select tables with XPath, you need to specify the parameter 'selectTablesWithXPath=true'.

locale — The locale to use to interpret the data values in the tables. It is expressed in the format of <ISO language code>_<2-letter ISO country code> (e.g. en_US). If unspecified, the locale will default to the viewing user's locale.

numberFormat — By default, FlotChart reads numbers as is. It can't recognize special symbols such as comma, dollar signs and so forth. So if your table contains these symbols, you can specify a decimal format pattern which the plugin will use to parse the numbers in the table with.

timeSeriesFormat — This makes the plugin generate time series charts. If this is specified, the plugin will interpret values in the tables as date/time. Therefore, this parameter must be the date/time format that the plugin should interpret dates with. For more information regarding the patterns, please see SimpleDateFormat.

width — Defines the width of the chart in pixels. This defaults to 384.

height — Defines the height of the chart in pixels. This defaults to 256.

colors — The comma separated list of colors to use for the series. Any hex value (e.g. '#babe00') is valid. The default colors are decided by Flot.

showLegend — Defines whether the chart's legend is shown. This defaults to true.

legendPosition — Defines the position of the chart's legend in the chart. Valid values are ne (northeast), nw (northwest), se (southeast), se (southwest). By default, this is ne.

leftMargin — Defines the left margin of the chart. Any CSS value is valid. This defaults to 0.

showShapes — This defines whether data points are visible on the generated chart. This defaults to true.

opacity — This defines the opacity of the series in the chart. Any value in the range of 0.0 (invisible) to 1.0 (fully opaque) is valid. For area charts, this defaults to 0.5. For other charts, the defaults are decided by Flot.

timeSeriesDisplayFormat — This defines the format of dates/time shown on charts. This defaults to short months (e.g. 'Jan'). If you wish to see dates/time on charts in other formats, you can specify it here. For more information about the formats, please see Flot's documentation.

barWidth — This parameter controls the width of the bars in units of the x axis. For instance, in a time series chart, if you want the bars to take up a day's width on the x axis, you can specify 24 * 60 * 60 * 1000. You can also specify time units. For instance, to get the bar width of a day, you can specify 1d. Valid units are: m (minute), h (hour), d (day), w (week). 

For non-time series charts, the width defaults to the entire unit''s width (1). For time series charts, the width defaults to a day.

pieRadius — Sets the radius of the pie. If value is between 0 and 1 (inclusive) then it will use that as a percentage of the available space (size of the container), otherwise it will use the value as a direct pixel length.

combineThreshold — Any pie segments lesser than the percentage (0 to 1.0, inclusive) will be combined. This is 0.03 by default.

otherLabel — The label of the combined pie segments. The default is Other.

showSeriesToggle — Defines whether controls to hide/show series are shown. If true, checkboxes that correspond to series will be shown so they can be used to toggle the visibility of the series. This defaults to false.

showDataPointValue — Whether to show the Y value of a data point (when it is enabled). By default, this is false. This feature will only be enabled if its value is true and the showShapes parameter is true.

{attachments:patterns=.*doc|old=true}	
Prints a list of attachments

patterns: - (optional) a comma separated list of regular expressions. Only file names matching one of these are displayed.
old: - (optional) if "true", display old versions of attachments as well.
upload: - (optional) if "true", allow the upload of new attachments.
{toc:style=disc|indent=20px}
{toc:outline=true|indent=0px|minLevel=2}
{toc:type=flat|separator=pipe|maxLevel=3}
Creates a Table of Contents for headings on the the current page.

type - (optional) The type of output. May be one of the following:
list - (default) The headings are output in hierarchical list format.
flat - The headings are listed on a single line with a separator between them.
class - (optional) If specified, the TOC will be output with the specified CSS class. Also, if set, no other style values will be output.
style - (optional) The style of the list items if in list mode. The style may be any of the following:
none - (default) Headings are output in indented lists with no bullet points or numbers prefixing them.
any CSS style - Headings are output in indented lists with the specified CSS style.
outline - (optional) If set to true, each item will be prefixed with a number in the format 'X.Y'. The numbers will increase automatically, and extra levels will be added for lower-level headings.
ident - (optional) The amount to indent each list sub-heading by (default is '10px').
separator - (optional) The type of separator to use if the style is flat. May be one of the following:
bracket - Square brackets ('[', ']') surrounding each item. (default)
brace - Square brackets ('[', ']') surrounding each item. (default)
comma - A comma (',') between each item.
paren - Parentheses ('(', ')') surrounding each item.
pipe - A pipe ('|') between each item.
newline - A line break after each item.
"custom" - Any other character you wish, specified between quotes.
minLevel - (optional) The lowest heading level to include (inclusive). (default is 1).
maxLevel - (optional) The highest heading level to include (inclusive). (default is 7).
includePages - (optional) If 'true', any included Confluence pages will be imported and listed.
include - (optional) If set, any headings not matching the regular expression will be ignored. Due to '|' being the parameter separator in macros, use ',' where you would have usually used '|'.
exclude - (optional) If set, any headings matching the regular expression will be excluded. Due to '|' being the parameter separator in macros, use ',' where you would have usually used '|'.
printable - (optional) If set to 'false', the table of contents will not be visible when being printed.
{toc-zone:separator\=brackets|location=top}
h1. First Heading
blah blah blah...
{toc-zone}	
Creates a Table of Contents for headings contained in the macro body.

location - (optional) The location to have the table of contents output. May be 'top' or 'bottom'. If not set, it will be output at both locations.
type - (optional) The type of output. May be one of the following:
list - (default) The headings are output in hierarchical list format.
flat - The headings are listed on a single line with a separator between them.
class - (optional) If specified, the TOC will be output with the specified CSS class. Also, if set, no other style values will be output.
style - (optional) The style of the list items if in list mode. The style may be any of the following:
none - (default) Headings are output in indented lists with no bullet points or numbers prefixing them.
any CSS style - Headings are output in indented lists with the specified CSS style.
outline - (optional) If set to true, each item will be prefixed with a number in the format 'X.Y'. The numbers will increase automatically, and extra levels will be added for lower-level headings.
ident - (optional) The amount to indent each list sub-heading by (default is '10px').
separator - (optional) The type of separator to use if the style is flat. May be one of the following:
bracket - Square brackets ('[', ']') surrounding each item. (default)
brace - Square brackets ('[', ']') surrounding each item. (default)
comma - A comma (',') between each item.
paren - Parentheses ('(', ')') surrounding each item.
pipe - A pipe ('|') between each item.
newline - A line break after each item.
"custom" - Any other character you wish, specified between quotes.
minLevel - (optional) The lowest heading level to include (inclusive). (default is 1).
maxLevel - (optional) The highest heading level to include (inclusive). (default is 7).
includePages - (optional) If 'true', any included Confluence pages will be imported and listed.
include - (optional) If set, any headings not matching the regular expression will be ignored. Due to '|' being the parameter separator in macros, use ',' where you would have usually used '|'.
exclude - (optional) If set, any headings matching the regular expression will be excluded. Due to '|' being the parameter separator in macros, use ',' where you would have usually used '|'.
printable - (optional) If set to 'false', the table of contents will not be visible when being printed.
{viewfile:presentation.ppt}

{viewfile:space=dog|page=testpage|name=worddocument.doc}

{viewfile:spreadsheet.xls|grid=false|sheet=Sheet 1|row=4|col=5}

{viewfile:slideshow.pdf|width=200|height=150}	
Embeds the content of a file attachment into a Confluence page. Supported formats:

Microsoft Word Documents
- Embedded as html
Microsoft Excel Spreadsheets
- Embedded as html
Microsoft Powerpoint Presentations
- Embedded in a flash slideshow control or as a single image for individual pages
Adobe PDF files
- Embedded in a flash slideshow control or as a single image for individual pages
space: - (optional)the space key for the attachment. The default is the space of the page calling the macro.
page: - (optional)the page or blog post that contains the attachment. The default is the page calling the macro.
date: - (optional)the date of the blog post that contains the attachment in the form mm/dd/yyyy. Only applicable if the file is attached to a blog post
name: - (required)the filename of the attachment. Can also be specified as the first argument using macro shorthand. {viewfile:filename.ext}
Macro arguments specific to Excel spreadsheets
grid - (optional)If true, the worksheet gridlines will be rendered. The default is true.
sheet - (optional)The name of the worksheet to render. The default is the first sheet in the workbook
row - (optional)the last row in the worksheet to render. The default is the last row with content.
col - (optional)the last column in the worksheet to render. The default the last column with content.
Macro arguments specific to Powerpoint and PDF presentations
slide - (optional)instead of an entire slideshow, you can specify a slide index (0-based). the slide at the specified index will be rendered as a jpg image in the page.
height - (optional)overrides the default height of the flash control or image.
width - (optional)overrides the default width of the flash control or image.
{spaces:width=x} 
Displays a list of all spaces visible to the user, with linked icons leading to various space content functionality, within a table. The width parameter specifies the table width on the page.

width - (optional) width of table on Confluence page, defaults to 100%.
{recently-updated-dashboard} 
{recently-updated-dashboard: spaces=sales,marketing | labels=timesheets,summaries} 
Include a list of which Confluence content has changed recently Content will be listed from the current space or for each space defined in a comma separated list (space = x, y). The list will be rendered in a table with width matching the width argument (width=z) or defaulting to 100%

spaces - (optional) comma separated list of space keys
labels - (optional) comma separated list of labels (content associated with at least one of these will be listed)
width - (optional) width of table on Confluence page, defaults to 100%.
types - Filter content by type. You can specify one or more types, separated by commas. Accepted values:
page: basic pages
comment: comments on pages or blogs
blogpost/news: blog posts
attachment: attachments to pages or blogs
userinfo: personal information
spacedesc: space descriptions
personalspacedesc: personal space descriptions
mail: emails in a space
showProfilePic - if true, display the profile pictures of the users who updated the content.
{global-reports: width=x} 
Renders a list of links to global reports within a table of width x (defaults to 99%).

width - (optional) width of table on Confluence page, defaults to 50%.
{welcome-message} 
Include the Confluence site welcome message. The site welcome message may be configured in the Administration -> General Configuration section.

{create-space-button: size=large | width=32 | height=32} 
Renders a create space button linked to the create space page.

size - small (size of 'small' uses a smaller graphic, whereas size of 'large' uses a larger one)
height - image height in pixels
width - image width in pixels
{bookmarks}

Displays a list of bookmarks using the criteria supplied.

Searching Options

spaces comma separated list of spaces to search for. Meta space names @all, @personal, @global can also be used. (If no labels and spaces are supplied will default to current space.)
labels list of labels that are applied to the bookmarks. (If multiple labels are specified bookmarks only have to match one label to be included.)
creators comma separated list of users that have created bookmarks.
Sorting Options

sort comma separated list of attributes to sort the bookmarks by. Valid values are:
creation Bookmark Created Date
creator Bookmark Creator Name
title Bookmark title
Default is by created date.
reverseSort Reverse the order of the bookmarks. Default is false.
Display Options All options default to true.

showAuthor The user that created the bookmark.
showDate The relative date the bookmark was created.
showDescription The bookmark description.
showEditLinks If the current user has permission, show quick links to edit or remove the bookmark.
showLabels The labels for the bookmark.
showListHeader The bookmark list header (with the rss feed link).
max The maximum number of bookmarks to display. Defaults to 15.
showSpace The space the bookmark is saved in
showViewLink A link to the actual bookmark page
{pagetree}

{pagetree:root=PageName}

{pagetree:root=PageName|sort=natural|excerpt=true|reverse=false}

{pagetree:root=@home|startDepth=3}

{pagetree:searchBox=true}

{pagetree:expandCollapseAll=true}

Provides page hierachal tree within a space. If no parameters are specified the root of the tree will be the home page, a different root page can be specified by providing the page to the root parameter.

root: - (optional) page where the tree would be rooted from. Meta root names @self, @parent, @home can also be used.
sort: - (optional) sorts the tree node. It my be one of the following: bitwise, creation, modified, natural, position. Default sorting is position
excerpt: - (optional) true/false flag that indicate if a page excerpt would be included in the tree display (default is false).
reverse: - (optional) true/false flag that allows you to reverse the order of the display (default is false).
searchBox: - (optional) true/false flag that allows you to add a search box in the tree that would search from the root page (default is false).
expandCollapseAll: - (optional) true/false flag that allows you to add an expand all and a collapse all row (default is false).
startDepth: - (optional) a number that indicates the initial depth that the tree would display (default value is 1).
{pagetreesearch}

{pagetreesearch:rootPage=PageName}

{pagetreesearch:rootPage=Space:PageName}

Provides a search box to search a page hierachal tree within a space.

If no parameters are specified the root of the tree will be the current page, a different root page can be specified by providing the page to the rootPage parameter.

{livesearch:id=1|spaceKey=KEY}
Show search results keystroke by keystroke.

spaceKey: - (optional) this option searches within a single space.
Help Tips External Content
Ways to include, summarise or refer to content from other servers.

Notation	Comment
{rss:url=http://host.com/rss.xml}

{rss:url=http://host.com/rss.xml|max=5}

{rss:url=http://host.com/rss.xml|showTitlesOnly=true}

Display the contents of a remote RSS feed within the page. Note: feeds are cached for 60 minutes before being retrieved again.

The 'max' parameter can be used to limit the number of entries displayed.

Example:

 Sample RSS Feed (RSS 2.0) 
(Feed description here...)
My Item ( Dec 30, 2003 06:53) 
And part of the item content here...
Another Item ( Dec 30, 2003 06:53) 
And part of the item content here...
You can specify 'showTitlesOnly=true' to show only the RSS feed titles. This parameter defaults to false.

You can specify 'titleBar=false' to hide the feeds titlebar. This parameter defaults to true.

You can specify anonymous=false to download the target content over a trusted connection (Trusted Application). For instance {rss:url=http://example.com/path/to/target/location}. This parameter defaults to true.

{sql:dataSource=TestDS|output=wiki}
select * from test 
{sql}


There are *{sql:dataSource=TestDS|table=false} select count(*) from test01 {sql}* rows in table test01


{sql:dataSource=TestDS|p1=%test%|showsql=true} 
select * from test01 where a1 like ? 
{sql}
Displays the result table(s) or values from an SQL statement(s), usually a query. Consider using the sql-query macro for simple queries. Data from single or multiple results sets are formatted usually as a table for display. Multiple SQL statements (semi-colon separated) can be specified within a single sql macro body (subject to support provided by specific databases). This macro supports common table capabilities with other table based macros (table-plus, csv, and excel).

This macro may have restricted use for security reasons. See your administrator for details.

dataSource - Required parameter. Formerly known as the jndi parameter. For compatibility the jndi parameter will be still be used if the dataSource parameter is missing. Specify the datasource name defined in the application server. Do not use the standard prefix (java:comp/env/jdbc/) as it is added automatically if necessary. Specific values of this parameter may be restricted for security reasons. See your administrator for details.
output - Determines how the output is formated:
html - Data is output as a HTML table (default).
wiki - Data is output as a Confluence wiki table. Use this option if you want data within the table to be formated by the Confluence wiki renderer.
script - Location of sql statement. Default is the macro body only.
#filename - Data is read from the file located in confluence home directory/script/filename. Subdirectories can be specified.
global page template name - Data is read from a global page template.
space:page template name - Data is read from a space template.
^attachment - Data is read from an attachment to the current page.
page^attachment - Data is read from an attachment to the page name provided.
space:page^attachment - Data is read from an attachment to the page name provided in the space indicated.
heading - Number of rows to be considered heading rows (default is 1 row). Specify heading=false or heading=0 to not show any heading lines.
border - The border width in pixels. Defaults to normal table border width.
width - The table width in pixels. Default is 100%.
rowOrientation - By default, data is oriented with rows appearing vertically (in rows) and columns in columns. Specify rowOrientation=horizontal to have rows appear horizontally (as columns) and columns appear as rows.
columnLabel - By default, database column names are used as column labels. Specify columnLabel=true to have database column labels used for column labels. Note that most databases default the column label to be the column name when no explicit column label is provided. Fly-over text for a column label will be the column name when columnLabel=true. Fly-over text for a column label will be the database column label when columnLable=false or by default.
escape - When wiki output is requested (output=wiki), some special characters (like '|', '[', ']', '{', '}') in data may cause undesirable formatting of the table. Set escape=true to allow these special characters to be escaped so that it will not affect the formatting. The default is false so that data that has wiki markup will be handled correctly.
convertNull - Default is true. Converts SQL NULL values to blank. Set to false to have NULL values show up as 'null'.
table - Default is true. Set to false to not format the data in a table. This option can be used to run queries that produce single values that you want to include in text.
noDataError - Default is false. Set to true to show an macro error when no data is returned from the query.
expandArray - Default is true to have array fields expanded one entry per line for vertical row orientation.
showSql - Default is false. Set to true to show a panel with the sql statement.
macros - Default is false. Set to true to execute any macros so their value can be passed to the SQL query.
SQL parameter markers - SQL supports parameter markers in statements - these are identified by ?'s. Parameters p1, p2, ... are substititued for the parameter markers. This can be used to parameterize complex scripts stored as attachments or files.
p1 - first parameter marker
p2 - second parameter marker
... - ...
autoCommit - Advanced use only. Default is true. Set to false for sql that explicitly controls its own rollbacks and commits.
transactionIsolation - Advanced use only. Set the transaction isolation level for the sql statements. The default will be used unless this parameter is set to a valid value from the following list:
READ_COMMITTED (default) - any changes made inside a transaction are not visible outside it until the transaction is committed.
READ_UNCOMMITTED - allows transactions to see uncommitted changes to the data.
REPEATABLE_READ - rows that are read retain locks so that another transaction cannot change them when the transaction is not completed.
SERIALIZABLE - Tables are locked for the transaction so that WHERE conditions cannot be changed by other transactions that add values to or remove values from a table
NONE - Database does not support transactions
{sql-query:dataSource=TestDS|output=wiki}
select * from test 
{sql}

Displays a result table or values from an SQL select statement. The statement must produce a single result set. Use the sql macro for more complex select or other statements. The sql-query macro is recommended for better performance.

This macro supports the same parameters as the sql macro, the primary difference is to restrict what statements can be run.

This macro may have restricted use for security reasons. See your administrator for details.

Recursive use: Three identical macros sql-query, sql-query1, and sql-query2 are provided to enable recursive use of the macro.

{junitreport:directory=file:///c:/test-reports}
(currently only picks up result files in XML format. Set ant formatter to "xml")

{junitreport:url=file:///test-reports/TestRep.xml}	 Displays the results of a series (or single) JUnit test.
Success Rate	Tests	Failures	Time(s)	Time(s)
93%	
	
14	1	0	1.531
{updateablesql:dataSource=TestDS}
select * from test 
{sql}


{updateablesql:dataSource=TestDS|fancy=true} select id,name,location from test01 {updateablesql} 

{updateablesql:dataSource=TestDS|dateFormat=yy/mm/dd hh tt} select * from test2 {updateablesql} 

The updateable sql macro displays results from sql statements in tables. The results can be edited by users who have permissions to edit the page that a given macro is called on. For read only result display, consider using the sql or sql-query macros as they have less work for the server to perform to display the information. In addition, they have many more formatting options that are not available in the updateablesql macro.

This macro is loosely based on the sql macros by Bob Swift.

This macro may have restricted use for security reasons. See your administrator for details.

dataSource - Required parameter. Name of JDBC DataSource to retrive from JNDI. Do not use the standard prefix (java:comp/env/jdbc/) as it is added automatically. Specific values of this parameter may be restricted for security reasons. See your administrator for details.
fancy - Optional parameter to enable 'paging' and searching of data.
dateFormat - Optional parameter to display dates in results in an alternate format. The format of this string should be built based on the following table:
Mask	Description
d	Day of the month as digits; no leading zero for single-digit days.
dd	Day of the month as digits; leading zero for single-digit days.
ddd	Day of the week as a three-letter abbreviation.
dddd	Day of the week as its full name.
m	Month as digits; no leading zero for single-digit months.
mm	Month as digits; leading zero for single-digit months.
mmm	Month as a three-letter abbreviation.
mmmm	Month as its full name.
yy	Year as last two digits; leading zero for years less than 10.
yyyy	Year represented by four digits.
h	Hours; no leading zero for single-digit hours (12-hour clock).
hh	Hours; leading zero for single-digit hours (12-hour clock).
H	Hours; no leading zero for single-digit hours (24-hour clock).
HH	Hours; leading zero for single-digit hours (24-hour clock).
M	Minutes; no leading zero for single-digit minutes.
MM	Minutes; leading zero for single-digit minutes.
s	Seconds; no leading zero for single-digit seconds.
ss	Seconds; leading zero for single-digit seconds.
l or L	Milliseconds. l gives 3 digits. L gives 2 digits.
t	Lowercase, single-character time marker string: a or p.
tt	Lowercase, two-character time marker string: am or pm.
T	Uppercase, single-character time marker string: A or P.
TT	Uppercase, two-character time marker string: AM or PM.
Z	US timezone abbreviation, e.g. EST or MDT. With non-US timezones or in the Opera browser, the GMT/UTC offset is returned, e.g. GMT-0500
o	GMT/UTC timezone offset, e.g. -0500 or +0230.
S	The date's ordinal suffix (st, nd, rd, or th). Works well with d.
'…' or "…"	Literal character sequence. Surrounding quotes are removed.
UTC:	Must be the first four characters of the mask. Converts the date from local time to UTC/GMT/Zulu time before applying the mask. The "UTC:" prefix is removed. More info on this formatting is available here 
Note that this date format does not affect input. If a date field is set to dateFormat yyyy/mm/dd the info could be entered Jan 1 1999. Do not try to add any other information into date entries as they will not get parsed resulting in an error. 
The default date format display is: yyyy/mm/dd hh:MM:ss tt
{jiraissues:url=http://jira.xml.url} 

{jiraissues:url=http://jira.xml.url|
columns=type;key;summary} 

{jiraissues:url=http://jira.xml.url|
count=true} 

{jiraissues:url=http://jira.xml.url|
cache=off} 

{jiraissues:url=http://jira.xml.url?
os_username=johnsmith&os_password=secret} 

{jiraissues:url=http://jira.xml.url|
anonymous=true}	 Imports and displays JIRA issue list as inline content for the page. You can easily customize the list and order of the columns being displayed, by specifying columns parameter.
The url should be copied from the XML link of Jira's Issue Navigator. Refer to the JIRA Issues Macro documentation for further details.

To specify a custom title (the text above the columns), you can specify the title parameter. By default this is JIRA Issues. A custom title can be specified by adding title=<My Custom Title> to the macros parameters.

You can control how wide the {jiraissues} macro renders by specifying a width parameter. To specify the width in percentage, use width=XX%. To specify the width in pixels, use width=XXpx. If unspecified, the width will be 100%.

Not specifying columns will lead into the default column list and order.

Allowed columns are: key, summary, type, created, updated, assignee, reporter, priority, status, resolution.

Specifying count=true will cause the macro to just print out how many issues were in the list, without printing the list.

Using cache=off will force the macro to refresh its internal cache of Jira issues.

Note: Certain filters may require a logged-in user in order to work. If a trust association has been established between Confluence and JIRA, user authentication details will be passed between the servers automatically. This functionality requires JIRA 3.12 or later. If a trust association is not available you can send the required login by appending:
&os_username=yourJiraUsername&os_password=yourJiraPassword
to the end of your jira issues URL.

You can prevent the jiraissues macro from attempting to use a trusted application link by specifying anonymous=true. Issues will then be retrieved anonymously.

Example:

Atlassian JIRA (This file is an XML representation of some issues)
Key	Summary	Assignee	Status	Res	Updated
TEST-100	Add JIRA support	 John Gordon	 Open	UNRESOLVED	 01/Jan/04
TEST-103	Add JUnit Support	 Robert Matson	 In Progress	UNRESOLVED	 25/Dec/03
TEST-108	Add RSS Support	 Bill Watson	 In Progress	UNRESOLVED	 23/Dec/03
TEST-109	Add Search Support	 Fred Morit	 Closed	FIXED	 03/Jan/04
{jiraportlet:url=http://jira.portlet.url}	 Imports and displays JIRA 3 portlet into a Confluence page.
You can get the URL for the portlet by configuring the portlet into your JIRA dashboard. While in configuration mode, you can copy the portlet URL from the top of the portlet display.

Note: Certain filters may require a logged-in user in order to work. Hence you may need to append:
&os_username=yourJiraUsername&os_password=yourJiraPassword
to the end of your portlet url.

{plugins-supported}
{plugins-supported:profileKey=confluence}
{plugins-supported:profileKey=confluence|by=atlassian}
Lists supported plugins.

profileKey — The profile from which to get a list of plugins to display.
by — Lets you filter the list of plugins by the name of the person or organization that supports them.
{plugin-compatibility-matrix}
{plugin-compatibility-matrix:key=confluence.repository.client}>
{plugin-compatibility-matrix:key=confluence.repository.client|productStart=2.7|productEnd=2.9}
Shows a plugins compatibility with versions of a product.

key — The key of the plugin to show compatibility information of.
productStart — The starting product version to show compatibility with. For instance, you can specify a value like 2.8 and the compatibility matrix will show compatibility information of the concerned plugin with product version 2.8 and above.
productEnd — This is the same as productStart. The only difference is that this is used as the upper boundary of the product version range, instead of lower.
majorVersionsOnly — If set to true, the generated compatibility matrix will only show compatibility with major versions of the product. If this is true, the plugin will assume the concerned plugin to be compatible with a major version of a product only:
When a version of the plugin is explicitly marked compatibile with any minor version of the product, and...
The same version of the plugin is not marked incompatible with any minor version of the product.
By default, this is true.
rows — The number of the latest X versions of the plugin to show compatibility of. By default, all versions of the plugin is shown.
showBrokenBuilds — Lets you to choose whether to display broken builds as . By default, this is false and broken build cells are blank.
{im:myscreenname|service=AIM}
{im:me@hotmail.com|service=MSN|showid=false}	
impresence.template.help.label.about

impresence.template.help.label.parameters

(impresence.template.help.label.parameters.default) - impresence.template.help.label.parameters.default.description
impresence.template.help.label.parameters.service - impresence.template.help.label.parameters.service.description
impresence.template.help.label.parameters.showid - impresence.template.help.label.parameters.showid.description
{excel:file=^Report.xls}


{excel:file=Year 2005^Report.xls|sheet=First Quarter, Second Quarter}


{excel:file=excel/Report.xls|sheet=1,2,4}
Displays one or more worksheets from Microsoft Excel spreadsheets (Excel 97, 2000, 2003 workbooks). Each worksheet is shown as a table. This macro supports common table capabilities with other table based macros (table-plus, csv, and sql).

file - A required parameter unless url is specified. It specifies the location of the Excel file.
^attachment - Data is read from an attachment to the current page.
page^attachment - Data is read from an attachment to the page name provided.
space:page^attachment - Data is read from an attachment to the page name provided in the space indicated.
filename - Data is read from the file located in confluence home directory/script/filename. Subdirectories can be specified.
url - Only required if file is not specified. Specifies the URL of an Excel file. Use of this parameter may be restricted for security reasons. See your administrator for details.
sheets - By default, each sheet in the workbook will produce a table. Use the sheets parameter to control what sheets will be shown. The parameter value can be a comma separated list of sheet names (case sensitive) or sheet numbers (1-based counting)
output - Determines how the output is formated:
html - Data is output as a HTML table (default).
wiki - Data is output as a Confluence wiki table. Use this option if you want data within the table to be formated by the Confluence wiki renderer.
heading - Number of rows to be considered heading rows (default is 1 row). Specify heading=false or heading=0 to not show any heading lines.
border - The border width in pixels. Defaults to normal table border width.
width - The table width in pixels. Default is 100%.
showHidden - By default, hidden sheets, rows, and columns will not be shown. Set showHidden=true to show all data.
showSheetName - By default, the sheet name will not be shown. Set showSheetName=true to show a the sheet name before the table.
formatCell - By default, no special formating will be applied to the cells. Set formatCell=true to process each cell for special properties. Currently supported properties are:
html - Font and background color.
wiki - None at this time.
formatColumn - By default, the format for a column will be used to apply formating for all cells in the column. Set formatColumn=false to not use the column formating information from the excel sheet. Note that this parameter is ignored if formatCell=true or columnAttributes are specified.
showWiki - Default is false. Set to true to show a non-formatted version of the wiki table following the formatted table. This is used to help resolve formating issues.
escape - When wiki output is requested (output=wiki), some special characters (like '|', '[', ']', '{', '}') in data may cause undesirable formatting of the table. Set escape=true to allow these special characters to be escaped so that it will not affect the formatting. The default is false so that data that has wiki markup will be handled correctly.
hyperlinks - Default is true. Set to false to disable inclusion of cell hyperlinks.
ignoreTrailingBlankRows - By default, all trailing blank rows will be ignored. Set ignoreTrailingBlankRows=false to show these blank rows.
ignoreTrailingBlankColumns - By default, all trailing blank columns will be ignored. Set ignoreTrailingBlankColumns=false to show these blank columns.
language - If provided, the language and country specification will be used to provide number and date formats to be used for data conversion. This specification will be used before the default languages automatically used. Valid values are 2 character ISO 639-1 alpha-2 codes.
country - Used in combination with the language parameter. Valid values are 2 character ISO 3166 codes.
Help Tips Misc
Various other syntax highlighting capabilities.

Notation	Comment
\X	Escape special character X (i.e. '{')
:), :( etc	 Graphical emoticons (smileys).
Notation	:)	:(	:P	:D	;)	(y)	(n)	(i)	(/)	(x)	(!)
Image											
Notation	(+)	(-)	(?)	(on)	(off)	(*)	(*r)	(*g)	(*b)	(*y)
Image										
Help Tips Macros
Macros allow you to perform programmatic functions within a page, and can be used for generating more complex content structures.

Notation	Comment
{vote:What is your favorite color?}
Red
Blue
None of the above
{vote}

{vote:What is your favorite color?|changeableVotes=true|voters=user1,user2}
Red
Blue
None of the above
{vote}
The vote macro allows Confluence users to vote on any topic of interest. Users are allowed to select only one of the given choices and vote one time, and the results will not be visible to them until they have voted. Users that have not logged in will be prompted to do so before allowing them to cast a vote. This macro was created to support quick, informal votes on various topics. The macro has a title and a series of choices, each choice starting on its own line.

Parameter	Required	Default	Description

true	
This is the title of the ballot and must be the first paramter.
voters	false	all users	This is a comma seperated list of usernames to who are allowed to cast a vote. Users not in this list will not be allowed to vote, but if they are viewers will be shown the results of the vote. If this parameter is not specified, all users with access to the page are considered voters.
viewers	false	all users	This is a comma seperated list of usernames to who are allowed to see the survey results. Users not in this list will be allowed to vote but after doing so will simply be shown which item they voted for. If a user is in this list but is not a voter, they will be taken straight to the results. If this parameter is not specified, all users will be able to see the results.
changeableVotes	false	false	This parameter, if set to true, will allow the voters to change their vote after it has been cast.
locked	false	false	Dont allow any further voting. Show a lock Symbol to indicate that.
Before the user logs in:

What is your favorite color? (Log In to vote.)
Choices	Your Vote
Red	
Blue	
None of the above	
Before the logged-in user votes:

What is your favorite color?
Choices	Your Vote
Red	
Blue	
None of the above	
After the logged-in user votes:

What is your favorite color?
Choices	Your Vote	Current Results: (10 total votes)
Red		
(4 votes, 40%)
Blue		
(5 votes, 50%)
None of the above		
(1 votes, 10%)
{survey:changeableVotes=true|voters=user1,user2|viewers=user3}
Knowledge - This is the knowledge category.
Communication - This is the communication category.
{survey}
The survey macro allows Confluence users to be surveyed on several categories. For each category, users are allowed to select only one of the given choices, and the results will not be visible to them until they have voted. Users that have not logged in will be prompted to do so before allowing them to cast a vote. This macro was created to support surveys of confluence users on several categories and will provide them with the chance to give a rating (1 to 5) for each category as well as a comment.

The body of this macro defines the categories that the users will be polled on. Each line of the body will be treated as a seperate category and should be written in the format "title - description". The title is always required but the dash and the description are optional.

Parameter	Required	Default	Description
title	false	default no title	If a Title is specified the Survey gets a Box around which makes it looking more compact and feeling the votes are belonging more together.
voters	false	all users	This is a comma seperated list of usernames to who are allowed to cast a vote. Users not in this list will not be allowed to vote, but if they are viewers will be shown the results of the vote. If this parameter is not specified, all users with access to the page are considered voters.
viewers	false	all users	This is a comma seperated list of usernames to who are allowed to see the survey results. Users not in this list will be allowed to vote but after doing so will simply be shown which item they voted for. If a user is in this list but is not a voter, they will be taken straight to the results. If this parameter is not specified, all users will be able to see the results.
changeableVotes	false	false	This parameter, if set to true, will allow the users to change their responses after they have been cast.
choices	false	default 1-5	A comma separated List of choices. This will override the Default (1-5) List, but can still be overriden by a '-' separated list in each single line.
showComments	false	true	Show comments-menu (the whole set: show, add, edit, delete)
locked	false	false	Dont allow any further voting. Show a lock Symbol to indicate that. Image for Survey will only be displayed if you have the title-flag also. (It is still shown on the vote-elements)
Powered by Atlassian Confluence 3.0.2, the Enterprise Wiki. Bug/feature request – Atlassian news – Contact administrators
Notation Guide - Confluence

# Macro
Content by label


# SQL
sudo -u postgres psql confluencedb
select * from content where title like 'Add vl%' limit 10;
