# regex
## vi
\<[a-z0-9A-Z]\{8\}-[a-z0-9A-Z]\{4\}-[a-z0-9A-Z]\{4\}-[a-z0-9A-Z]\{4\}-[a-z0-9A-Z]\{12\}


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
