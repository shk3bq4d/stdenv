
# JQL
status changed BY currentUser() order by updated DESC
(summary ~ currentUser() OR description ~ currentUser() OR comment ~ currentUser()) and updatedDate >= -7d
comment ~ currentUser() ORDER BY updatedDate DESC
AND creator in (admintkr) # createdby
AND creator in (currentUser()) # createdby
and status not in (DONE)
issuekey in issueHistory() order by lastViewed DESC # viewed recently
assignee = currentUser() AND resolution = Unresolved AND status != dump AND status != Abandoned AND project not in ("Blockchain Engineering") order by updated DESC

<MMH-7> # mention link issue ticket DOESNT WORK IN COMMENT, TO BE CONFIRMED ELSEWHERE
MMH-7 # mention link issue ticket WORKS IN COMMENT


 |  __init__(self, options, session, raw=None)
 |
 |  add_field_value(self, field, value)
 |      Add a value to a field that supports multiple values, without resetting the existing values.
 |
 |      This should work with: labels, multiple checkbox lists, multiple select
 |
 |  delete(self, deleteSubtasks=False)
 |      Delete this issue from the server.
 |
 |      :param deleteSubtasks: if the issue has subtasks, this argument must be set to true for the call to succeed.
 |
 |  permalink(self)
 |      Get the URL of the issue, the browsable one not the REST one.
 |
 |      :return: URL of the issue
 |
 |  update(self, fields=None, update=None, async=None, jira=None, notify=True, **fieldargs)
 |      Update this issue on the server.
 |
 |      Each keyword argument (other than the predefined ones) is treated as a field name and the argument's value
 |      is treated as the intended value for that field -- if the fields argument is used, all other keyword arguments
 |      will be ignored.
 |
 |      JIRA projects may contain many different issue types. Some issue screens have different requirements for
 |      fields in an issue. This information is available through the :py:meth:`.JIRA.editmeta` method. Further examples
 |      are available here: https://developer.atlassian.com/display/JIRADEV/JIRA+REST+API+Example+-+Edit+issues
 |
 |      :param fields: a dict containing field names and the values to use
 |
 |      :param update: a dict containing update operations to apply
 |
 |      keyword arguments will generally be merged into fields, except lists, which will be merged into updates
 |
 |  ----------------------------------------------------------------------
 |  Methods inherited from Resource:
 |
 |  __getattr__(self, item)
 |      Allow access of attributes via names.
 |
 |  __repr__(self)
 |      Identify the class and include any and all relevant values.
 |
 |  __str__(self)
 |      Return the first value we find that is likely to be human readable.
 |
 |  find(self, id, params=None)
 |
 |  ----------------------------------------------------------------------
 |  Data descriptors inherited from Resource:
 |
 |  __dict__
 |      dictionary for instance variables (if defined)
 |
 |  __weakref__
 |      list of weak references to the object (if defined)
 |
 |  ----------------------------------------------------------------------
 |  Data and other attributes inherited from Resource:
 |
 |  JIRA_BASE_URL = u'{server}/rest/{rest_path}/{rest_api_version}/{path}'

<JIRA Issue: key=u'MMH-57', id=u'12905'>
@begin=python@
{'_base_url': u'{server}/rest/{rest_path}/{rest_api_version}/{path}',
 '_options': {u'agile_rest_api_version': u'1.0',
              u'agile_rest_path': u'greenhopper',
              u'async': False,
              u'check_update': False,
              u'client_cert': None,
              u'context_path': u'/',
              u'headers': {u'Cache-Control': u'no-cache',
                           u'Content-Type': u'application/json',
                           u'X-Atlassian-Token': u'no-check'},
              u'resilient': True,
              u'rest_api_version': u'2',
              u'rest_path': u'api',
              u'server': 'https://hehe.atlassian.net',
              u'verify': True},
 '_resource': u'issue/{0}',
 '_session': <jira.resilientsession.ResilientSession object at 0x7fe1d8055b10>,
 'expand': u'renderedFields,names,schema,operations,editmeta,changelog,versionedRepresentations',
 'fields': <class 'jira.resources.PropertyHolder'>,
 'id': u'12905',
 'key': u'MMH-57',
 'raw': {u'expand': u'renderedFields,names,schema,operations,editmeta,changelog,versionedRepresentations',
         u'fields': {u'aggregateprogress': {u'progress': 0, u'total': 0},
                     u'aggregatetimeestimate': None,
                     u'aggregatetimeoriginalestimate': None,
                     u'aggregatetimespent': None,
                     u'assignee': None,
                     u'attachment': [],
                     u'comment': {u'comments': [{u'author': {u'active': True,
                                                             u'avatarUrls': {u'16x16': u'https://avatar-cdn.atlassian.com/d979c344189c02e0efaa3b9fd8d792fa?s=16&d=https%3A%2F%2Fsecure.gravatar.com%2Favatar%2Fd979c344189c02e0efaa3b9fd8d792fa%3Fd%3Dmm%26s%3D16%26noRedirect%3Dtrue',
                                                                             u'24x24': u'https://avatar-cdn.atlassian.com/d979c344189c02e0efaa3b9fd8d792fa?s=24&d=https%3A%2F%2Fsecure.gravatar.com%2Favatar%2Fd979c344189c02e0efaa3b9fd8d792fa%3Fd%3Dmm%26s%3D24%26noRedirect%3Dtrue',
                                                                             u'32x32': u'https://avatar-cdn.atlassian.com/d979c344189c02e0efaa3b9fd8d792fa?s=32&d=https%3A%2F%2Fsecure.gravatar.com%2Favatar%2Fd979c344189c02e0efaa3b9fd8d792fa%3Fd%3Dmm%26s%3D32%26noRedirect%3Dtrue',
                                                                             u'48x48': u'https://avatar-cdn.atlassian.com/d979c344189c02e0efaa3b9fd8d792fa?s=48&d=https%3A%2F%2Fsecure.gravatar.com%2Favatar%2Fd979c344189c02e0efaa3b9fd8d792fa%3Fd%3Dmm%26s%3D48%26noRedirect%3Dtrue'},
                                                             u'displayName': u'chris.who@hypersecure-security.com',
                                                             u'emailAddress': u'chris.who@hypersecure-security.com',
                                                             u'key': u'chris.who@hypersecure-security.com',
                                                             u'name': u'chris.who@hypersecure-security.com',
                                                             u'self': u'https://hehe.atlassian.net/rest/api/2/user?username=chris.who%40hypersecure-security.com',
                                                             u'timeZone': u'America/New_York'},
                                                 u'body': u'Nagra username is mcardle',
                                                 u'created': u'2017-06-01T18:54:48.530-0400',
                                                 u'id': u'10866',
                                                 u'self': u'https://hehe.atlassian.net/rest/api/2/issue/12905/comment/10866',
                                                 u'updateAuthor': {u'active': True,
                                                                   u'avatarUrls': {u'16x16': u'https://avatar-cdn.atlassian.com/d979c344189c02e0efaa3b9fd8d792fa?s=16&d=https%3A%2F%2Fsecure.gravatar.com%2Favatar%2Fd979c344189c02e0efaa3b9fd8d792fa%3Fd%3Dmm%26s%3D16%26noRedirect%3Dtrue',
                                                                                   u'24x24': u'https://avatar-cdn.atlassian.com/d979c344189c02e0efaa3b9fd8d792fa?s=24&d=https%3A%2F%2Fsecure.gravatar.com%2Favatar%2Fd979c344189c02e0efaa3b9fd8d792fa%3Fd%3Dmm%26s%3D24%26noRedirect%3Dtrue',
                                                                                   u'32x32': u'https://avatar-cdn.atlassian.com/d979c344189c02e0efaa3b9fd8d792fa?s=32&d=https%3A%2F%2Fsecure.gravatar.com%2Favatar%2Fd979c344189c02e0efaa3b9fd8d792fa%3Fd%3Dmm%26s%3D32%26noRedirect%3Dtrue',
                                                                                   u'48x48': u'https://avatar-cdn.atlassian.com/d979c344189c02e0efaa3b9fd8d792fa?s=48&d=https%3A%2F%2Fsecure.gravatar.com%2Favatar%2Fd979c344189c02e0efaa3b9fd8d792fa%3Fd%3Dmm%26s%3D48%26noRedirect%3Dtrue'},
                                                                   u'displayName': u'chris.who@hypersecure-security.com',
                                                                   u'emailAddress': u'chris.who@hypersecure-security.com',
                                                                   u'key': u'chris.who@hypersecure-security.com',
                                                                   u'name': u'chris.who@hypersecure-security.com',
                                                                   u'self': u'https://hehe.atlassian.net/rest/api/2/user?username=chris.who%40hypersecure-security.com',
                                                                   u'timeZone': u'America/New_York'},
                                                 u'updated': u'2017-06-01T18:54:48.530-0400'}],
                                  u'maxResults': 1,
                                  u'startAt': 0,
                                  u'total': 1},
                     u'components': [],
                     u'created': u'2017-06-01T15:57:18.781-0400',
                     u'creator': {u'active': True,
                                  u'avatarUrls': {u'16x16': u'https://avatar-cdn.atlassian.com/d979c344189c02e0efaa3b9fd8d792fa?s=16&d=https%3A%2F%2Fsecure.gravatar.com%2Favatar%2Fd979c344189c02e0efaa3b9fd8d792fa%3Fd%3Dmm%26s%3D16%26noRedirect%3Dtrue',
                                                  u'24x24': u'https://avatar-cdn.atlassian.com/d979c344189c02e0efaa3b9fd8d792fa?s=24&d=https%3A%2F%2Fsecure.gravatar.com%2Favatar%2Fd979c344189c02e0efaa3b9fd8d792fa%3Fd%3Dmm%26s%3D24%26noRedirect%3Dtrue',
                                                  u'32x32': u'https://avatar-cdn.atlassian.com/d979c344189c02e0efaa3b9fd8d792fa?s=32&d=https%3A%2F%2Fsecure.gravatar.com%2Favatar%2Fd979c344189c02e0efaa3b9fd8d792fa%3Fd%3Dmm%26s%3D32%26noRedirect%3Dtrue',
                                                  u'48x48': u'https://avatar-cdn.atlassian.com/d979c344189c02e0efaa3b9fd8d792fa?s=48&d=https%3A%2F%2Fsecure.gravatar.com%2Favatar%2Fd979c344189c02e0efaa3b9fd8d792fa%3Fd%3Dmm%26s%3D48%26noRedirect%3Dtrue'},
                                  u'displayName': u'chris.who@hypersecure-security.com',
                                  u'emailAddress': u'chris.who@hypersecure-security.com',
                                  u'key': u'chris.who@hypersecure-security.com',
                                  u'name': u'chris.who@hypersecure-security.com',
                                  u'self': u'https://hehe.atlassian.net/rest/api/2/user?username=chris.who%40hypersecure-security.com',
                                  u'timeZone': u'America/New_York'},
                     u'customfield_10000': u'{}',
                     u'customfield_10001': None,
                     u'customfield_10002': [],
                     u'customfield_10006': None,
                     u'customfield_10007': None,
                     u'customfield_10100': None,
                     u'customfield_10101': None,
                     u'customfield_10102': None,
                     u'customfield_10103': {u'_links': {u'jiraRest': u'https://hehe.atlassian.net/rest/api/2/issue/12905',
                                                        u'self': u'https://hehe.atlassian.net/rest/servicedeskapi/request/12905',
                                                        u'web': u'https://hehe.atlassian.net/servicedesk/customer/portal/1/MMH-57'},
                                            u'currentStatus': {u'status': u'Waiting for support',
                                                               u'statusCategory': u'UNDEFINED',
                                                               u'statusDate': {u'epochMillis': 1496347038781,
                                                                               u'friendly': u'Yesterday 9:57 PM',
                                                                               u'iso8601': u'2017-06-01T21:57:18+0200',
                                                                               u'jira': u'2017-06-01T15:57:18.781-0400'}},
                                            u'requestType': {u'_links': {u'self': u'https://hehe.atlassian.net/rest/servicedeskapi/servicedesk/1/requesttype/7'},
                                                             u'description': u'Request access for new analyst.',
                                                             u'groupIds': [u'3'],
                                                             u'helpText': u'',
                                                             u'icon': {u'_links': {u'iconUrls': {u'16x16': u'https://hehe.atlassian.net/secure/viewavatar?avatarType=SD_REQTYPE&size=xsmall&avatarId=10404',
                                                                                                 u'24x24': u'https://hehe.atlassian.net/secure/viewavatar?avatarType=SD_REQTYPE&size=small&avatarId=10404',
                                                                                                 u'32x32': u'https://hehe.atlassian.net/secure/viewavatar?avatarType=SD_REQTYPE&size=medium&avatarId=10404',
                                                                                                 u'48x48': u'https://hehe.atlassian.net/secure/viewavatar?avatarType=SD_REQTYPE&size=large&avatarId=10404'}},
                                                                       u'id': u'10404'},
                                                             u'id': u'7',
                                                             u'issueTypeId': u'10105',
                                                             u'name': u'Onboard new analyst',
                                                             u'serviceDeskId': u'1'}},
                     u'customfield_10104': [],
                     u'customfield_10105': None,
                     u'customfield_10106': None,
                     u'customfield_10107': None,
                     u'customfield_10108': u'0|i0098n:',
                     u'customfield_10112': None,
                     u'customfield_10113': None,
                     u'customfield_10114': None,
                     u'customfield_10115': None,
                     u'customfield_10116': None,
                     u'customfield_10117': None,
                     u'customfield_10118': None,
                     u'customfield_10119': None,
                     u'customfield_10120': None,
                     u'customfield_10121': None,
                     u'customfield_10122': None,
                     u'customfield_10123': None,
                     u'customfield_10124': None,
                     u'customfield_10125': None,
                     u'customfield_10126': None,
                     u'customfield_10127': None,
                     u'customfield_10128': None,
                     u'customfield_10129': {u'_links': {u'self': u'https://hehe.atlassian.net/rest/servicedeskapi/request/12905/sla/1'},
                                            u'completedCycles': [],
                                            u'id': u'1',
                                            u'name': u'Time to resolution',
                                            u'ongoingCycle': {u'breachTime': {u'epochMillis': 1497009600000,
                                                                              u'friendly': u'09/Jun/17 2:00 PM',
                                                                              u'iso8601': u'2017-06-09T14:00:00+0200',
                                                                              u'jira': u'2017-06-09T08:00:00.000-0400'},
                                                              u'breached': False,
                                                              u'elapsedTime': {u'friendly': u'42m',
                                                                               u'millis': 2576057},
                                                              u'goalDuration': {u'friendly': u'45h',
                                                                                u'millis': 162000000},
                                                              u'paused': False,
                                                              u'remainingTime': {u'friendly': u'44h 17m',
                                                                                 u'millis': 159423943},
                                                              u'startTime': {u'epochMillis': 1496347038856,
                                                                             u'friendly': u'Yesterday 9:57 PM',
                                                                             u'iso8601': u'2017-06-01T21:57:18+0200',
                                                                             u'jira': u'2017-06-01T15:57:18.856-0400'},
                                                              u'withinCalendarHours': True}},
                     u'customfield_10130': {u'_links': {u'self': u'https://hehe.atlassian.net/rest/servicedeskapi/request/12905/sla/2'},
                                            u'completedCycles': [],
                                            u'id': u'2',
                                            u'name': u'Time to first response',
                                            u'ongoingCycle': {u'breachTime': {u'epochMillis': 1496739600000,
                                                                              u'friendly': u'06/Jun/17 11:00 AM',
                                                                              u'iso8601': u'2017-06-06T11:00:00+0200',
                                                                              u'jira': u'2017-06-06T05:00:00.000-0400'},
                                                              u'breached': False,
                                                              u'elapsedTime': {u'friendly': u'42m',
                                                                               u'millis': 2576051},
                                                              u'goalDuration': {u'friendly': u'18h',
                                                                                u'millis': 64800000},
                                                              u'paused': False,
                                                              u'remainingTime': {u'friendly': u'17h 17m',
                                                                                 u'millis': 62223949},
                                                              u'startTime': {u'epochMillis': 1496347038856,
                                                                             u'friendly': u'Yesterday 9:57 PM',
                                                                             u'iso8601': u'2017-06-01T21:57:18+0200',
                                                                             u'jira': u'2017-06-01T15:57:18.856-0400'},
                                                              u'withinCalendarHours': True}},
                     u'customfield_10131': {u'_links': {u'self': u'https://hehe.atlassian.net/rest/servicedeskapi/request/12905/sla/3'},
                                            u'completedCycles': [],
                                            u'id': u'3',
                                            u'name': u'Time to close after resolution'},
                     u'customfield_10132': {u'_links': {u'self': u'https://hehe.atlassian.net/rest/servicedeskapi/request/12905/sla/4'},
                                            u'completedCycles': [],
                                            u'id': u'4',
                                            u'name': u'Time to approve normal change'},
                     u'customfield_10133': None,
                     u'customfield_10134': None,
                     u'customfield_10135': None,
                     u'customfield_10136': None,
                     u'customfield_10137': None,
                     u'customfield_10138': None,
                     u'customfield_10139': None,
                     u'customfield_10140': None,
                     u'customfield_10200': None,
                     u'description': u'Jacob Mcardle starting 06/05 as Level 1 Analyst. ',
                     u'duedate': u'2017-06-05',
                     u'environment': None,
                     u'fixVersions': [],
                     u'issuelinks': [],
                     u'issuetype': {u'avatarId': 10443,
                                    u'description': u'Created by JIRA Service Desk.',
                                    u'iconUrl': u'https://hehe.atlassian.net/secure/viewavatar?size=xsmall&avatarId=10443&avatarType=issuetype',
                                    u'id': u'10105',
                                    u'name': u'Service Request',
                                    u'self': u'https://hehe.atlassian.net/rest/api/2/issuetype/10105',
                                    u'subtask': False},
                     u'labels': [],
                     u'lastViewed': u'2017-06-02T02:58:54.098-0400',
                     u'priority': {u'iconUrl': u'https://hehe.atlassian.net/images/icons/priorities/medium.svg',
                                   u'id': u'3',
                                   u'name': u'Medium',
                                   u'self': u'https://hehe.atlassian.net/rest/api/2/priority/3'},
                     u'progress': {u'progress': 0, u'total': 0},
                     u'project': {u'avatarUrls': {u'16x16': u'https://hehe.atlassian.net/secure/projectavatar?size=xsmall&pid=10001&avatarId=10800',
                                                  u'24x24': u'https://hehe.atlassian.net/secure/projectavatar?size=small&pid=10001&avatarId=10800',
                                                  u'32x32': u'https://hehe.atlassian.net/secure/projectavatar?size=medium&pid=10001&avatarId=10800',
                                                  u'48x48': u'https://hehe.atlassian.net/secure/projectavatar?pid=10001&avatarId=10800'},
                                  u'id': u'10001',
                                  u'key': u'MMH',
                                  u'name': u'MMH Support',
                                  u'self': u'https://hehe.atlassian.net/rest/api/2/project/10001'},
                     u'reporter': {u'active': True,
                                   u'avatarUrls': {u'16x16': u'https://avatar-cdn.atlassian.com/d979c344189c02e0efaa3b9fd8d792fa?s=16&d=https%3A%2F%2Fsecure.gravatar.com%2Favatar%2Fd979c344189c02e0efaa3b9fd8d792fa%3Fd%3Dmm%26s%3D16%26noRedirect%3Dtrue',
                                                   u'24x24': u'https://avatar-cdn.atlassian.com/d979c344189c02e0efaa3b9fd8d792fa?s=24&d=https%3A%2F%2Fsecure.gravatar.com%2Favatar%2Fd979c344189c02e0efaa3b9fd8d792fa%3Fd%3Dmm%26s%3D24%26noRedirect%3Dtrue',
                                                   u'32x32': u'https://avatar-cdn.atlassian.com/d979c344189c02e0efaa3b9fd8d792fa?s=32&d=https%3A%2F%2Fsecure.gravatar.com%2Favatar%2Fd979c344189c02e0efaa3b9fd8d792fa%3Fd%3Dmm%26s%3D32%26noRedirect%3Dtrue',
                                                   u'48x48': u'https://avatar-cdn.atlassian.com/d979c344189c02e0efaa3b9fd8d792fa?s=48&d=https%3A%2F%2Fsecure.gravatar.com%2Favatar%2Fd979c344189c02e0efaa3b9fd8d792fa%3Fd%3Dmm%26s%3D48%26noRedirect%3Dtrue'},
                                   u'displayName': u'chris.who@hypersecure-security.com',
                                   u'emailAddress': u'chris.who@hypersecure-security.com',
                                   u'key': u'chris.who@hypersecure-security.com',
                                   u'name': u'chris.who@hypersecure-security.com',
                                   u'self': u'https://hehe.atlassian.net/rest/api/2/user?username=chris.who%40hypersecure-security.com',
                                   u'timeZone': u'America/New_York'},
                     u'resolution': None,
                     u'resolutiondate': None,
                     u'status': {u'description': u'This was auto-generated by JIRA Service Desk during workflow import',
                                 u'iconUrl': u'https://hehe.atlassian.net/images/icons/status_generic.gif',
                                 u'id': u'10003',
                                 u'name': u'Waiting for support',
                                 u'self': u'https://hehe.atlassian.net/rest/api/2/status/10003',
                                 u'statusCategory': {u'colorName': u'medium-gray',
                                                     u'id': 1,
                                                     u'key': u'undefined',
                                                     u'name': u'No Category',
                                                     u'self': u'https://hehe.atlassian.net/rest/api/2/statuscategory/1'}},
                     u'subtasks': [],
                     u'summary': u'Jacob Mcardle starting 06/05',
                     u'timeestimate': None,
                     u'timeoriginalestimate': None,
                     u'timespent': None,
                     u'timetracking': {},
                     u'updated': u'2017-06-01T18:54:48.530-0400',
                     u'versions': [],
                     u'votes': {u'hasVoted': False,
                                u'self': u'https://hehe.atlassian.net/rest/api/2/issue/MMH-57/votes',
                                u'votes': 0},
                     u'watches': {u'isWatching': False,
                                  u'self': u'https://hehe.atlassian.net/rest/api/2/issue/MMH-57/watchers',
                                  u'watchCount': 0},
                     u'worklog': {u'maxResults': 20,
                                  u'startAt': 0,
                                  u'total': 0,
                                  u'worklogs': []},
                     u'workratio': -1},
         u'id': u'12905',
         u'key': u'MMH-57',
         u'self': u'https://hehe.atlassian.net/rest/api/2/issue/12905'},
 'self': u'https://hehe.atlassian.net/rest/api/2/issue/12905'}
@end=python@

# JIRA formatting
*bold*
_italic_
+underline+
-strikethrough-
{color:red}colored text{color}
{color:#59afe1}colored text{color}
^superscript text^
~subscript text~
??citation??
bq. paragraph quote
{quote}blockquote{quote}


Optional comment for expedit: I will make sure I do proper due diligence with my fellow team members and the other DevOps guys.

# checkboxes
* (x) this checkbox of the checklist is square, red with a white cross x
* (-) this checkbox of the checklist is square, red with a minus -
* (/) this checkbox of the checklist is round, green with a check ✓
* (+) this checkbox of the checklist is round, green with a plus
* (*) this checkbox of the checklist is a yellow star ☆


# resolve
Marking the ticket as resolved.

Please reset it to "back in progress" if you think otherwise with info on what is expected to be done.

Automation will close the ticket within 72 hours which is a definitive state


https://hehe.atlassian.net/servicedesk/customer/portal/1/MMH-564

# email attachment
@reporter: (this is unrelated to this specific ticket. Could you please get rid of your signature when interacting with JIRA using the email interface as it make it hard for everybody to distinguish what is part of the signature and what is part of the content)

[link title|http://example.com]

https://hehe.atlassian.net/secure/admin/ConfigureCustomField!default.jspa?customFieldId=10802 # cfc roles choice

# images
!image-2020-11-03-09-09-58-323.png|thumbnail!      # small, preview
