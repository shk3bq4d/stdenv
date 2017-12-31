talend sync command

 # check status against remote directory
 svn status -u

 # visual diff against latest version which is returned from svn status -u
svn kdiff -r REV
# (which is a shortcut for)
svn diff --diff-cmd "c:\global\apps\kdiff3\kdiff3.exe" -r REV
svn diff --diff-cmd 'D:\KDiff3\kdiff3.exe' FE_0.1.item
svn diff --diff-cmd 'D:\KDiff3\kdiff3.exe' http://svn1/nova/xnet/trunk/agent/conf/evolutions/default/1.sql -r 11550


# history list versions of a file
svn log FE_0.1.item | grep -E "^r"

svn log Phase8_duplicate_1.0.item  | grep -Po '(?<=^r)\d+'  # history list of revisions

# dump all rev 
FILE=Phase8_duplicate_1.0.item; for rev in $(svn log $FILE  | grep -Po '(?<=^r)\d+'); do svn cat -r $rev $FILE > /d/tmp/svn2/${FILE}_$rev; done

# all version screenshot
FILE=RIP_Output_Main_0.18.screenshot; \
	for rev in $(svn log $FILE  | grep -Po '(?<=^r)\d+'); do \
		dest=${FILE}-r${rev}; \
		svn cat -r $rev $FILE > $dest; \
		talend_convert_screenshot $dest; \
		rm $dest; \
	done

svn update --accept=theirs-full .


#restore previous version of a file
FILE=.
REV=140
svn update
svn merge -r head:$REV $FILE
svn commit -m "Rolled back $FILE to r$REV"


#branch
svn copy http://svn1/nova/etl/trunk/talend/factureselectroniques/trunk/ http://svn1/nova/etl/trunk/talend/factureselectroniques/branches/diff4michel -m "stabilizing dev for diff tests"; 

i=entrant_traitements_0.52.item
r=25213
vi -d $i <( svn cat -r $r $i)



# svn auto add unversioned unversionned files
svn add --force * --auto-props --parents --depth infinity -q

# svn undo add
svn rm --keep-local
