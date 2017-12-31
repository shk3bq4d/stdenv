https://danielmiessler.com/study/url-uri/#gs.hEWTySc
The Difference Between URLs and URIs

Home » Study » The Difference Between URLs and URIs
URI vs. URL

[ NOTE: For more primers like this, check out my tutorial series. ]

There are many classic tech debates, and the question of what to formally call web addresses is one of the most nuanced. The way this normally manifests is someone asks for the “URL” to put into his or her browser, and someone perks up with,

Actually, that’s called a URI, not a URL…

The response to this correction can range from quietly thinking this person needs to get out more, to agreeing indifferently via shoulder shrug, to removing the safety clasp on a Katana. This page hopes to serve as a simple, one page summary for navigating the subtleties of this debate.

URI, URL, URN

As the image above indicates, there are three distinct components at play here. It’s usually best to go to the source when discussing matters like these, so here’s an exerpt from Tim Berners-Lee, et. al. in RFC 3986: Uniform Resource Identifier (URI): Generic Syntax:

A Uniform Resource Identifier (URI) is a compact sequence of characters that identifies an abstract or physical resource.

A URI can be further classified as a locator, a name, or both. The term “Uniform Resource Locator” (URL) refers to the subset of URIs that, in addition to identifying a resource, provide a means of locating the resource by describing its primary access mechanism (e.g., its network “location”).

Wikipedia captures this well with the following simplification:

One can classify URIs as locators (URLs), or as names (URNs), or as both. A Uniform Resource Name (URN) functions like a person’s name, while a Uniform Resource Locator (URL) resembles that person’s street address. In other words: the URN defines an item’s identity, while the URL provides a method for finding it.

So we get a few things from these descriptions:

First of all (as we see in the diagram as well) a URL is a type of URI. So if someone tells you that a URL is not a URI, he’s wrong. But that doesn’t mean all URIs are URLs. All butterflies fly, but not everything that flies is a butterfly.
The part that makes a URI a URL is the inclusion of the “access mechanism”, or “network location”, e.g. http:// or ftp://.
The URN is the “globally unique” part of the identification; it’s a unique name.
So let’s look at some examples of URIs—again from the RFC:

ftp://ftp.is.co.za/rfc/rfc1808.txt (also a URL because of the protocol)
http://www.ietf.org/rfc/rfc2396.txt (also a URL because of the protocol)
ldap://[2001:db8::7]/c=GB?objectClass?one (also a URL because of the protocol)
mailto:John.Doe@example.com (also a URL because of the protocol)
news:comp.infosystems.www.servers.unix (also a URL because of the protocol)
tel:+1-816-555-1212
telnet://192.0.2.16:80/ (also a URL because of the protocol)
urn:oasis:names:specification:docbook:dtd:xml:4.1.2
Those are all URIs, and some of them are URLs. Which are URLs? The ones that show you how to get to them. Again, the name vs. address analogy serves well.

WHICH IS MORE ACCURATE?

So this brings us to the question that brings many readers here:

Which is the more proper term when referring to web addresses?
Based on the dozen or so articles and RFCs I read while researching this article, I’d say that depends on a very simple thing: whether you give the full thing or just a piece.

Why?

Well, because we often use URIs in forms that don’t technically qualify as a URL. For example, you might be told that a file you need is located at files.hp.com. That’s a URI, not a URL—and that system might very well respond to many protocols over many ports.

If you go to http://files.hp.com you could conceivably get completely different content than if you go to ftp://files.hp.com. And this type of thing is only getting more common. Think of all the different services that live on the various Google domains.

So, if you use URI you’ll always be technically correct, and if you use URL you might not be.

But if you definitely dealing with an actual full URL, then “URL” is most accurate because it’s most specific. Humans are technically African apes, and dogs are mammals, but we rightly call them humans and dogs, respectively. And if you’re an American from San Francisco, and you meet someone from Sydney while in Boston, you wouldn’t say you’re from Earth, or from the United States. You’d say California, or—even better—San Francisco.

So until something changes, URI is best used when you’re referring to a resource just by its name or some other fragment. And when you’re giving both the name of a resource and the method of accessing it (like a full URL), it’s best to call that a URL.

SUMMARY

URIs are identifiers, and that can mean name, location, or both
All URNs and URLs are URIs, but the opposite is not true
The part that makes something a URL is the combination of the name and an access method, such as https://, or mailto:
If you are discussing something that’s both a full URL and a URI (which all URLs are), it’s best to call it a “URL” because it’s most specific
