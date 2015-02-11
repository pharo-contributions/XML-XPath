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
XMLPI >> hasPrefix [
	^ false
]

{ #category : #'*XPath-Core-DOM' }
XMLPI >> localName [
	^ self target
]

{ #category : #'*XPath-Core-DOM' }
XMLPI >> name [
	^ self localName
]

{ #category : #'*XPath-Core-DOM' }
XMLPI >> namespaceURI [
	"The spec says the namespace URI part of an expanded name is null"
	^ ''
]
