"
A handler for XPath expression parsers that generates Smalltalk source implementing the XPath expression.
"
Class {
	#name : #XPathExpressionParserHandler,
	#superclass : #XPathParserHandler,
	#instVars : [
		'outputStream',
		'variableIndex',
		'contextNodeVariable',
		'contextPositionVariable',
		'contextSizeVariable'
	],
	#classVars : [
		'AxisSpecifierNamesAndSelectors'
	],
	#category : #'XPath-Core-Parsers'
}

{ #category : #private }
XPathExpressionParserHandler class >> axisSpecifierNameAndSelectorPairs [
	^ #(
		'ancestor' '%%'
		'ancestor-or-self' '%%~'
		'attribute' '@'
		'child' '/'
		'descendant' '//'
		'descendant-or-self' '//~'
		'following' '>>'
		'following-sibling' '>>>'
		'namespace' '@@'
		'parent' '%'
		'preceding' '<<'
		'preceding-sibling' '<<<'
		'self' '~'
		'%%' '%%'
		'%%~' '%%~'
		'@' '@'
		'>>' '>>'
		'>>>' '>>>'
		'@@' '@@'
		'%' '%'
		'<<' '<<'
		'<<<' '<<<'
		'~' '~'
		)
]

{ #category : #'class initialization' }
XPathExpressionParserHandler class >> initialize [
	"self initialize"

	self initializeAxisSpecifierNamesAndSelectors
]

{ #category : #'class initialization' }
XPathExpressionParserHandler class >> initializeAxisSpecifierNamesAndSelectors [
	AxisSpecifierNamesAndSelectors := Dictionary new.
	self axisSpecifierNameAndSelectorPairs
		pairsDo: [:axisSpecifier :selector |
			AxisSpecifierNamesAndSelectors
				at: axisSpecifier asString
				put: selector asString].
]

{ #category : #private }
XPathExpressionParserHandler >> decrementVariableNames [
	variableIndex := variableIndex - 1.
	self generateVariableNames.
]

{ #category : #private }
XPathExpressionParserHandler >> emitBooleanConversion [
	outputStream nextPutAll: ' asXPathBoolean'
]

{ #category : #private }
XPathExpressionParserHandler >> emitEndAttributePredicate [
	outputStream nextPutAll: ']]'.
	self emitEndPredicateBlock.
]

{ #category : #private }
XPathExpressionParserHandler >> emitEndBlock [
	outputStream nextPut: $]
]

{ #category : #private }
XPathExpressionParserHandler >> emitEndGrouping [
	outputStream nextPut: $)
]

{ #category : #private }
XPathExpressionParserHandler >> emitEndPredicateBlock [
	self decrementVariableNames.
	outputStream nextPut: $].
]

{ #category : #private }
XPathExpressionParserHandler >> emitQuotedString: aString [
	outputStream nextPut: $'.
	"escape ' by outputting another ' before it"
	1 to: aString size do: [:i | | nextChar |
		(nextChar := aString at: i) == $'
			ifTrue: [outputStream nextPut: $'].
		outputStream nextPut: nextChar].
	outputStream nextPut: $'.
]

{ #category : #private }
XPathExpressionParserHandler >> emitStartAttributePredicate: aName [
	self emitStartPredicateBlock.
	outputStream
		nextPutAll: contextNodeVariable;
		nextPutAll: ' isElement and:[';
		nextPutAll: contextNodeVariable;
		nextPutAll: ' hasAttributes and:[(';
		nextPutAll: contextNodeVariable;
		nextPutAll: ' attributeAt:'.
	self emitQuotedString: aName.
	outputStream nextPut: $).
]

{ #category : #private }
XPathExpressionParserHandler >> emitStartContextBlock [
	outputStream
		nextPutAll: '[:';
		nextPutAll: contextNodeVariable;
		nextPutAll: ' :c| |';
		nextPutAll: contextPositionVariable;
		space;
		nextPutAll: contextSizeVariable;
		nextPut: $|
]

{ #category : #private }
XPathExpressionParserHandler >> emitStartGrouping [
	outputStream nextPut: $(
]

{ #category : #private }
XPathExpressionParserHandler >> emitStartPredicateBlock [
	self incrementVariableNames.
	outputStream
		nextPutAll: '??[:';
		nextPutAll: contextNodeVariable;
		nextPutAll: ' :';
		nextPutAll: contextPositionVariable;
		nextPutAll: ' :';
		nextPutAll: contextSizeVariable;
		nextPut: $|.
]

{ #category : #private }
XPathExpressionParserHandler >> errorUnrecognizedAxisSpecifier: anAxisSpecifier [
	XPathSyntaxException
		formatSignal: 'Unrecognized axis specifier "{1}"'
		with: anAxisSpecifier
]

{ #category : #private }
XPathExpressionParserHandler >> generateVariableNames [
	| indexString |

	indexString := variableIndex printString.
	contextNodeVariable := indexString copyWithFirst: $n.
	contextPositionVariable := indexString copyWithFirst: $p.
	contextSizeVariable := indexString copyWithFirst: $s.
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleAddition [
	outputStream nextPutAll: '//+'
]

{ #category : #'handling - location paths' }
XPathExpressionParserHandler >> handleAxisSpecifier: anAxisSpecifier [
	outputStream nextPutAll:
		(AxisSpecifierNamesAndSelectors
			at: anAxisSpecifier
			ifAbsent: [self errorUnrecognizedAxisSpecifier: anAxisSpecifier])
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleDivision [
	outputStream nextPutAll: '///'
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleEndAdditiveExpression [
	self emitEndGrouping
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleEndAndExpression [
	self emitEndGrouping
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleEndEqualityExpression [
	self emitEndGrouping
]

{ #category : #'handling - functions' }
XPathExpressionParserHandler >> handleEndFunctionArgument [
	outputStream nextPutAll: ');'
]

{ #category : #'handling - functions' }
XPathExpressionParserHandler >> handleEndFunctionCall [
	outputStream nextPutAll: 'invoke)'
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleEndMultiplicativeExpression [
	self emitEndGrouping
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleEndOrExpression [
	self emitEndGrouping
]

{ #category : #handling }
XPathExpressionParserHandler >> handleEndParsing [
	self
		emitEndBlock;
		parsingResult: outputStream contents
]

{ #category : #'handling - location paths' }
XPathExpressionParserHandler >> handleEndPathExpression [
	self emitEndGrouping
]

{ #category : #'handling - predicates' }
XPathExpressionParserHandler >> handleEndPredicate [
	self emitEndPredicateBlock
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleEndRelationalExpression [
	self emitEndGrouping
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleEndShortCircuitAnd [
	self
		emitBooleanConversion;
		emitEndBlock
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleEndShortCircuitOr [
	self
		emitBooleanConversion;
		emitEndBlock
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleEndShortCircuited: anInteger [
	anInteger > 0
		ifTrue: [
			self emitBooleanConversion.
			anInteger timesRepeat: [self emitEndBlock]]
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleEndUnaryExpression [
	self emitEndGrouping
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleEndUnionExpression [
	self emitEndGrouping
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleEquals [
	outputStream nextPutAll: '//='
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleGreaterThan [
	outputStream nextPutAll: '//>'
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleGreaterThanOrEqualTo [
	outputStream nextPutAll: '//>='
]

{ #category : #'handling - predicates' }
XPathExpressionParserHandler >> handleIntegerPredicate: anIntegerString [
	outputStream
		nextPutAll: '??';
		nextPutAll: anIntegerString
]

{ #category : #'handling - functions' }
XPathExpressionParserHandler >> handleLastFunctionCall [
	outputStream
		nextPut: $(;
		nextPutAll: contextSizeVariable;
		nextPutAll: ' ifNil:[1])'
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleLessThan [
	outputStream nextPutAll: '//<'
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleLessThanOrEqualTo [
	outputStream nextPutAll: '//<='
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleModulus [
	outputStream nextPutAll: '//\\'
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleMultiplication [
	outputStream nextPutAll: '//*'
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleNegation [
	outputStream nextPutAll: '-1//*'
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleNotEquals [
	outputStream nextPutAll: '//!='
]

{ #category : #handling }
XPathExpressionParserHandler >> handleNumberLiteral: anIntegerOrFloatString [
	outputStream
		space;
		nextPutAll: anIntegerOrFloatString
]

{ #category : #'handling - functions' }
XPathExpressionParserHandler >> handlePositionFunctionCall [
	outputStream
		nextPut: $(;
		nextPutAll: contextPositionVariable;
		nextPutAll: ' ifNil:[1])'
]

{ #category : #'handling - predicates' }
XPathExpressionParserHandler >> handlePredicateAttribute: aName equalsStringLiteral: aStringLiteral [
	self emitStartAttributePredicate: aName.
	outputStream nextPut: $=.
	self
		emitQuotedString: aStringLiteral;
		emitEndAttributePredicate.
]

{ #category : #'handling - predicates' }
XPathExpressionParserHandler >> handlePredicateAttribute: aName notEqualsStringLiteral: aStringLiteral [
	self emitStartAttributePredicate: aName.
	outputStream nextPutAll: '~='.
	self
		emitQuotedString: aStringLiteral;
		emitEndAttributePredicate.
]

{ #category : #'handling - location paths' }
XPathExpressionParserHandler >> handleStartAbsoluteLocationPath [
	outputStream
		nextPutAll: contextNodeVariable;
		nextPutAll: ' documentRoot'
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleStartAdditiveExpression [
	self emitStartGrouping
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleStartAndExpression [
	self emitStartGrouping
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleStartEqualityExpression [
	self emitStartGrouping
]

{ #category : #'handling - functions' }
XPathExpressionParserHandler >> handleStartFunctionArgument [
	outputStream nextPutAll: 'push: ('
]

{ #category : #'handling - functions' }
XPathExpressionParserHandler >> handleStartFunctionCall: aFunctionName [
	outputStream
		nextPutAll: '((c function: ''';
		nextPutAll: aFunctionName;
		nextPutAll: ''' contextNode: ';
		nextPutAll: contextNodeVariable;
		nextPut: $)
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleStartMultiplicativeExpression [
	self emitStartGrouping
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleStartOrExpression [
	self emitStartGrouping
]

{ #category : #handling }
XPathExpressionParserHandler >> handleStartParsing [
	outputStream := (String new: 128) writeStream.
	variableIndex := 1.
	self
		generateVariableNames;
		emitStartContextBlock.
]

{ #category : #'handling - location paths' }
XPathExpressionParserHandler >> handleStartPathExpression [
	self emitStartGrouping
]

{ #category : #'handling - predicates' }
XPathExpressionParserHandler >> handleStartPredicate [
	self emitStartPredicateBlock
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleStartRelationalExpression [
	self emitStartGrouping
]

{ #category : #'handling - location paths' }
XPathExpressionParserHandler >> handleStartRelativeLocationPath [
	outputStream nextPutAll: contextNodeVariable
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleStartShortCircuitAnd [
	self emitBooleanConversion.
	outputStream nextPutAll: ' and:['.
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleStartShortCircuitOr [
	self emitBooleanConversion.
	outputStream nextPutAll: ' or:['.
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleStartUnaryExpression [
	self emitStartGrouping
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleStartUnionExpression [
	self emitStartGrouping
]

{ #category : #handling }
XPathExpressionParserHandler >> handleStringLiteral: aString [
	self emitQuotedString: aString
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleSubtraction [
	outputStream nextPutAll: '//-'
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForAnyName [
	outputStream nextPutAll: '[:n|n isPrincipalNode]'
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForAnyNodeType [
	outputStream nextPutAll: '[:n|true]'
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForAttributeWithAnyName [
	outputStream nextPutAll: '[:n|n isAttribute]'
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForAttributeWithLocalName: aLocalName [
	outputStream
		nextPutAll: '[:n|n isAttribute and:[n localName=''';
		nextPutAll: aLocalName;
		nextPutAll: ''']]'
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForAttributeWithName: aName [
	outputStream
		nextPutAll: '[:n|n isAttribute and:[n name=''';
		nextPutAll: aName;
		nextPutAll: ''']]'
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForAttributeWithNamespaceURI: aURI localName: aLocalName [
	outputStream
		nextPutAll: '[:n|n isAttribute and:[n localName=''';
		nextPutAll: aLocalName;
		nextPutAll: '''and:[n namespaceURI=''';
		nextPutAll: aURI;
		nextPutAll: ''']]]'
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForAttributeWithPrefix: aPrefix [
	outputStream
		nextPutAll: '(c testForAttributeWithPrefix:''';
		nextPutAll: aPrefix;
		nextPutAll: ''')'
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForAttributeWithPrefix: aPrefix localName: aLocalName [
	outputStream
		nextPutAll: '(c testForAttributeWithPrefix:''';
		nextPutAll: aPrefix;
		nextPutAll: '''localName:''';
		nextPutAll: aLocalName;
		nextPutAll: ''')'
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForCommentType [
	outputStream nextPutAll: '[:n|n isComment]'
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForElementWithAnyName [
	outputStream nextPutAll: '[:n|n isElement]'
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForElementWithLocalName: aLocalName [
	outputStream
		nextPutAll: '[:n|n isElement and:[n localName=''';
		nextPutAll: aLocalName;
		nextPutAll: ''']]'
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForElementWithName: aName [
	outputStream
		nextPutAll: '[:n|n isElement and:[n name=''';
		nextPutAll: aName;
		nextPutAll: ''']]'
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForElementWithNamespaceURI: aURI localName: aLocalName [
	outputStream
		nextPutAll: '[:n|n isElement and:[n localName=''';
		nextPutAll: aLocalName;
		nextPutAll: '''and:[n namespaceURI=''';
		nextPutAll: aURI;
		nextPutAll: ''']]]'
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForElementWithPrefix: aPrefix [
	outputStream
		nextPutAll: '(c testForElementWithPrefix:''';
		nextPutAll: aPrefix;
		nextPutAll: ''')'
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForElementWithPrefix: aPrefix localName: aLocalName [
	outputStream
		nextPutAll: '(c testForElementWithPrefix:''';
		nextPutAll: aPrefix;
		nextPutAll: '''localName:''';
		nextPutAll: aLocalName;
		nextPutAll: ''')'
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForLocalName: aLocalName [
	outputStream
		nextPutAll: '[:n|n isPrincipalNode and:[n localName=''';
		nextPutAll: aLocalName;
		nextPutAll: ''']]'
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForName: aName [
	outputStream
		nextPutAll: '[:n|n isPrincipalNode and:[n name=''';
		nextPutAll: aName;
		nextPutAll: ''']]'
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForNamespaceType [
	outputStream nextPutAll: '[:n|n isNamespace]'
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForNamespaceURI: aURI localName: aLocalName [
	outputStream
		nextPutAll: '[:n|n isPrincipalNode and:[n localName=''';
		nextPutAll: aLocalName;
		nextPutAll: '''and:[n namespaceURI=''';
		nextPutAll: aURI;
		nextPutAll: ''']]]'
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForPIType [
	outputStream nextPutAll: '[:n|n isPI]'
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForPIWithName: aName [
	outputStream
		nextPutAll: '[:n|n isPI and:[n target=''';
		nextPutAll: aName;
		nextPutAll: ''']]'
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForPrefix: aPrefix [
	outputStream
		nextPutAll: '(c testForPrefix:''';
		nextPutAll: aPrefix;
		nextPutAll: ''')'
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForPrefix: aPrefix localName: aLocalName [
	outputStream
		nextPutAll: '(c testForPrefix:''';
		nextPutAll: aPrefix;
		nextPutAll: '''localName:''';
		nextPutAll: aLocalName;
		nextPutAll: ''')'
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForTextType [
	outputStream nextPutAll: '[:n|n isStringNode]'
]

{ #category : #private }
XPathExpressionParserHandler >> handleUnion [
	outputStream nextPut: $|
]

{ #category : #handling }
XPathExpressionParserHandler >> handleVariableReference: aName [
	outputStream
		nextPutAll: '(c variableAt: ''';
		nextPutAll: aName;
		nextPutAll: ''')'
]

{ #category : #private }
XPathExpressionParserHandler >> incrementVariableNames [
	variableIndex := variableIndex + 1.
	self generateVariableNames.
]
