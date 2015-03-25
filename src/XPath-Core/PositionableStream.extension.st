Extension { #name : #PositionableStream }

{ #category : #'*XPath-Core-converting' }
PositionableStream >> asXPathReadStreamAdapter [
	^ XPathReadStreamAdapter on: self
]
