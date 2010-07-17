"
This class represents a node with elements. You will likely use its API through XMLDocument or XMLElement.

To retrieve child elements by name, you can send any of the #element- messages in ""accessing."" The #firstTag- messages search the receiver and its descendants using depth-first traversal for specific elements, and the #tagsNamed- messages iterate over descendent elements also using depth-first traversal.
"
Class {
	#name : #XMLNodeWithElements,
	#superclass : #XMLNode,
	#instVars : [
		'elementsAndContents',
		'uri',
		'namespace'
	],
	#category : #'XPath-XML'
}

{ #category : #accessing }
XMLNodeWithElements >> addElement: element [
	self elementsAndContents add: element
]

{ #category : #accessing }
XMLNodeWithElements >> addEntity: entityName value: entityValue [
	self entities add: entityName->entityValue
]

{ #category : #accessing }
XMLNodeWithElements >> elementAfter: anElement [
	^ self elements after: anElement
]

{ #category : #accessing }
XMLNodeWithElements >> elementAt: entityName [
	^self elementAt: entityName ifAbsent: [nil]
]

{ #category : #accessing }
XMLNodeWithElements >> elementAt: entityName ifAbsent: aBlock [
	elementsAndContents
		ifNil: [^aBlock value].
	^self elements detect: [:each | each isProcessingInstruction not and: [each name = entityName or: [each localName = entityName]]] ifNone: [^aBlock value]
]

{ #category : #accessing }
XMLNodeWithElements >> elementAtAny: aStringArray [
	^ self elementAtAny: aStringArray ifAbsent: [nil]
]

{ #category : #accessing }
XMLNodeWithElements >> elementAtAny: aStringArray ifAbsent: aBlock [
	| answer |

	aStringArray do: [:each | (answer := self elementAt: each) ifNotNil: [^ answer]].
	^ aBlock value.
]

{ #category : #accessing }
XMLNodeWithElements >> elementBefore: anElement [
	^ self elements before: anElement
]

{ #category : #accessing }
XMLNodeWithElements >> elementCache [
	^ elementCache ifNil: [elementCache := XMLElementCache new]
]

{ #category : #accessing }
XMLNodeWithElements >> elementUnqualifiedAt: entityName [
	^self elementUnqualifiedAt: entityName ifAbsent: [nil]
]

{ #category : #accessing }
XMLNodeWithElements >> elementUnqualifiedAt: entityName ifAbsent: aBlock [
	elementsAndContents
		ifNil: [^aBlock value].
	^self elements detect: [:each | each localName = entityName] ifNone: [^aBlock value]
]

{ #category : #accessing }
XMLNodeWithElements >> elements [
	^self elementsAndContents
]

{ #category : #accessing }
XMLNodeWithElements >> elementsAndContents [
	elementsAndContents ifNil: [elementsAndContents := OrderedCollection new].
	^elementsAndContents
]

{ #category : #accessing }
XMLNodeWithElements >> elementsAt: aString [
	^ self elementCache elementsNamed: aString
]

{ #category : #enumerating }
XMLNodeWithElements >> elementsAt: aString do: aBlock [
	(self elementsAt: aString) do: aBlock
]

{ #category : #accessing }
XMLNodeWithElements >> elementsAt: aString ifAbsent: aBlock [
	^ (self elementCache elementsNamed: aString) ifEmpty: aBlock.
]

{ #category : #enumerating }
XMLNodeWithElements >> elementsDo: aBlock [
	self elements do: [:each | aBlock value: each]
]

{ #category : #accessing }
XMLNodeWithElements >> firstElement [
	^ self elements first
]

{ #category : #searching }
XMLNodeWithElements >> firstTagNamed: aString [ 
	"Return the first encountered node with the specified tag. Pass the message on"

	^ self recurseUntilTrue: [:each | each isNamed: aString]
]

{ #category : #searching }
XMLNodeWithElements >> firstTagNamed: aString with: aBlock [
	"Return the first encountered node with the specified tag that
	allows the block to evaluate to true. Pass the message on"

	^ self recurseUntilTrue: [:each |
		(each isNamed: aString) and: [aBlock valueWithPossibleArgument: each]]
]

{ #category : #searching }
XMLNodeWithElements >> firstTagNamedAny: aStringArray [
	"Return the first encountered node with any of the specified tag names. Pass the message on"

	^ self recurseUntilTrue: [:each | each isNamedAny: aStringArray]
]

{ #category : #searching }
XMLNodeWithElements >> firstTagNamedAny: aStringArray with: aBlock [
	"Return the first encountered node with any of the specified tag names that
	allows the block to evaluate to true. Pass the message on"

	^ self recurseUntilTrue: [:each |
		(each isNamedAny: aStringArray) and: [aBlock valueWithPossibleArgument: each]]
]

{ #category : #testing }
XMLNodeWithElements >> hasElements [
	^ self elements notEmpty
]

{ #category : #testing }
XMLNodeWithElements >> includesElement: aString [
	^ (self elementAt: aString) notNil
]

{ #category : #parsing }
XMLNodeWithElements >> innerXML: aString [
	| parsedDocument newNodes |

	parsedDocument := XMLDOMParser
		parseDocumentFrom: aString
		useNamespaces: self usesNamespaces.
	newNodes := parsedDocument nodes copy.
	parsedDocument removeNodes.
	self
		removeNodes;
		addNodes: newNodes.
]

{ #category : #accessing }
XMLNodeWithElements >> lastElement [
	^ self elements last
]

{ #category : #'name space' }
XMLNodeWithElements >> namespace [
	^ namespace
]

{ #category : #'name space' }
XMLNodeWithElements >> namespace: ns uri: u [
	namespace := ns.
	uri := u
]

{ #category : #'name space' }
XMLNodeWithElements >> namespaceURI [
	^ uri
]

{ #category : #announcements }
XMLNodeWithElements >> nodeAdded: aNode [
	super nodeAdded: aNode.

	aNode isTag
		ifTrue: [self elementCache cacheElement: aNode].
]

{ #category : #announcements }
XMLNodeWithElements >> nodeRemoved: aNode [
	super nodeRemoved: aNode.

	aNode isTag
		ifTrue: [self elementCache uncacheElement: aNode].
]

{ #category : #announcements }
XMLNodeWithElements >> nodeRenamed: aNode from: anOldName to: aNewName [
	aNode isTag
		ifTrue: [self elementCache rebuildCacheFrom: self nodes].
]

{ #category : #printing }
XMLNodeWithElements >> printXMLOn: writer [
	self elementsDo: [:element | element printXMLOn: writer]
]

{ #category : #searching }
XMLNodeWithElements >> recurse: aBlock [
	"Descend depth-first visiting each element with aBlock."

	self elementsDo: [:each | each recurse: aBlock]
]

{ #category : #searching }
XMLNodeWithElements >> recurseUntilTrue: aBlock [
	"Descend depth-first visiting each element with aBlock until one such evaluation
	of aBlock with an element is true, then return that element. If no evaluation is
	true, then return nil."

	| result |

	self elementsDo: [:each | (result := each recurseUntilTrue: aBlock) ifNotNil: [^ result]].
	^ nil.
]

{ #category : #searching }
XMLNodeWithElements >> tagsNamed: aString childrenDo: aOneArgumentBlock [
	"Evaluate aOneArgumentBlock for all children who match"

	self deprecated: 'use #elementsAt:do: instead'.

	self elementsAt: aString do: aOneArgumentBlock.
]

{ #category : #searching }
XMLNodeWithElements >> tagsNamed: aString childrenDoAndRecurse: aOneArgumentBlock [
	"Evaluate aOneArgumentBlock for all children who match and recurse"

	self elementsDo: [:each | each tagsNamed: aString do: aOneArgumentBlock]
]

{ #category : #searching }
XMLNodeWithElements >> tagsNamed: aString contentsDo: aBlock [
	"Evaluate aBlock for all of the contents of the receiver.
	The receiver has no tag, so pass the message on"

	self tagsNamed: aString do: [:each | each contentsDo: aBlock]
]

{ #category : #searching }
XMLNodeWithElements >> tagsNamed: aString do: aOneArgumentBlock [
	"Search for nodes with tag aString. When encountered evaluate aOneArgumentBlock"

	self recurse: [:each | each ifNamed: aString do: aOneArgumentBlock]
]

{ #category : #searching }
XMLNodeWithElements >> tagsNamed: aString ifReceiverDoAndRecurse: aOneArgumentBlock [
	self deprecated: 'use #tagsNamed:do: instead'.

	self tagsNamed: aString do: aOneArgumentBlock.
]

{ #category : #accessing }
XMLNodeWithElements >> topElement [
	^self elements first
]
