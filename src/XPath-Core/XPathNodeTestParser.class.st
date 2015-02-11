"
This class parses node tests that are either node name tests like 'name' or '*' or node type tests like 'node()' or 'comment()'.
"
Class {
	#name : #XPathNodeTestParser,
	#superclass : #XPathParser,
	#instVars : [
		'nameStartPosition'
	],
	#classVars : [
		'NodeTypeParserSelectors'
	],
	#category : #'XPath-Core-Parsers'
}

{ #category : #'class initialization' }
XPathNodeTestParser class >> initialize [ 
	"self initialize"

	self initializeNodeTypeParserSelectors
]

{ #category : #'class initialization' }
XPathNodeTestParser class >> initializeNodeTypeParserSelectors [
	(NodeTypeParserSelectors := Dictionary new)
		at: 'comment' put: #nextCommentNodeTypeTest;
		at: 'text' put: #nextTextNodeTypeTest;
		at: 'processing-instruction' put: #nextPINodeTypeTest;
		at: 'node' put: #nextNodeNodeTypeTest
]

{ #category : #parsing }
XPathNodeTestParser >> nextCommentNodeTypeTest [
	self nextEmptyArgumentList.
	handler handleTestForCommentType.
]

{ #category : #parsing }
XPathNodeTestParser >> nextExpandedNameTest [
	handler
		handleTestForNamespaceURI: (self expectUpTo: $})
		localName: self nextNCName
]

{ #category : #parsing }
XPathNodeTestParser >> nextLocalNameOrNodeTypeTest: aName [
	inputStream skipSeparators.
	inputStream peek == $: "axis specifier"
		ifTrue: [^ self pushBackNCName: aName].
	inputStream peek == $(
		ifTrue: [^ self nextNodeTypeTestOrFunction: aName].

	handler handleTestForLocalName: aName.
]

{ #category : #parsing }
XPathNodeTestParser >> nextNodeNodeTypeTest [
	self nextEmptyArgumentList.
	handler handleTestForNodeType.
]

{ #category : #parsing }
XPathNodeTestParser >> nextNodeTypeTestOrFunction: aNodeType [
	self perform:
		(NodeTypeParserSelectors
			at: aNodeType
			ifAbsent: [^ self pushBackNCName: aNodeType])
]

{ #category : #parsing }
XPathNodeTestParser >> nextPINodeTypeTest [
	self nextStartArgumentList.
	inputStream skipSeparators.
	handler handleTestForPIType:
		((self nextStringLiteralOptional: true) ifNil: ['']).
	self nextEndArgumentList.
]

{ #category : #parsing }
XPathNodeTestParser >> nextQualifiedNameTestOrFunction: aPrefix [
	| localName |

	(inputStream peekFor: $*)
		ifTrue: [^ handler handleTestForAnyLocalNameAfterPrefix: aPrefix].
	localName := self nextNCName.
	inputStream skipSeparators.
	inputStream peek == $( "function"
		ifTrue: [^ self pushBackName: (localName qualifyWithPrefix: aPrefix)].
	^ handler
		handleTestForPrefix: aPrefix
		localName: localName.
]

{ #category : #parsing }
XPathNodeTestParser >> nextTextNodeTypeTest [
	self nextEmptyArgumentList.
	handler handleTestForTextType.
]

{ #category : #parsing }
XPathNodeTestParser >> nextWildCardNameTest [
	(inputStream peekFor: $:)
		ifTrue: [
			(inputStream peekFor: $*)
				ifTrue: [handler handleTestForAnyName]
				ifFalse: [handler handleTestForAnyPrefixBeforeLocalName: self nextNCName]]
		ifFalse: [handler handleTestForAnyName]
]

{ #category : #parsing }
XPathNodeTestParser >> parseInput [
	| name |

	inputStream skipSeparators.
	inputStream atEnd
		ifTrue: [
			handler handleEmptyTest.
			^ self].

	(inputStream peekFor: $*)
		ifTrue: [^ self nextWildCardNameTest].

	nameStartPosition := inputStream position.
	(name := self nextNCNameOptional: true)
		ifNil: [
			handler handleEmptyTest.
			^ self].
	(name = 'Q'
		and: [inputStream peekFor: ${])
		ifTrue: [^ self nextExpandedNameTest].
	(inputStream peekFor: $:)
		ifTrue: [
			(inputStream peekFor: $:) "axis specifier"
				ifTrue: [^ self pushBackName: name]
				ifFalse: [^ self nextQualifiedNameTestOrFunction: name]].

	self nextLocalNameOrNodeTypeTest: name.
]

{ #category : #private }
XPathNodeTestParser >> pushBackNCName: aLocalName [
	inputStream pushBackToken:
		(XPathPushedBackNCNameToken
			token: aLocalName
			position: nameStartPosition).
	handler handleEmptyTest.
]

{ #category : #private }
XPathNodeTestParser >> pushBackName: aLocalName [
	inputStream pushBackToken:
		(XPathPushedBackNameToken
			token: aLocalName
			position: nameStartPosition).
	handler handleEmptyTest.
]
