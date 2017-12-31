https://forums.freebsd.org/threads/nfsv4-acls-not-being-respected-by-bsd.40982/

BSD NFSv4 ACL's, and their application on the actual BSD commandline:

    r = read file, view directory contents;
    w = create/edit/append/delete files;
    x = execute file, view directory contents;
    p = create sub-directory;
    d = allows deleting a file or directory, even if (you) don't possess ownership or write permission to it;
    D = allows deletion of a child file or child directory (subdirectory), when D is set on its parent directory; regardless of whether subject possesses ownership or write permission to the directory (on which D is set), or a child object of it; can ONLY be set on a directory object;
    a = read attributes (e.g. atime);
    A = change attributes (e.g. update a time);
    R = read xattribs;
    W = change/add xattribs;
    c = read ACL with getfacl;
    C = change/add ACL with setfacl;
    o = change owner of file (seems redundant, only root can change a file's owner);
    s = sync (also seems redundant);

 When it comes to NFSv4 ACLs, FreeBSD works (or at least is supposed to work) exactly the same way as Solaris. Same semantics, including the quirks above. (BTW, it's impressive you figured this out without looking at the source code.) Basically, the Windows semantics, without the parts that don't make sense (synchronize permission), the ones that no longer make sense (read_xattr/write_xattr permissions), and ones that would be a security hole (write_owner permission). Just like in Solaris, the append permission is ignored for regular files (means "create subdirectory" for directories), and read_acl/write_acl are always granted to the owner, to prevent footshooting.

differently from POSIX.1e ACLs, where order doesn't matter, NFSv4 ACLs are evaluated entry by entry, i.e. the order does matter. Think about it this way: for every operation you need to have some permissions. ACL is evaluated rule by rule; every "allow" rule that applies to you (i.e. user:xxx, and you're that user) gives you some permissions. If you get all the permissions you need - you are allowed to proceed. If you hit a "deny" rule before that happens - the access is denied. 


copy acl from one file to another:
getfacl -v FILESOURCE | setfacl -b -n -M - FILEDEST
