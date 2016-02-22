Extension { #name : #Stream }

{ #category : #'*XPath-Core-converting' }
Stream >> asXPathReadStreamAdapter [
	^ XPathReadStreamAdapter on: self
]

{ #category : #'*XPath-Core-private' }
Stream >> xPathSkipSeparators [
	"provides consistent cross-platform separator skipping with the XML set of
	separators"
	[self atEnd not
		and: [self peek xmlParserIsSeparator]]
		whileTrue: [self next]
]
