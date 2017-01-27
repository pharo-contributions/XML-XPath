"
This class is an AST visitor that translates the AST to Smalltalk code that can be compiled as a block and evaluated.
"
Class {
	#name : #XPathASTTranslatingNodeVisitor,
	#superclass : #XPathASTNodeVisitor,
	#instVars : [
		'outputStream',
		'variableStack'
	],
	#classVars : [
		'InlinableFunctionNamesAndSelectors'
	],
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #'class initialization' }
XPathASTTranslatingNodeVisitor class >> initialize [
	"self initialize"

	InlinableFunctionNamesAndSelectors :=
		Dictionary new
			at: 'true' put: #emitInlinedTrueFunctionCall:;
			at: 'false' put: #emitInlinedFalseFunctionCall:;
			at: 'position' put: #emitInlinedPositionFunctionCall:;
			at: 'last' put: #emitInlinedLastFunctionCall:;
			yourself
]

{ #category : #accessing }
XPathASTTranslatingNodeVisitor >> contents [
	^ outputStream contents
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> contextNodeVariable [
	^ self topVariables at: 1
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> contextPositionVariable [
	^ self topVariables at: 2
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> contextSizeVariable [
	^ self topVariables at: 3
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> contextVariable [
	"the context doesn't change during evaluation"
	^ 'c'
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> emit: aCharacter [
	outputStream nextPut: aCharacter
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> emitAll: aString [
	outputStream nextPutAll: aString
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> emitBinaryArithmeticExpression: aBinaryExpression withOperator: aSelectorString [
	self emit: $(.
	aBinaryExpression expression acceptNodeVisitor: self.
	self
		emitNumberConversion;
		emitSpace;
		emitAll: aSelectorString.
	aBinaryExpression otherExpression acceptNodeVisitor: self.
	self
		emitNumberConversion;
		emit: $).
	^ aBinaryExpression.
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> emitBinaryComparisonExpression: aBinaryExpression withOperator: aSelectorString [
	self emit: $(.
	aBinaryExpression expression acceptNodeVisitor: self.
	self
		emitComparableConversion;
		emitSpace;
		emitAll: aSelectorString.
	aBinaryExpression otherExpression acceptNodeVisitor: self.
	self
		emitComparableConversion;
		emit: $).
	^ aBinaryExpression.
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> emitBinaryShortCircuitExpression: aBinaryExpression withOperator: aSelectorString [
	self emit: $(.
	aBinaryExpression expression acceptNodeVisitor: self.
	self
		emitBooleanConversion;
		emitSpace;
		emitAll: aSelectorString;
		emit: $[.
	aBinaryExpression otherExpression acceptNodeVisitor: self.
	self
		emitBooleanConversion;
		emitAll: '])'.
	^ aBinaryExpression.
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> emitBooleanConversion [
	self emitAll: ' asXPathBoolean'
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> emitComparableConversion [
	self emitAll: ' asXPathComparable'
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> emitEndBlock [
	self
		emit: $];
		popVariables
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> emitInlinedFalseFunctionCall: aFunctionCall [
	aFunctionCall hasArguments
		ifTrue: [self errorFalseFunctionTakesNoArguments].
	self emitAll: '(false)'.
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> emitInlinedLastFunctionCall: aFunctionCall [
	aFunctionCall hasArguments
		ifTrue: [self errorLastFunctionTakesNoArguments].
	self
		emit: $(;
		emitAll: self contextSizeVariable;
		emitAll: ' ifNil:[1])'.
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> emitInlinedPositionFunctionCall: aFunctionCall [
	aFunctionCall hasArguments
		ifTrue: [self errorPositionFunctionTakesNoArguments].
	self
		emit: $(;
		emitAll: self contextPositionVariable;
		emitAll: ' ifNil:[1])'.
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> emitInlinedTrueFunctionCall: aFunctionCall [
	aFunctionCall hasArguments
		ifTrue: [self errorTrueFunctionTakesNoArguments].
	self emitAll: '(true)'.
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> emitNumberConversion [
	self emitAll: ' asXPathNumber'
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> emitNumberLiteral: anIntegerOrFloatString [
	self
		emit: $(;
		emitAll: anIntegerOrFloatString;
		emit: $)
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> emitPredicateSeparator [
	self emit: $.
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> emitQuotedString: aString [
	self emit: $'.
	"escape ' by outputting another ' before it"
	1 to: aString size do: [:i | | nextChar |
		(nextChar := aString at: i) == $'
			ifTrue: [self emit: $'].
		self emit: nextChar].
	self emit: $'.
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> emitSpace [
	self emit: Character space
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> emitStartContextBlock [
	self
		pushVariables;
		emitAll: '[:';
		emitAll: self contextNodeVariable;
		emitAll: ' :';
		emitAll: self contextVariable;
		emitAll: '| |';
		emitAll: self contextPositionVariable;
		emitAll: ' ';
		emitAll: self contextSizeVariable;
		emit: $|
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> emitStartGroupingsForLocationPath: aLocationPath [
	aLocationPath hasSteps
		ifTrue: [
			1 to: aLocationPath steps size do: [:i |
				self emit: $(]]
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> emitStartPredicateBlock [
	self
		pushVariables;
		emitAll: '[:';
		emitAll: self contextNodeVariable;
		emitAll: ' :';
		emitAll: self contextPositionVariable;
		emitAll: ' :';
		emitAll: self contextSizeVariable;
		emit: $|
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> emitUnionableConversion [
	self emitAll: ' asXPathUnionable'
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> errorFalseFunctionTakesNoArguments [
	self errorFunctionTakesNoArguments: 'false'
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> errorFunctionTakesNoArguments: aFunctionName [
	XPathArgumentNumberException
		formatSignal: 'The {1}() function takes no arguments'
		with: aFunctionName
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> errorLastFunctionTakesNoArguments [
	self errorFunctionTakesNoArguments: 'last'
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> errorPositionFunctionTakesNoArguments [
	self errorFunctionTakesNoArguments: 'position'
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> errorTrueFunctionTakesNoArguments [
	self errorFunctionTakesNoArguments: 'true'
]

{ #category : #initialization }
XPathASTTranslatingNodeVisitor >> initialize [
	super initialize.

	"must use #writeStream instead of 'WriteStream on:' to get a 0-based
	stream on Gemstone"
	outputStream := (String new: 128) writeStream.
	variableStack := OrderedCollection new.
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> outputStream [
	^ outputStream
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> popVariables [
	^ variableStack removeLast
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> pushVariables [
	| indexString |

	indexString := (variableStack size + 1) printString.
	^ variableStack addLast:
		(Array
			with: (indexString copyWithFirst: $n) "node variable"
			with: (indexString copyWithFirst: $p) "position variable"
			with: (indexString copyWithFirst: $s)). "size variable"
]

{ #category : #private }
XPathASTTranslatingNodeVisitor >> topVariables [
	^ variableStack last
]

{ #category : #'visiting - location paths' }
XPathASTTranslatingNodeVisitor >> visitAbsoluteLocationPath: anAbsoluteLocationPath [
	self
		emit: $(;
		emitStartGroupingsForLocationPath: anAbsoluteLocationPath;
		emitAll: self contextNodeVariable;
		emitAll: ' documentRoot'.
	super visitAbsoluteLocationPath: anAbsoluteLocationPath.
	self emit: $).
	^ anAbsoluteLocationPath.
]

{ #category : #'visiting - operators' }
XPathASTTranslatingNodeVisitor >> visitAdditionExpression: anAdditionExpression [
	^ self
		emitBinaryArithmeticExpression: anAdditionExpression
		withOperator: '+'
]

{ #category : #'visiting - steps' }
XPathASTTranslatingNodeVisitor >> visitAncestorOrSelfStep: anAncestorOrSelfStep [
	self emitAll: ' ancestorOrSelfAxis:'.
	^ super visitAncestorOrSelfStep: anAncestorOrSelfStep.
]

{ #category : #'visiting - steps' }
XPathASTTranslatingNodeVisitor >> visitAncestorStep: anAncestorStep [
	self emitAll: ' ancestorAxis:'.
	^ super visitAncestorStep: anAncestorStep.
]

{ #category : #'visiting - operators' }
XPathASTTranslatingNodeVisitor >> visitAndExpression: anAndExpression [
	^ self
		emitBinaryShortCircuitExpression: anAndExpression
		withOperator: 'and:'
]

{ #category : #'visiting - node tests' }
XPathASTTranslatingNodeVisitor >> visitAnyNodeTest: anAnyNodeTest [
	self emitAll: '[:n|true]'.
	^ super visitAnyNodeTest: anAnyNodeTest.
]

{ #category : #'visiting - functions' }
XPathASTTranslatingNodeVisitor >> visitArgument: anArgument [
	super visitArgument: anArgument.
	self emit: $..
	^ anArgument.
]

{ #category : #'visiting - steps' }
XPathASTTranslatingNodeVisitor >> visitAttributeStep: anAttributeStep [
	anAttributeStep isOnlyRelativeLocationPathStepAndHasNoPredicates
		ifTrue: [
			anAttributeStep isPredicateLocationPathStep
				ifTrue: [
					self
						emitAll: ' isElement and:[';
						emitAll: self contextNodeVariable;
						emitAll: ' hasAttributes and:[';
						emitAll: self contextNodeVariable.
					anAttributeStep nodeTest isAttributeTestForName
						ifTrue: [
							"can use a direct lookup here"
							self
								emitAll: ' includesAttribute:';
								emitQuotedString: anAttributeStep nodeTest name]
						ifFalse: [
							self emitAll: ' attributeNodes anySatisfy:'.
							anAttributeStep nodeTest acceptNodeVisitor: self].
					self emitAll: ']])'.
					^ anAttributeStep].
			anAttributeStep isUnaryOrLiteralBinaryOperatorLocationPathStep
				ifTrue: [
					self
						emitAll: ' isElement ifTrue:[';
						emitAll: self contextNodeVariable;
						emitAll: ' hasAttributes ifTrue:[(';
						emitAll: self contextNodeVariable.
					anAttributeStep nodeTest isAttributeTestForName
						ifTrue: [
							"can use a direct lookup here"
							self
								emitAll: ' attributeAt:';
								emitQuotedString: anAttributeStep nodeTest name;
								emit: $)]
						ifFalse: [
							self emitAll: ' attributeNodes detect:'.
							anAttributeStep nodeTest acceptNodeVisitor: self.
							self emitAll: ')ifNil:['''']ifNotNil:[:n|n stringValue]'].
					self emitAll: ']ifFalse:['''']]ifFalse:[''''])'.
					^ anAttributeStep]].

	self emitAll: ' attributeAxis:'.
	^ super visitAttributeStep: anAttributeStep.
]

{ #category : #'visiting - node tests' }
XPathASTTranslatingNodeVisitor >> visitAttributeTest: anAttributeTest [
	self emitAll: '[:n|n isAttribute]'.
	^ super visitAttributeTest: anAttributeTest.
]

{ #category : #'visiting - node tests' }
XPathASTTranslatingNodeVisitor >> visitAttributeTestForLocalName: anAttributeTestForLocalName [
	self
		emitAll: '[:n|n isAttribute and:[n localName=''';
		emitAll: anAttributeTestForLocalName localName;
		emitAll: ''']]'.
	^ super visitAttributeTestForLocalName: anAttributeTestForLocalName.
]

{ #category : #'visiting - node tests' }
XPathASTTranslatingNodeVisitor >> visitAttributeTestForName: anAttributeTestForName [
	self
		emitAll: '[:n|n isAttribute and:[n name=''';
		emitAll: anAttributeTestForName name;
		emitAll: ''']]'.
	^ super visitAttributeTestForName: anAttributeTestForName.
]

{ #category : #'visiting - node tests' }
XPathASTTranslatingNodeVisitor >> visitAttributeTestForNamespaceURI: anAttributeTestForNamespaceURI [
	self
		emitAll: '[:n|n isAttribute and:[n namespaceURI=''';
		emitAll: anAttributeTestForNamespaceURI namespaceURI;
		emitAll: ''']]'.
	^ super visitAttributeTestForNamespaceURI: anAttributeTestForNamespaceURI.
]

{ #category : #'visiting - node tests' }
XPathASTTranslatingNodeVisitor >> visitAttributeTestForNamespaceURIAndLocalName: anAttributeTestForNamespaceURIAndLocalName [
	self
		emitAll: '[:n|n isAttribute and:[n localName=''';
		emitAll: anAttributeTestForNamespaceURIAndLocalName localName;
		emitAll: '''and:[n namespaceURI=''';
		emitAll: anAttributeTestForNamespaceURIAndLocalName namespaceURI;
		emitAll: ''']]]'.
	^ super visitAttributeTestForNamespaceURIAndLocalName:
		anAttributeTestForNamespaceURIAndLocalName.
]

{ #category : #'visiting - node tests' }
XPathASTTranslatingNodeVisitor >> visitAttributeTestForPrefix: anAttributeTestForPrefix [
	self
		emit: $(;
		emitAll: self contextVariable;
		emitAll: ' attributeTestForPrefix:''';
		emitAll: anAttributeTestForPrefix prefix;
		emitAll: ''')'.
	^ super visitAttributeTestForPrefix: anAttributeTestForPrefix.
]

{ #category : #'visiting - node tests' }
XPathASTTranslatingNodeVisitor >> visitAttributeTestForPrefixAndLocalName: anAttributeTestForPrefixAndLocalName [
	self
		emit: $(;
		emitAll: self contextVariable;
		emitAll: ' attributeTestForPrefix:''';
		emitAll: anAttributeTestForPrefixAndLocalName prefix;
		emitAll: '''localName:''';
		emitAll: anAttributeTestForPrefixAndLocalName localName;
		emitAll: ''')'.
	^ super visitAttributeTestForPrefixAndLocalName:
		anAttributeTestForPrefixAndLocalName.
]

{ #category : #'visiting - steps' }
XPathASTTranslatingNodeVisitor >> visitChildStep: aChildStep [
	aChildStep isOnlyRelativeLocationPathStepAndHasNoPredicates
		ifTrue: [
			aChildStep isPredicateLocationPathStep
				ifTrue: [
					self
						emitAll: ' hasChildren and:[';
						emitAll: self contextNodeVariable;
						emitAll: ' nodes anySatisfy:'.
					aChildStep nodeTest acceptNodeVisitor: self.
					self emitAll: '])'.
					^ aChildStep].
			aChildStep isUnaryOrLiteralBinaryOperatorLocationPathStep
				ifTrue: [
					self
						emitAll: ' hasChildren ifTrue:[(';
						emitAll: self contextNodeVariable;
						emitAll: ' nodes detect:'.
					aChildStep nodeTest acceptNodeVisitor: self.
					self
						emitAll: ')ifNil:['''']ifNotNil:[:n|n stringValue]]';
						emitAll: 'ifFalse:[''''])'.
					^ aChildStep]].

	self emitAll: ' childAxis:'.
	^ super visitChildStep: aChildStep.
]

{ #category : #'visiting - node tests' }
XPathASTTranslatingNodeVisitor >> visitCommentTest: aCommentTest [
	self emitAll: '[:n|n isComment]'.
	^ super visitCommentTest: aCommentTest.
]

{ #category : #'visiting - steps' }
XPathASTTranslatingNodeVisitor >> visitDescendantOrSelfStep: aDescendantOrSelfStep [
	aDescendantOrSelfStep isOnlyRelativeLocationPathStepAndHasNoPredicates
		ifTrue: [
			aDescendantOrSelfStep isPredicateLocationPathStep
				ifTrue: [
					self emitAll: ' allNodesDetect:'.
					aDescendantOrSelfStep nodeTest acceptNodeVisitor: self.
					self emitAll: ') notNil'.
					^ aDescendantOrSelfStep].
			aDescendantOrSelfStep isUnaryOrLiteralBinaryOperatorLocationPathStep
				ifTrue: [
					self emitAll: ' allNodesDetect:'.
					aDescendantOrSelfStep nodeTest acceptNodeVisitor: self.
					self emitAll: ')ifNil:['''']ifNotNil:[:n|n stringValue]'.
					^ aDescendantOrSelfStep]].

	self emitAll: ' descendantOrSelfAxis:'.
	^ super visitDescendantOrSelfStep: aDescendantOrSelfStep.
]

{ #category : #'visiting - steps' }
XPathASTTranslatingNodeVisitor >> visitDescendantStep: aDescendantStep [
	aDescendantStep isOnlyRelativeLocationPathStepAndHasNoPredicates
		ifTrue: [
			aDescendantStep isPredicateLocationPathStep
				ifTrue: [
					self emitAll: ' descendantNodesDetect:'.
					aDescendantStep nodeTest acceptNodeVisitor: self.
					self emitAll: ') notNil'.
					^ aDescendantStep].
			aDescendantStep isUnaryOrLiteralBinaryOperatorLocationPathStep
				ifTrue: [
					self emitAll: ' descendantNodesDetect:'.
					aDescendantStep nodeTest acceptNodeVisitor: self.
					self emitAll: ')ifNil:['''']ifNotNil:[:n|n stringValue]'.
					^ aDescendantStep]].

	self emitAll: ' descendantAxis:'.
	^ super visitDescendantStep: aDescendantStep.
]

{ #category : #'visiting - operators' }
XPathASTTranslatingNodeVisitor >> visitDivisionExpression: aDivisionExpression [
	^ self
		emitBinaryArithmeticExpression: aDivisionExpression
		withOperator: 'xPathDivision:'
]

{ #category : #'visiting - node tests' }
XPathASTTranslatingNodeVisitor >> visitElementTest: anElementTest [
	self emitAll: '[:n|n isElement]'.
	^ super visitElementTest: anElementTest.
]

{ #category : #'visiting - node tests' }
XPathASTTranslatingNodeVisitor >> visitElementTestForLocalName: anElementTestForLocalName [
	self
		emitAll: '[:n|n isElement and:[n localName=''';
		emitAll: anElementTestForLocalName localName;
		emitAll: ''']]'.
	^ super visitElementTestForLocalName: anElementTestForLocalName.
]

{ #category : #'visiting - node tests' }
XPathASTTranslatingNodeVisitor >> visitElementTestForName: anElementTestForName [
	self
		emitAll: '[:n|n isElement and:[n name=''';
		emitAll: anElementTestForName name;
		emitAll: ''']]'.
	^ super visitElementTestForName: anElementTestForName.
]

{ #category : #'visiting - node tests' }
XPathASTTranslatingNodeVisitor >> visitElementTestForNamespaceURI: anElementTestForNamespaceURI [
	self
		emitAll: '[:n|n isElement and:[n namespaceURI=''';
		emitAll: anElementTestForNamespaceURI namespaceURI;
		emitAll: ''']]'.
	^ super visitElementTestForNamespaceURI: anElementTestForNamespaceURI.
]

{ #category : #'visiting - node tests' }
XPathASTTranslatingNodeVisitor >> visitElementTestForNamespaceURIAndLocalName: anElementTestForNamespaceURIAndLocalName [
	self
		emitAll: '[:n|n isElement and:[n localName=''';
		emitAll: anElementTestForNamespaceURIAndLocalName localName;
		emitAll: '''and:[n namespaceURI=''';
		emitAll: anElementTestForNamespaceURIAndLocalName namespaceURI;
		emitAll: ''']]]'.
	^ super visitElementTestForNamespaceURIAndLocalName:
		anElementTestForNamespaceURIAndLocalName.
]

{ #category : #'visiting - node tests' }
XPathASTTranslatingNodeVisitor >> visitElementTestForPrefix: anElementTestForPrefix [
	self
		emit: $(;
		emitAll: self contextVariable;
		emitAll: ' elementTestForPrefix:''';
		emitAll: anElementTestForPrefix prefix;
		emitAll: ''')'.
	^ super visitElementTestForPrefix: anElementTestForPrefix.
]

{ #category : #'visiting - node tests' }
XPathASTTranslatingNodeVisitor >> visitElementTestForPrefixAndLocalName: anElementTestForPrefixAndLocalName [
	self
		emit: $(;
		emitAll: self contextVariable;
		emitAll: ' elementTestForPrefix:''';
		emitAll: anElementTestForPrefixAndLocalName prefix;
		emitAll: '''localName:''';
		emitAll: anElementTestForPrefixAndLocalName localName;
		emitAll: ''')'.
	^ super visitElementTestForPrefixAndLocalName:
		anElementTestForPrefixAndLocalName.
]

{ #category : #'visiting - operators' }
XPathASTTranslatingNodeVisitor >> visitEqualsExpression: anEqualsExpression [
	^ self
		emitBinaryComparisonExpression: anEqualsExpression
		withOperator: '='
]

{ #category : #visiting }
XPathASTTranslatingNodeVisitor >> visitExpressionRoot: anExpressionRoot [
	self emitStartContextBlock.
	super visitExpressionRoot: anExpressionRoot.
	self emitEndBlock.
	^ anExpressionRoot.
]

{ #category : #'visiting - location paths' }
XPathASTTranslatingNodeVisitor >> visitFilterExpression: aFilterExpression [
	self emit: $(.
	super visitFilterExpression: aFilterExpression.
	self emit: $).
	^ aFilterExpression.
]

{ #category : #'visiting - location paths' }
XPathASTTranslatingNodeVisitor >> visitFilterExpressionLocationPath: aFilterExpressionLocationPath [
	self
		emit: $(;
		emitStartGroupingsForLocationPath: aFilterExpressionLocationPath.
	aFilterExpressionLocationPath expression acceptNodeVisitor: self.
	self emitAll: ' asXPathFilterExpressionLocationPathRoot'.
	self
		visitLocationPath: aFilterExpressionLocationPath;
		emit: $).
	^ aFilterExpressionLocationPath.
]

{ #category : #'visiting - location paths' }
XPathASTTranslatingNodeVisitor >> visitFilterable: aFilterable [
	aFilterable hasPredicates
		ifTrue: [
			aFilterable isFilterExpression
				ifTrue: [self emitAll: ' asXPathFilterable filterWithAll: {']
				ifFalse: [self emitAll: ' predicates: {'].
			super visitFilterable: aFilterable.
			self emit: $}]
		ifFalse: [super visitFilterable: aFilterable].
	^ aFilterable.
]

{ #category : #'visiting - steps' }
XPathASTTranslatingNodeVisitor >> visitFollowingSiblingStep: aFollowingSiblingStep [
	self emitAll: ' followingSiblingAxis:'.
	^ super visitFollowingSiblingStep: aFollowingSiblingStep.
]

{ #category : #'visiting - steps' }
XPathASTTranslatingNodeVisitor >> visitFollowingStep: aFollowingStep [
	self emitAll: ' followingAxis:'.
	^ super visitFollowingStep: aFollowingStep.
]

{ #category : #'visiting - functions' }
XPathASTTranslatingNodeVisitor >> visitFunctionCall: aFunctionCall [
	InlinableFunctionNamesAndSelectors
		at: aFunctionCall name
		ifPresent: [:selector |
			self
				perform: selector
				with: aFunctionCall.
			^ aFunctionCall].

	self
		emitAll: '((';
		emitAll: self contextVariable;
		emitAll: ' resolveFunctionReference: ''';
		emitAll: aFunctionCall name;
		emitAll: ''' contextNode: ';
		emitAll: self contextNodeVariable;
		emitAll: ' arguments: {'.
	super visitFunctionCall: aFunctionCall.
	self emitAll: '})invoke)'.
	^ aFunctionCall.
]

{ #category : #'visiting - operators' }
XPathASTTranslatingNodeVisitor >> visitGreaterThanExpression: aGreaterThanExpression [
	^ self
		emitBinaryComparisonExpression: aGreaterThanExpression
		withOperator: '>'
]

{ #category : #'visiting - operators' }
XPathASTTranslatingNodeVisitor >> visitGreaterThanOrEqualToExpression: aGreaterThanOrEqualToExpression [
	^ self
		emitBinaryComparisonExpression: aGreaterThanOrEqualToExpression
		withOperator: '>='
]

{ #category : #'visiting - operators' }
XPathASTTranslatingNodeVisitor >> visitLessThanExpression: aLessThanExpression [
	^ self
		emitBinaryComparisonExpression: aLessThanExpression
		withOperator: '<'
]

{ #category : #'visiting - operators' }
XPathASTTranslatingNodeVisitor >> visitLessThanOrEqualToExpression: aLessThanOrEqualToExpression [
	^ self
		emitBinaryComparisonExpression: aLessThanOrEqualToExpression
		withOperator: '<='
]

{ #category : #'visiting - operators' }
XPathASTTranslatingNodeVisitor >> visitModulusExpression: aModulusExpression [
	^ self
		emitBinaryArithmeticExpression: aModulusExpression
		withOperator: 'xPathModulus:'
]

{ #category : #'visiting - operators' }
XPathASTTranslatingNodeVisitor >> visitMultiplicationExpression: aMultiplicationExpression [
	^ self
		emitBinaryArithmeticExpression: aMultiplicationExpression
		withOperator: '*'
]

{ #category : #'visiting - steps' }
XPathASTTranslatingNodeVisitor >> visitNamespaceStep: aNamespaceStep [
	self emitAll: ' namespaceAxis:'.
	^ super visitNamespaceStep: aNamespaceStep.
]

{ #category : #'visiting - node tests' }
XPathASTTranslatingNodeVisitor >> visitNamespaceTest: aNamespaceTest [
	self emitAll: '[:n|n isNamespace]'.
	^ super visitNamespaceTest: aNamespaceTest.
]

{ #category : #'visiting - node tests' }
XPathASTTranslatingNodeVisitor >> visitNamespaceTestForLocalName: aNamespaceTestForLocalName [
	self
		emitAll: '[:n|n isNamespace and:[n localName=''';
		emitAll: aNamespaceTestForLocalName localName;
		emitAll: ''']]'.
	^ super visitNamespaceTestForLocalName: aNamespaceTestForLocalName.
]

{ #category : #'visiting - node tests' }
XPathASTTranslatingNodeVisitor >> visitNamespaceTestForName: aNamespaceTestForName [
	self
		emitAll: '[:n|n isNamespace and:[n name=''';
		emitAll: aNamespaceTestForName name;
		emitAll: ''']]'.
	^ super visitNamespaceTestForName: aNamespaceTestForName.
]

{ #category : #'visiting - node tests' }
XPathASTTranslatingNodeVisitor >> visitNamespaceTestForNamespaceURI: aNamespaceTestForNamespaceURI [
	self
		emitAll: '[:n|n isNamespace and:[n namespaceURI=''';
		emitAll: aNamespaceTestForNamespaceURI namespaceURI;
		emitAll: ''']]'.
	^ super visitNamespaceTestForNamespaceURI: aNamespaceTestForNamespaceURI.
]

{ #category : #'visiting - node tests' }
XPathASTTranslatingNodeVisitor >> visitNamespaceTestForNamespaceURIAndLocalName: aNamespaceTestForNamespaceURIAndLocalName [
	self
		emitAll: '[:n|n isNamespace and:[n localName=''';
		emitAll: aNamespaceTestForNamespaceURIAndLocalName localName;
		emitAll: '''and:[n namespaceURI=''';
		emitAll: aNamespaceTestForNamespaceURIAndLocalName namespaceURI;
		emitAll: ''']]]'.
	^ super visitNamespaceTestForNamespaceURIAndLocalName:
		aNamespaceTestForNamespaceURIAndLocalName.
]

{ #category : #'visiting - node tests' }
XPathASTTranslatingNodeVisitor >> visitNamespaceTestForPrefix: aNamespaceTestForPrefix [
	self
		emit: $(;
		emitAll: self contextVariable;
		emitAll: ' namespaceTestForPrefix:''';
		emitAll: aNamespaceTestForPrefix prefix;
		emitAll: ''')'.
	^ super visitNamespaceTestForPrefix: aNamespaceTestForPrefix.
]

{ #category : #'visiting - node tests' }
XPathASTTranslatingNodeVisitor >> visitNamespaceTestForPrefixAndLocalName: aNamespaceTestForPrefixAndLocalName [
	self
		emit: $(;
		emitAll: self contextVariable;
		emitAll: ' namespaceTestForPrefix:''';
		emitAll: aNamespaceTestForPrefixAndLocalName prefix;
		emitAll: '''localName:''';
		emitAll: aNamespaceTestForPrefixAndLocalName localName;
		emitAll: ''')'.
	^ super visitNamespaceTestForPrefixAndLocalName:
		aNamespaceTestForPrefixAndLocalName.
]

{ #category : #'visiting - operators' }
XPathASTTranslatingNodeVisitor >> visitNegationExpression: aNegationExpression [
	self emit: $(.
	super visitNegationExpression: aNegationExpression.
	self
		emitNumberConversion;
		emitAll: ' negated)'.
	^ aNegationExpression.
]

{ #category : #'visiting - operators' }
XPathASTTranslatingNodeVisitor >> visitNotEqualsExpression: aNotEqualsExpression [
	^ self
		emitBinaryComparisonExpression: aNotEqualsExpression
		withOperator: '~='
]

{ #category : #'visiting - literals' }
XPathASTTranslatingNodeVisitor >> visitNumberLiteral: aNumberLiteral [
	| number |

	"do not use asXPathString here; we do not want the XPath string
	representation of the number, but its Smalltalk representation,
	so NaN is rendered as something like 'Float nan' on Pharo
	and not 'NaN'"
	(number := aNumberLiteral number) isNaN
		ifTrue: [self emitNumberLiteral: 'Float nan']
		ifFalse: [
			number isInfinite
				ifTrue: [
					number negative
						ifTrue: [self emitNumberLiteral: 'Float infinity negated']
						ifFalse: [self emitNumberLiteral: 'Float infinity']]
				ifFalse: [
					number isZero
						ifTrue: [
							number isXPathNegativeZero
								ifTrue: [self emitNumberLiteral: '-0.0']
								ifFalse: [self emitNumberLiteral: '0.0']]
						ifFalse: [self emitNumberLiteral: number asString]]].
	^ aNumberLiteral.
]

{ #category : #'visiting - operators' }
XPathASTTranslatingNodeVisitor >> visitOrExpression: anOrExpression [
	^ self
		emitBinaryShortCircuitExpression: anOrExpression
		withOperator: 'or:'
]

{ #category : #'visiting - node tests' }
XPathASTTranslatingNodeVisitor >> visitPITest: aPITest [
	self emitAll: '[:n|n isPI]'.
	^ super visitPITest: aPITest.
]

{ #category : #'visiting - node tests' }
XPathASTTranslatingNodeVisitor >> visitPITestForName: aPITestForName [
	self
		emitAll: '[:n|n isPI and:[n target=''';
		emitAll: aPITestForName name;
		emitAll: ''']]'.
	^ super visitPITestForName: aPITestForName.
]

{ #category : #'visiting - steps' }
XPathASTTranslatingNodeVisitor >> visitParentStep: aParentStep [
	aParentStep isOnlyRelativeLocationPathStepAndHasNoPredicates
		ifTrue: [
			aParentStep isPredicateLocationPathStep
				ifTrue: [
					self emitAll: ' hasParent and:['.
					aParentStep nodeTest acceptNodeVisitor: self.
					self
						emitAll: ' value:';
						emitAll: self contextNodeVariable.
					self emitAll: '])'.
					^ aParentStep].
			aParentStep isUnaryOrLiteralBinaryOperatorLocationPathStep
				ifTrue: [
					self emitAll: ' hasParent ifTrue:[('.
					aParentStep nodeTest acceptNodeVisitor: self.
					self
						emitAll: 'value:';
						emitAll: self contextNodeVariable;
						emitAll: ')ifTrue:[';
						emitAll: self contextNodeVariable;
						emitAll: ' stringValue]ifFalse:['''']]ifFalse:[''''])'.
					^ aParentStep]].

	self emitAll: ' parentAxis:'.
	^ super visitParentStep: aParentStep.
]

{ #category : #'visiting - steps' }
XPathASTTranslatingNodeVisitor >> visitPrecedingSiblingStep: aPrecedingSiblingStep [
	self emitAll: ' precedingSiblingAxis:'.
	^ super visitPrecedingSiblingStep: aPrecedingSiblingStep.
]

{ #category : #'visiting - steps' }
XPathASTTranslatingNodeVisitor >> visitPrecedingStep: aPrecedingStep [
	self emitAll: ' precedingAxis:'.
	^ super visitPrecedingStep: aPrecedingStep.
]

{ #category : #'visiting - predicates' }
XPathASTTranslatingNodeVisitor >> visitPredicate: aPredicate [
	"number predicates like [1] can be inlined without outputting a
	predicate block"
	aPredicate expression isNumberLiteral
		ifTrue: [super visitPredicate: aPredicate]
		ifFalse: [
			self emitStartPredicateBlock.
			super visitPredicate: aPredicate.
			self emitEndBlock].
	self emitPredicateSeparator.
	^ aPredicate.
]

{ #category : #'visiting - location paths' }
XPathASTTranslatingNodeVisitor >> visitRelativeLocationPath: aRelativeLocationPath [
	self
		emit: $(;
		emitStartGroupingsForLocationPath: aRelativeLocationPath;
		emitAll: self contextNodeVariable.
	super visitRelativeLocationPath: aRelativeLocationPath.
	self emit: $).
	^ aRelativeLocationPath.
]

{ #category : #'visiting - steps' }
XPathASTTranslatingNodeVisitor >> visitSelfStep: aSelfStep [
	aSelfStep isOnlyRelativeLocationPathStepAndHasNoPredicates
		ifTrue: [
			aSelfStep isPredicateLocationPathStep
				ifTrue: [
					self emitAll: ' matches:'.
					aSelfStep nodeTest acceptNodeVisitor: self.
					self emit: $).
					^ aSelfStep].
			aSelfStep isUnaryOrLiteralBinaryOperatorLocationPathStep
				ifTrue: [
					self emitAll: ' matches:'.
					aSelfStep nodeTest acceptNodeVisitor: self.
					self
						emitAll: ')ifTrue:[';
						emitAll: self contextNodeVariable;
						emitAll: ' stringValue]ifFalse:['''']'.
					^ aSelfStep]].

	self emitAll: ' selfAxis:'.
	^ super visitSelfStep: aSelfStep.
]

{ #category : #'visiting - steps' }
XPathASTTranslatingNodeVisitor >> visitStep: aStep [
	super visitStep: aStep.
	self emit: $).
	^ aStep.
]

{ #category : #'visiting - literals' }
XPathASTTranslatingNodeVisitor >> visitStringLiteral: aStringLiteral [
	self emitQuotedString: aStringLiteral string.
	^ aStringLiteral.
]

{ #category : #'visiting - operators' }
XPathASTTranslatingNodeVisitor >> visitSubtractionExpression: aSubtractionExpression [
	^ self
		emitBinaryArithmeticExpression: aSubtractionExpression
		withOperator: '-'
]

{ #category : #'visiting - node tests' }
XPathASTTranslatingNodeVisitor >> visitTextTest: aTestText [
	self emitAll: '[:n|n isStringNode]'.
	^ super visitTextTest: aTestText.
]

{ #category : #'visiting - operators' }
XPathASTTranslatingNodeVisitor >> visitUnionExpression: aUnionExpression [
	self emit: $(.
	aUnionExpression expression acceptNodeVisitor: self.
	self
		emitUnionableConversion;
		emit: $|.
	aUnionExpression otherExpression acceptNodeVisitor: self.
	self
		emitUnionableConversion;
		emit: $).
	^ aUnionExpression.
]

{ #category : #'visiting - variables' }
XPathASTTranslatingNodeVisitor >> visitVariableReference: aVariableReference [
	self
		emit: $(;
		emitAll: self contextVariable;
		emitAll: ' resolveVariableReference: ''';
		emitAll: aVariableReference name;
		emitAll: ''')'.
	^ aVariableReference.
]
