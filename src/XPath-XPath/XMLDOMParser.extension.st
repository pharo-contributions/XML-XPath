Extension { #name : #XMLDOMParser }

{ #category : #'*xpath-content' }
XMLDOMParser >> characters: aString [ 
	| newElement |
	newElement := XMLStringNode string: aString.
	newElement parent: self top.
	self top addContent: newElement
]

{ #category : #'*xpath-content' }
XMLDOMParser >> processingInstruction: piName data: dataString [ 
	| newElement |
	newElement := XMLPI target: piName data: dataString.
	newElement parent: self top.
	self top addElement: newElement
]

{ #category : #'*xpath-content' }
XMLDOMParser >> startElement: elementName attributeList: attributeList [ 
	| newElement |
	newElement := XMLElement named: elementName attributes: attributeList.
	newElement parent: self top.
	self incremental
		ifFalse: [self stack isEmpty
				ifFalse: [self top addElement: newElement]].
	self push: newElement
]
