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
		peekForNodeTestArgument;
		nextEndArgumentList.
]

{ #category : #parsing }
XPathNodeTestParser >> nextCommentTest [
	self nextEndArgumentList.
	context handleCommentNodeTestWith: handler.
]

{ #category : #parsing }
XPathNodeTestParser >> nextElementTest [
	context := XPathNodeTestParserElementTypeTestContext new.
	self
		peekForNodeTestArgument;
		nextEndArgumentList.
]

{ #category : #parsing }
XPathNodeTestParser >> nextEmptyTest [
	context handleEmptyNodeTestWith: handler
]

{ #category : #parsing }
XPathNodeTestParser >> nextNamespaceTest [
	context := XPathNodeTestParserNamespaceTypeTestContext new.
	self
		peekForNodeTestArgument;
		nextEndArgumentList.
]

{ #category : #parsing }
XPathNodeTestParser >> nextPITest [
	self peekForPITestTarget
		ifFalse: [
			context handlePINodeTestWith: handler].
	self nextEndArgumentList.
]

{ #category : #parsing }
XPathNodeTestParser >> nextTextTest [
	self nextEndArgumentList.
	context handleTextNodeTestWith: handler.
]

{ #category : #parsing }
XPathNodeTestParser >> parseInput [
	context := handler defaultNodeTestParserContextClass new.
	isParsingNodeTypeTest := false.

	self peekForNodeTest.
]

{ #category : #'parsing - peeking' }
XPathNodeTestParser >> peekForNameTestStartingWithNCName: anNCName [
	| startPosition |

	startPosition := readStream position.
	(readStream peekFor: $:)
		ifTrue: [
			readStream peek == $:
				ifFalse: [
					"'::' means anNCName is an axis specifier and not the start
					of a node test, otherwise the ':' should be followed by a '*'
					or another NCName"
					(readStream peekFor: $*)
						ifTrue: [
							"a 'prefix:*' wildcard QName test"
							context
								handleNodeTestForPrefix: anNCName
								with: handler.
							^ true]
						ifFalse: [| localName |
							localName := self nextNCName.
							self peekForStartArgumentList
								ifFalse: [
									"not a function call, so it's a 'prefix:localName'
									QName test"
									context
										handleNodeTestForPrefix: anNCName
										localName: localName
										with: handler.
									^ true]]]]
		ifFalse: [
			(anNCName = 'Q'
				and: [readStream peekFor: ${])
				ifTrue: [| uri |
					"either a 'Q{uri}*' wildcard test or a 'Q{uri}localName' test"
					uri := self expectUpTo: $}.
					(readStream peekFor: $*)
						ifTrue: [
							context
								handleNodeTestForNamespaceURI: uri
								with: handler]
						ifFalse: [
							context
								handleNodeTestForNamespaceURI: uri
								localName: self nextNCName
								with: handler].
					^ true]
				ifFalse: [
					readStream skipSeparators.
					"whitespace can be between the axis specifier and '::' separator,
					but not between the prefix and ':' QName separator, so any ':'
					not matched above but matched after #skipSeparators is an '::'
					axis separator, and anNCName is an axis specifier, not a node test"
					(readStream peekFor: $:)
						ifFalse: [
							(isParsingNodeTypeTest not
								and: [self peekForStartArgumentList])
								ifTrue: [
									(self peekForNodeTypeTest: anNCName)
										ifTrue: [^ true]]
								ifFalse: [
									context
										handleNodeTestForName: anNCName
										with: handler.
									^ true]]]].

	"anNCName is either an axis specifier or the start of a
	function call and not a node test"
	readStream position: startPosition.
	^ false.
]

{ #category : #'parsing - peeking' }
XPathNodeTestParser >> peekForNodeTest [
	^ self peekForNodeTestStartingWithWildCardOrNCName
]

{ #category : #'parsing - peeking' }
XPathNodeTestParser >> peekForNodeTestArgument [
	^ self peekForNodeTestStartingWithWildCardOrNCName
]

{ #category : #'parsing - peeking' }
XPathNodeTestParser >> peekForNodeTestStartingWithNCName [
	| startPosition ncName |

	startPosition := readStream position.
	(ncName := self nextNCNameOptional: true)
		ifNil: [^ false].
	(self peekForNameTestStartingWithNCName: ncName)
		ifFalse: [
			readStream
				pushBackNCName: ncName
				position: startPosition.
			^ false].
	^ true.
]

{ #category : #'parsing - peeking' }
XPathNodeTestParser >> peekForNodeTestStartingWithWildCard [
	(readStream peekFor: $*)
		ifFalse: [^ false].

	(readStream peekFor: $:)
		ifTrue: [
			(readStream peekFor: $*)
				ifTrue: [context handleWildcardNodeTestWith: handler]
				ifFalse: [
					context
						handleNodeTestForLocalName: self nextNCName
						with: handler]]
		ifFalse: [context handleWildcardNodeTestWith: handler].
	^ true.
]

{ #category : #'parsing - peeking' }
XPathNodeTestParser >> peekForNodeTestStartingWithWildCardOrNCName [
	readStream skipSeparators.
	(readStream atEnd not
		and: [self peekForNodeTestStartingWithWildCard
			or: [self peekForNodeTestStartingWithNCName]])
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
	^ true.
]

{ #category : #'parsing - peeking' }
XPathNodeTestParser >> peekForPITestTarget [
	| target |

	readStream skipSeparators.
	(target :=
		(self nextStringLiteralOptional: true)
			ifNil: [self nextNCNameOptional: true])
		ifNil: [^ false]
		ifNotNil: [
			context
				handlePINodeTestForName: target
				with: handler.
			^ true]
]

{ #category : #'parsing - peeking' }
XPathNodeTestParser >> peekForStartArgumentList [
	readStream skipSeparators.
	^ readStream peekFor: $(.
]
