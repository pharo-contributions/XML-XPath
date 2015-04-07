Extension { #name : #PositionableStream }

{ #category : #'*XPath-Core-converting' }
PositionableStream >> asXPathReadStreamAdapter [
	^ XPathReadStreamAdapter on: self
]

{ #category : #'*XPath-Core-private' }
PositionableStream >> xPathSkipSeparators [
	"peek when atEnd is not portable and may not return nil,
	so atEnd is tested for first"
	[self atEnd not
		and: [self peek xmlParserIsSeparator]]
		whileTrue: [self next]
]
