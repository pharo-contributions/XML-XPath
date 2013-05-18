Extension { #name : #XMLNode }

{ #category : #'*XPath' }
XMLNode >> contentsDo: aBlock [

]

{ #category : #'*XPath' }
XMLNode >> elementsAndContentsDo: aBlock [
	self elementsDo: aBlock

]

{ #category : #'*XPath' }
XMLNode >> elementsDo: aBlock [

]

{ #category : #'*XPath' }
XMLNode >> firstTagNamed: aSymbol [ 
	"Return the first encountered node with the specified tag. Pass the message on"

	| answer |

	self elementsDo: [:node | (answer := node firstTagNamed: aSymbol) ifNotNil: [^answer]].
	^nil

]

{ #category : #'*XPath' }
XMLNode >> firstTagNamed: aSymbol with: aBlock [
	"Return the first encountered node with the specified tag that
	allows the block to evaluate to true. Pass the message on"

	| answer |

	self elementsDo: [:node |
		(answer := node firstTagNamed: aSymbol with: aBlock) ifNotNil: [^answer]].
	^nil
]

{ #category : #'*XPath' }
XMLNode >> tagsNamed: aSymbol childrenDo: aOneArgumentBlock [
	"Evaluate aOneArgumentBlock for all children who match"

	self elementsDo: [:each | 
		each tagsNamed: aSymbol ifReceiverDo: aOneArgumentBlock]

]

{ #category : #'*XPath' }
XMLNode >> tagsNamed: aSymbol childrenDoAndRecurse: aOneArgumentBlock [
	"Evaluate aOneArgumentBlock for all children who match and recurse"

	self elementsDo: [:each | 
		each tagsNamed: aSymbol ifReceiverDoAndRecurse: aOneArgumentBlock]

]

{ #category : #'*XPath' }
XMLNode >> tagsNamed: aSymbol contentsDo: aBlock [
	"Evaluate aBlock for all of the contents of the receiver.
	The receiver has no tag, so pass the message on"

	self elementsDo: [:each | each tagsNamed: aSymbol contentsDo: aBlock]

]

{ #category : #'*XPath' }
XMLNode >> tagsNamed: aSymbol do: aOneArgumentBlock [
	"Search for nodes with tag aSymbol. When encountered evaluate aOneArgumentBlock"

	self elementsDo: [:each | each tagsNamed: aSymbol do: aOneArgumentBlock]

]

{ #category : #'*XPath' }
XMLNode >> tagsNamed: aSymbol ifReceiverDo: aOneArgumentBlock [
	"Handled only by XMLTagNode subclass"


]

{ #category : #'*XPath' }
XMLNode >> tagsNamed: aSymbol ifReceiverDoAndRecurse: aOneArgumentBlock [
	"Recurse all children"

	self elementsDo: [:each | each tagsNamed: aSymbol ifReceiverDoAndRecurse: aOneArgumentBlock]

]

{ #category : #'*XPath' }
XMLNode >> tagsNamed: aSymbol ifReceiverOrChildDo: aOneArgumentBlock [
	"Recurse all children"

	self elementsDo: [:each | each tagsNamed: aSymbol ifReceiverDo: aOneArgumentBlock]

]
