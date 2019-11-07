Extension { #name : #XMLStringTest }

{ #category : #'*XPath-Tests' }
XMLStringTest >> testStringValue [
	super testStringValue.

	self assert:
		(self nodeClass string: self markupString) stringValue equals:
			self markupString.
]
