"
This class parses node tests that are either node name tests like 'name' or '*' or node type tests like 'node()' or 'comment()'.
"
Class {
	#name : #XPathNodeTestParser,
	#superclass : #XPathParser,
	#instVars : [
		'context'
	],
	#classVars : [
		'NodeTypeTestParserSelectors'
	],
	#category : #'XPath-Core-Parsers'
}

{ #category : #'class initialization' }
XPathNodeTestParser class >> initialize [ 
	"self initialize"

	self initializeNodeTypeTestParserSelectors
]

{ #category : #'class initialization' }
XPathNodeTestParser class >> initializeNodeTypeTestParserSelectors [
	(NodeTypeTestParserSelectors := Dictionary new)
		at: 'comment' put: #nextCommentTypeTest;
		at: 'text' put: #nextTextTypeTest;
		at: 'processing-instruction' put: #nextPITypeTest;
		at: 'node' put: #nextAnyNodeTypeTest;
		at: 'element' put: #nextElementTypeTest;
		at: 'attribute' put: #nextAttributeTypeTest;
		at: 'namespace' put: #nextNamespaceTypeTest
]

{ #category : #parsing }
XPathNodeTestParser >> nextAnyNodeTypeTest [
	self nextEndArgumentList.
	context handleTestForAnyNodeTypeWith: handler.
]

{ #category : #parsing }
XPathNodeTestParser >> nextAttributeTypeTest [
	context := XPathAttributeTypeNodeTestParserContext new.
	self
		peekForNodeTest;
		nextEndArgumentList.
]

{ #category : #parsing }
XPathNodeTestParser >> nextCommentTypeTest [
	self nextEndArgumentList.
	context handleTestForCommentTypeWith: handler.
]

{ #category : #parsing }
XPathNodeTestParser >> nextElementTypeTest [
	context := XPathElementTypeNodeTestParserContext new.
	self
		peekForNodeTest;
		nextEndArgumentList.
]

{ #category : #parsing }
XPathNodeTestParser >> nextEmptyTest [
	context handleEmptyTestWith: handler
]

{ #category : #parsing }
XPathNodeTestParser >> nextNamespaceTypeTest [
	self nextEndArgumentList.
	context handleTestForNamespaceTypeWith: handler.
]

{ #category : #parsing }
XPathNodeTestParser >> nextPITypeTest [
	| name |

	inputStream skipSeparators.
	(name := self nextStringLiteralOptional: true)
		ifNil: [context handleTestForPITypeWith: handler]
		ifNotNil: [
			context
				handleTestForPIWithName: name
				with: handler].
	self nextEndArgumentList.
]

{ #category : #parsing }
XPathNodeTestParser >> nextTextTypeTest [
	self nextEndArgumentList.
	context handleTestForTextTypeWith: handler.
]

{ #category : #parsing }
XPathNodeTestParser >> parseInput [
	context := XPathInitialNodeTestParserContext new.
	self peekForNodeTest.
]

{ #category : #'parsing - peeking' }
XPathNodeTestParser >> peekForExpandedNameTest: aName [
	(aName = 'Q'
		and: [inputStream peekFor: ${])
		ifTrue: [| uri localName |
			uri := self expectUpTo: $}.
			localName := self nextNCName.
			context
				handleTestForNamespaceURI: uri
				localName: localName
				with: handler.
			^ true]
		ifFalse: [^ false]
]

{ #category : #'parsing - peeking' }
XPathNodeTestParser >> peekForNameTestOrNoteTypeTest: aLocalName [
	inputStream skipSeparators.
	(inputStream peekFor: $:)
		ifTrue: [^ false]. ": after spaces; axis specifier"

	(context isTypeTestParserContext not
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
	self perform:
		(NodeTypeTestParserSelectors
			at: aNodeTypeOrFunctionName
			ifAbsent: [^ false]).
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
				ifTrue: [context handleTestForAnyNameWith: handler]
				ifFalse: [
					context
						handleTestForLocalName: self nextNCName
						with: handler]]
		ifFalse: [context handleTestForAnyNameWith: handler].
	^ true.
]
