# regex
## vi
\<[a-z0-9A-Z]\{8\}-[a-z0-9A-Z]\{4\}-[a-z0-9A-Z]\{4\}-[a-z0-9A-Z]\{4\}-[a-z0-9A-Z]\{12\}

70f4873d-120d-40d8-9b4b-8b51ca318253
bbfe7d4e-1ce2-41ec-94d3-2f893bfdb83c
3cf87be2-b0f6-43a2-ac98-b94d4ffe34a3 # length 36
3cf87be2b0f643a2ac98b94d4ffe34a3     # length 32 with hyphens


```bash
uuidgen
python3 -c 'import uuid; print(str(uuid.uuid4()))'
```


Type	Input	Algorithm	Deterministic	Use case
uuid4	None (random)	    Random	❌ No	Unique IDs without input
uuid3	Namespace + Name	MD5	✅ Yes	Stable IDs (less secure)
uuid5	Namespace + Name	SHA-1	✅ Yes	Stable IDs (preferred)


# reproductible uuid
uuid_namespace = uuid.NAMESPACE_DNS                                  # generic namespace - For domain names (e.g., "example.com")
uuid_namespace = uuid.NAMESPACE_URL                                  # generic namespace - For URLs (e.g., "https://example.com/page")
uuid_namespace = uuid.NAMESPACE_OID                                  # generic namespace - For ISO object identifiers (e.g., "1.3.6.1.4.1")
uuid_namespace = uuid.NAMESPACE_X500                                 # generic namespace - For X.500 distinguished names (e.g., "cn=John Doe,dc=example,dc=com")
uuid_namespace = uuid.uuid5(uuid.NAMESPACE_DNS, "myseed-or-context") # custom namespace so you further don't collide
id = str(uuid.uuid5(uuid_namespace, value)),


# regexp
1) UUID (generic v1–v5), canonical hyphenated
^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$

2) UUID v1
^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-1[0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$

3) UUID v2 (rare)
^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-2[0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$

4) UUID v3
^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-3[0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$

5) UUID v4
^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-4[0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$

6) UUID v5
^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-5[0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$

7) UUID (32 hex, no hyphens)
^[0-9a-fA-F]{32}$

7b) UUID (36 hex&hyphens)
^[0-9a-fA-F-]{36}$

8) Microsoft GUID with braces
^\{[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}\}$

9) URN form
^urn:uuid:[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$

10) “Any of” (hyphenated OR 32-hex OR braced OR URN)
^(?:[0-9a-fA-F]{32}|\{[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}\}|urn:uuid:[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}|[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})$
