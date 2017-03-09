"
This class is a writing AST visitor that writes the AST as XPath source code that can be parsed by an XPathExpressionParser.
"
Class {
	#name : #XPathASTSourceWritingNodeVisitor,
	#superclass : #XPathASTWritingNodeVisitor,
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #private }
XPathASTSourceWritingNodeVisitor >> emitTypeTestFor: aNodeTest with: aBlockOrNil [
	(aNodeTest hasParent
		and: [aNodeTest nodeType = aNodeTest parent principalNodeType])
		ifTrue: [
			aBlockOrNil
				ifNotNil: [aBlockOrNil value]]
		ifFalse: [
			self
				emitAll: aNodeTest nodeType name;
				emit: $(.
			aBlockOrNil
				ifNotNil: [aBlockOrNil value].
			self emit: $)].
	^ aNodeTest
]

{ #category : #'visiting - functions' }
XPathASTSourceWritingNodeVisitor >> visitArgument: anArgument [
	self previousArgument isNull
		ifFalse: [self emitAll: ', '].
	^ super visitArgument: anArgument.
]

{ #category : #'visiting - node tests' }
XPathASTSourceWritingNodeVisitor >> visitAttributeNodeTest: anAttributeNodeTest [
	^ self
		emitTypeTestFor: anAttributeNodeTest
		with: [self emit: $*]
]

{ #category : #'visiting - node tests' }
XPathASTSourceWritingNodeVisitor >> visitAttributeNodeTestForLocalName: anAttributeNodeTestForLocalName [
	^ self
		emitTypeTestFor: anAttributeNodeTestForLocalName
		with: [self emitAll: anAttributeNodeTestForLocalName localName]
]

{ #category : #'visiting - node tests' }
XPathASTSourceWritingNodeVisitor >> visitAttributeNodeTestForName: anAttributeNodeTestForName [
	^ self
		emitTypeTestFor: anAttributeNodeTestForName
		with: [self emitAll: anAttributeNodeTestForName name]
]

{ #category : #'visiting - node tests' }
XPathASTSourceWritingNodeVisitor >> visitAttributeNodeTestForNamespaceURI: anAttributeNodeTestForNamespaceURI [
	^ self
		emitTypeTestFor: anAttributeNodeTestForNamespaceURI
		with: [
			self emitAll:
				('*' expandWithXMLNamespaceURI:
					anAttributeNodeTestForNamespaceURI namespaceURI)]
]

{ #category : #'visiting - node tests' }
XPathASTSourceWritingNodeVisitor >> visitAttributeNodeTestForNamespaceURIAndLocalName: anAttributeNodeTestForNamespaceURIAndLocalName [
	^ self
		emitTypeTestFor: anAttributeNodeTestForNamespaceURIAndLocalName
		with: [
			self emitAll:
				(anAttributeNodeTestForNamespaceURIAndLocalName localName 
					expandWithXMLNamespaceURI:
						anAttributeNodeTestForNamespaceURIAndLocalName namespaceURI)]
]

{ #category : #'visiting - node tests' }
XPathASTSourceWritingNodeVisitor >> visitAttributeNodeTestForPrefix: anAttributeNodeTestForPrefix [
	^ self
		emitTypeTestFor: anAttributeNodeTestForPrefix
		with: [
			self emitAll:
				('*' qualifyWithXMLPrefix: anAttributeNodeTestForPrefix prefix)]
]

{ #category : #'visiting - node tests' }
XPathASTSourceWritingNodeVisitor >> visitAttributeNodeTestForPrefixAndLocalName: anAttributeNodeTestForPrefixAndLocalName [
	^ self
		emitTypeTestFor: anAttributeNodeTestForPrefixAndLocalName
		with: [
			self emitAll:
				(anAttributeNodeTestForPrefixAndLocalName localName
					qualifyWithXMLPrefix:
						anAttributeNodeTestForPrefixAndLocalName prefix)]
]

{ #category : #'visiting - operators' }
XPathASTSourceWritingNodeVisitor >> visitBinaryOperatorExpression: aBinaryOperatorExpression [
	self emit: $(.
	aBinaryOperatorExpression expression acceptNodeVisitor: self.
	self
		emitSpace;
		emitAll: aBinaryOperatorExpression operatorName;
		emitSpace.
	aBinaryOperatorExpression otherExpression acceptNodeVisitor: self.
	self emit: $).
	^ aBinaryOperatorExpression.
]

{ #category : #'visiting - node tests' }
XPathASTSourceWritingNodeVisitor >> visitElementNodeTest: anElementNodeTest [
	^ self
		emitTypeTestFor: anElementNodeTest
		with: [self emit: $*]
]

{ #category : #'visiting - node tests' }
XPathASTSourceWritingNodeVisitor >> visitElementNodeTestForLocalName: anElementNodeTestForLocalName [
	^ self
		emitTypeTestFor: anElementNodeTestForLocalName
		with: [self emitAll: anElementNodeTestForLocalName localName]
]

{ #category : #'visiting - node tests' }
XPathASTSourceWritingNodeVisitor >> visitElementNodeTestForName: anElementNodeTestForName [
	^ self
		emitTypeTestFor: anElementNodeTestForName
		with: [self emitAll: anElementNodeTestForName name]
]

{ #category : #'visiting - node tests' }
XPathASTSourceWritingNodeVisitor >> visitElementNodeTestForNamespaceURI: anElementNodeTestForNamespaceURI [
	^ self
		emitTypeTestFor: anElementNodeTestForNamespaceURI
		with: [
			self emitAll:
				('*' expandWithXMLNamespaceURI:
					anElementNodeTestForNamespaceURI namespaceURI)]
]

{ #category : #'visiting - node tests' }
XPathASTSourceWritingNodeVisitor >> visitElementNodeTestForNamespaceURIAndLocalName: anElementNodeTestForNamespaceURIAndLocalName [
	^ self
		emitTypeTestFor: anElementNodeTestForNamespaceURIAndLocalName
		with: [
			self emitAll:
				(anElementNodeTestForNamespaceURIAndLocalName localName 
					expandWithXMLNamespaceURI:
						anElementNodeTestForNamespaceURIAndLocalName namespaceURI)]
]

{ #category : #'visiting - node tests' }
XPathASTSourceWritingNodeVisitor >> visitElementNodeTestForPrefix: anElementNodeTestForPrefix [
	^ self
		emitTypeTestFor: anElementNodeTestForPrefix
		with: [
			self emitAll:
				('*' qualifyWithXMLPrefix: anElementNodeTestForPrefix prefix)]
]

{ #category : #'visiting - node tests' }
XPathASTSourceWritingNodeVisitor >> visitElementNodeTestForPrefixAndLocalName: anElementNodeTestForPrefixAndLocalName [
	^ self
		emitTypeTestFor: anElementNodeTestForPrefixAndLocalName
		with: [
			self emitAll:
				(anElementNodeTestForPrefixAndLocalName localName
					qualifyWithXMLPrefix:
						anElementNodeTestForPrefixAndLocalName prefix)]
]

{ #category : #'visiting - location paths' }
XPathASTSourceWritingNodeVisitor >> visitFilterExpression: aFilterExpression [
	self emit: $(.
	aFilterExpression expression acceptNodeVisitor: self.
	^ self
		emit: $);
		visitFilterable: aFilterExpression.
]

{ #category : #'visiting - location paths' }
XPathASTSourceWritingNodeVisitor >> visitFilterExpressionLocationPath: aFilterExpressionLocationPath [
	self emit: $(.
	aFilterExpressionLocationPath expression acceptNodeVisitor: self.
	^ self
		emit: $);
		visitLocationPath: aFilterExpressionLocationPath.
]

{ #category : #'visiting - functions' }
XPathASTSourceWritingNodeVisitor >> visitFunctionCall: aFunctionCall [
	self
		emitAll: aFunctionCall name;
		emit: $(.
	super visitFunctionCall: aFunctionCall.
	self emit: $).
	^ aFunctionCall.
]

{ #category : #'visiting - node tests' }
XPathASTSourceWritingNodeVisitor >> visitNamespaceNodeTest: aNamespaceNodeTest [
	^ self
		emitTypeTestFor: aNamespaceNodeTest
		with: [self emit: $*]
]

{ #category : #'visiting - node tests' }
XPathASTSourceWritingNodeVisitor >> visitNamespaceNodeTestForLocalName: aNamespaceNodeTestForLocalName [
	^ self
		emitTypeTestFor: aNamespaceNodeTestForLocalName
		with: [self emitAll: aNamespaceNodeTestForLocalName localName]
]

{ #category : #'visiting - node tests' }
XPathASTSourceWritingNodeVisitor >> visitNamespaceNodeTestForName: aNamespaceNodeTestForName [
	^ self
		emitTypeTestFor: aNamespaceNodeTestForName
		with: [self emitAll: aNamespaceNodeTestForName name]
]

{ #category : #'visiting - node tests' }
XPathASTSourceWritingNodeVisitor >> visitNamespaceNodeTestForNamespaceURI: aNamespaceNodeTestForNamespaceURI [
	^ self
		emitTypeTestFor: aNamespaceNodeTestForNamespaceURI
		with: [
			self emitAll:
				('*' expandWithXMLNamespaceURI:
					aNamespaceNodeTestForNamespaceURI namespaceURI)]
]

{ #category : #'visiting - node tests' }
XPathASTSourceWritingNodeVisitor >> visitNamespaceNodeTestForNamespaceURIAndLocalName: aNamespaceNodeTestForNamespaceURIAndLocalName [
	^ self
		emitTypeTestFor: aNamespaceNodeTestForNamespaceURIAndLocalName
		with: [
			self emitAll:
				(aNamespaceNodeTestForNamespaceURIAndLocalName localName 
					expandWithXMLNamespaceURI:
						aNamespaceNodeTestForNamespaceURIAndLocalName namespaceURI)]
]

{ #category : #'visiting - node tests' }
XPathASTSourceWritingNodeVisitor >> visitNamespaceNodeTestForPrefix: aNamespaceNodeTestForPrefix [
	^ self
		emitTypeTestFor: aNamespaceNodeTestForPrefix
		with: [
			self emitAll:
				('*' qualifyWithXMLPrefix: aNamespaceNodeTestForPrefix prefix)]
]

{ #category : #'visiting - node tests' }
XPathASTSourceWritingNodeVisitor >> visitNamespaceNodeTestForPrefixAndLocalName: aNamespaceNodeTestForPrefixAndLocalName [
	^ self
		emitTypeTestFor: aNamespaceNodeTestForPrefixAndLocalName
		with: [
			self emitAll:
				(aNamespaceNodeTestForPrefixAndLocalName localName
					qualifyWithXMLPrefix:
						aNamespaceNodeTestForPrefixAndLocalName prefix)]
]

{ #category : #'visiting - node tests' }
XPathASTSourceWritingNodeVisitor >> visitNodeTest: aNodeTest [
	self
		emitTypeTestFor: aNodeTest
		with: nil.
	^ super visitNodeTest: aNodeTest.
]

{ #category : #'visiting - literals' }
XPathASTSourceWritingNodeVisitor >> visitNumberLiteral: aNumberLiteral [
	| number |

	(number := aNumberLiteral number) isNaN
		ifTrue: [self emitAll: '(0 div 0)']
		ifFalse: [
			number isInfinite
				ifTrue: [
					number negative
						ifTrue: [self emitAll: '(-1 div 0)']
						ifFalse: [self emitAll: '(1 div 0)']]
				ifFalse: [
					number isZero
						ifTrue: [
							number isXPathNegativeZero
								ifTrue: [self emitAll: '-0.0']
								ifFalse: [self emitAll: '0.0']]
						ifFalse: [
							"otherwise, this is enough to get an acceptable
							integer or limited decimal (if the #fractionPart is
							non-zero) representation that an XPathExpressionParser
							or XPathNumberParser will understand"
							self emitAll: number asXPathString]]].

	^ aNumberLiteral.
]

{ #category : #'visiting - node tests' }
XPathASTSourceWritingNodeVisitor >> visitPINodeTestForName: aPINodeTestForName [
	^ self
		emitTypeTestFor: aPINodeTestForName
		with: [self emitAll: aPINodeTestForName name]
]

{ #category : #'visiting - predicates' }
XPathASTSourceWritingNodeVisitor >> visitPredicate: aPredicate [
	self emit: $[.
	super visitPredicate: aPredicate.
	self emit: $].
	^ aPredicate.
]

{ #category : #'visiting - steps' }
XPathASTSourceWritingNodeVisitor >> visitStep: aStep [
	(self previousStep isNull
		and: [aStep parent isRelativeLocationPath])
		ifFalse: [self emit: $/].
	self
		emitAll: aStep axisName;
		emitAll: '::'.
	super visitStep: aStep.
	^ aStep.
]

{ #category : #'visiting - literals' }
XPathASTSourceWritingNodeVisitor >> visitStringLiteral: aStringLiteral [
	| quote |

	"use whichever quote char the string doesn't contain, but
	default to the double quote"
	quote :=
		(aStringLiteral string includes: $")
			ifTrue: [$']
			ifFalse: [$"].
	self
		emit: quote;
		emitAll: aStringLiteral string;
		emit: quote.
	^ aStringLiteral.
]

{ #category : #'visiting - operators' }
XPathASTSourceWritingNodeVisitor >> visitUnaryOperatorExpression: aUnaryOperatorExpression [
	self
		emitAll: aUnaryOperatorExpression operatorName;
		emit: $(.
	super visitUnaryOperatorExpression: aUnaryOperatorExpression.
	self emit: $).
	^ aUnaryOperatorExpression.
]

{ #category : #'visiting - variables' }
XPathASTSourceWritingNodeVisitor >> visitVariableReference: aVariableReference [
	self
		emit: $$;
		emitAll: aVariableReference name
]
