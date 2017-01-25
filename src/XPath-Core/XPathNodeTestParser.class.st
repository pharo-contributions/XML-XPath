"
This class parses node tests that are either node name tests like 'name' and '*' or node type tests like 'node()' and 'comment()'.
"
Class {
	#name : #XPathNodeTestParser,
	#superclass : #XPathParser,
	#instVars : [
		'context',
		'isParsingNodeTypeTest'
	],
	#classVars : [
		'NodeTypeTestParserSelectors'
	],
	#category : #'XPath-Core-Parsers'
}

{ #category : #'class initialization' }
XPathNodeTestParser class >> initialize [ 
	"self initialize"

	"assign after with #yourself to avoid possible race
	conditions when reinitializing the class"
	NodeTypeTestParserSelectors :=
		Dictionary new
			at: 'comment' put: #nextCommentTest;
			at: 'text' put: #nextTextTest;
			at: 'processing-instruction' put: #nextPITest;
			at: 'node' put: #nextAnyNodeTest;
			at: 'element' put: #nextElementTest;
			at: 'attribute' put: #nextAttributeTest;
			at: 'namespace' put: #nextNamespaceTest;
			yourself
]

{ #category : #parsing }
XPathNodeTestParser >> nextAnyNodeTest [
	self nextEndArgumentList.
	context handleAnyNodeTestWith: handler.
]

{ #category : #parsing }
XPathNodeTestParser >> nextAttributeTest [
	context := XPathNodeTestParserAttributeTypeTestContext new.
	self
		peekForNodeTest;
		nextEndArgumentList.
]

{ #category : #parsing }
XPathNodeTestParser >> nextCommentTest [
	self nextEndArgumentList.
	context handleCommentTestWith: handler.
]

{ #category : #parsing }
XPathNodeTestParser >> nextElementTest [
	context := XPathNodeTestParserElementTypeTestContext new.
	self
		peekForNodeTest;
		nextEndArgumentList.
]

{ #category : #parsing }
XPathNodeTestParser >> nextEmptyTest [
	context handleEmptyTestWith: handler
]

{ #category : #parsing }
XPathNodeTestParser >> nextNamespaceTest [
	context := XPathNodeTestParserNamespaceTypeTestContext new.
	self
		peekForNodeTest;
		nextEndArgumentList.
]

{ #category : #parsing }
XPathNodeTestParser >> nextPITest [
	| name |

	inputStream skipSeparators.
	name :=
		(self nextStringLiteralOptional: true)
			ifNil: [self nextNCNameOptional: true].
	name
		ifNil: [context handlePITestWith: handler]
		ifNotNil: [
			context
				handlePITestForName: name
				with: handler].
	self nextEndArgumentList.
]

{ #category : #parsing }
XPathNodeTestParser >> nextTextTest [
	self nextEndArgumentList.
	context handleTextTestWith: handler.
]

{ #category : #parsing }
XPathNodeTestParser >> parseInput [
	context := handler defaultNodeTestParserContextClass new.
	isParsingNodeTypeTest := false.
	self peekForNodeTest.
]

{ #category : #'parsing - peeking' }
XPathNodeTestParser >> peekForExpandedNameTest: aName [
	(aName = 'Q'
		and: [inputStream peekFor: ${])
		ifTrue: [| uri |
			uri := self expectUpTo: $}.
			(inputStream peekFor: $*)
				ifTrue: [
					context
						handleTestForNamespaceURI: uri
						with: handler]
				ifFalse: [
					context
						handleTestForNamespaceURI: uri
						localName: self nextNCName
						with: handler].
			^ true]
		ifFalse: [^ false]
]

{ #category : #'parsing - peeking' }
XPathNodeTestParser >> peekForNameTestOrNoteTypeTest: aLocalName [
	inputStream skipSeparators.
	(inputStream peekFor: $:)
		ifTrue: [^ false]. ": after spaces; axis specifier"

	(isParsingNodeTypeTest not
		and: [self peekForStartArgumentList])
		ifTrue: [^ self peekForNodeTypeTest: aLocalName]
		ifFalse: [
			context
				handleTestForName: aLocalName
				with: handler.
			^ true].
]

{ #category : #'parsing - peeking' }
XPathNodeTestParser >> peekForNameTestStartingWith: anNcName [
	(inputStream peekFor: $:)
		ifTrue: [
			inputStream peek == $: ":: axis specifier"
				ifTrue: [^ false]
				ifFalse: [^ self peekForQualifiedNameTestWithPrefix: anNcName]]
		ifFalse: [
			^ (self peekForExpandedNameTest: anNcName)
				or: [self peekForNameTestOrNoteTypeTest: anNcName]]
]

{ #category : #'parsing - peeking' }
XPathNodeTestParser >> peekForNodeTest [
	inputStream skipSeparators.
	(inputStream atEnd not
		and: [self peekForWildCardNameTest
			or: [self peekForNonWildCardNameTest]])
		ifTrue: [^ true]
		ifFalse: [
			self nextEmptyTest.
			^ false]
]

{ #category : #'parsing - peeking' }
XPathNodeTestParser >> peekForNodeTypeTest: aNodeTypeOrFunctionName [
	| nodeTypeTestParserSelector |

	nodeTypeTestParserSelector :=
		NodeTypeTestParserSelectors
			at: aNodeTypeOrFunctionName
			ifAbsent: [^ false].
	isParsingNodeTypeTest := true.
	self perform: nodeTypeTestParserSelector.
	isParsingNodeTypeTest := false.
	^ true.
]

{ #category : #'parsing - peeking' }
XPathNodeTestParser >> peekForNonWildCardNameTest [
	| startPosition ncName |

	startPosition := inputStream position.
	((ncName := self nextNCNameOptional: true) notNil
		and: [self peekForNameTestStartingWith: ncName])
		ifTrue: [^ true]
		ifFalse: [
			ncName
				ifNotNil: [
					inputStream
						pushBackNCName: ncName
						position: startPosition].
			^ false].
]

{ #category : #'parsing - peeking' }
XPathNodeTestParser >> peekForQualifiedNameTestWithPrefix: aPrefix [
	(inputStream peekFor: $*)
		ifTrue: [
			context
				handleTestForPrefix: aPrefix
				with: handler.
			^ true]
		ifFalse: [| localName |
			localName := self nextNCName.
			self peekForStartArgumentList "function"
				ifTrue: [^ false]
				ifFalse: [
					context
						handleTestForPrefix: aPrefix
						localName: localName
						with: handler.
					^ true]].
]

{ #category : #'parsing - peeking' }
XPathNodeTestParser >> peekForStartArgumentList [
	inputStream skipSeparators.
	^ inputStream peekFor: $(.
]

{ #category : #'parsing - peeking' }
XPathNodeTestParser >> peekForWildCardNameTest [
	(inputStream peekFor: $*)
		ifFalse: [^ false].

	(inputStream peekFor: $:)
		ifTrue: [
			(inputStream peekFor: $*)
				ifTrue: [context handleWildcardTestWith: handler]
				ifFalse: [
					context
						handleTestForLocalName: self nextNCName
						with: handler]]
		ifFalse: [context handleWildcardTestWith: handler].
	^ true.
]
