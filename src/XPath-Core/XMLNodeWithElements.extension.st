Extension { #name : #XMLNodeWithElements }

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNodeWithElements >> / aStringOrBlockOrNodeTestWithFilters [
	"redefined here to prevent a conflicting method from the Pastell project
	from shadowing the inherited implementation if Pastell was installed"
	^ self childAxis: aStringOrBlockOrNodeTestWithFilters
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNodeWithElements >> // aStringOrBlockOrNodeTestWithFilters [
	"redefined here to prevent a conflicting method from the Pastell project
	from shadowing the inherited implementation if Pastell was installed"
	^ self descendantAxis: aStringOrBlockOrNodeTestWithFilters
]

{ #category : #'*XPath-Core-accessing' }
XMLNodeWithElements >> stringValue [
	"spec says the string-value of documents and elements is all text
	descendants concatenated, so contentString can't be used because it
	inserts spaces"
	^ self rawContentString
]
