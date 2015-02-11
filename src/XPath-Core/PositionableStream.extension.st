Extension { #name : #PositionableStream }

{ #category : #'*XPath-Core-Streams' }
PositionableStream >> asXPathReadStreamAdapter [
	^ XPathReadStreamAdapter on: self
]
