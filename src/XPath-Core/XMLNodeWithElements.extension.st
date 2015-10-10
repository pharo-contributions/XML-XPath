Extension { #name : #XMLNodeWithElements }

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNodeWithElements >> / aStringOrBlockOrNodeTestWithFilters [
	"child axis
	
	redefined here to prevent a conflicting Pastell method from shadowing
	the inherited implementation"
	^ (self
		childAxisSelect: aStringOrBlockOrNodeTestWithFilters asNodeTestBlock
		into: self nodeSetClass new)
			sortOrder: XPathDocumentSortOrder new;
			filterWithAll: aStringOrBlockOrNodeTestWithFilters asNodeSetFilters
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNodeWithElements >> // aStringOrBlockOrNodeTestWithFilters [
	"descendant axis
	
	redefined here to prevent a conflicting Pastell method from shadowing
	the inherited implementation"
	^ (self
		descendantAxisSelect: aStringOrBlockOrNodeTestWithFilters asNodeTestBlock
		into: self nodeSetClass new)
			sortOrder: XPathDocumentSortOrder new;
			filterWithAll: aStringOrBlockOrNodeTestWithFilters asNodeSetFilters
]

{ #category : #'*XPath-Core-accessing' }
XMLNodeWithElements >> stringValue [
	"spec says the string-value of documents and elements is all text
	descendants concatenated, so contentString can't be used because it
	inserts spaces"
	^ self rawContentString
]
