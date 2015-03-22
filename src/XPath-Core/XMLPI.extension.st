Extension { #name : #XMLPI }

{ #category : #'*XPath-Core-DOM' }
XMLPI >> asXPathString [
	^ self data
]

{ #category : #'*XPath-Core-DOM' }
XMLPI >> expandedName [
	^ self localName expandWithNamespaceURI: self namespaceURI
]

{ #category : #'*XPath-Core-DOM' }
XMLPI >> hasExpandedName [
	^ true
]

{ #category : #'*XPath-Core-DOM' }
XMLPI >> hasNamespaceURI [
	^ false
]

{ #category : #'*XPath-Core-DOM' }
XMLPI >> hasPrefix [
	^ false
]

{ #category : #'*XPath-Core-DOM' }
XMLPI >> hasPrefixedNamespaceURI: aURI [
	^ false
]

{ #category : #'*XPath-Core-DOM' }
XMLPI >> localName [
	^ self name
]

{ #category : #'*XPath-Core-DOM' }
XMLPI >> name [
	^ self target
]

{ #category : #'*XPath-Core-DOM' }
XMLPI >> namespaceURI [
	"The spec says the namespace URI part of a PI expanded name is null"
	^ ''
]

{ #category : #'*XPath-Core-DOM' }
XMLPI >> prefix [
	^ ''
]
