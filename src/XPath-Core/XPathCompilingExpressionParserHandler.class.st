"
A handler class for XPath expression parsers that generates Smalltalk source implementing the XPath expression.
"
Class {
	#name : #XPathCompilingExpressionParserHandler,
	#superclass : #XPathExpressionParserHandler,
	#instVars : [
		'outputStream',
		'variableIndex',
		'contextNodeVariable',
		'contextPositionVariable',
		'contextSizeVariable'
	],
	#category : #'XPath-Core-Parsers'
}

{ #category : #private }
XPathCompilingExpressionParserHandler >> decrementVariableNames [
	variableIndex := variableIndex - 1.
	self generateVariableNames.
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> emitBooleanConversion [
	outputStream nextPutAll: ' asXPathBoolean'
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> emitEndAttributePredicate [
	outputStream nextPutAll: ']]'.
	self emitEndPredicateBlock.
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> emitEndBlock [
	outputStream nextPut: $]
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> emitEndGrouping [
	outputStream nextPut: $)
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> emitEndPredicateBlock [
	self decrementVariableNames.
	outputStream nextPut: $].
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> emitQuotedString: aString [
	outputStream nextPut: $'.
	"escape ' by outputting another ' before it"
	1 to: aString size do: [:i | | nextChar |
		(nextChar := aString at: i) == $'
			ifTrue: [outputStream nextPut: $'].
		outputStream nextPut: nextChar].
	outputStream nextPut: $'.
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> emitStartAttributePredicate: aName [
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
XPathCompilingExpressionParserHandler >> emitStartContextBlock [
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
XPathCompilingExpressionParserHandler >> emitStartGrouping [
	outputStream nextPut: $(
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> emitStartPredicateBlock [
	self incrementVariableNames.
	outputStream
		nextPutAll: '//?[:';
		nextPutAll: contextNodeVariable;
		nextPutAll: ' :';
		nextPutAll: contextPositionVariable;
		nextPutAll: ' :';
		nextPutAll: contextSizeVariable;
		nextPut: $|.
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> generateVariableNames [
	| indexString |

	indexString := variableIndex printString.
	contextNodeVariable := indexString copyWithFirst: $n.
	contextPositionVariable := indexString copyWithFirst: $p.
	contextSizeVariable := indexString copyWithFirst: $s.
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleAddition [
	outputStream nextPutAll: '//+'
]

{ #category : #'handling - location paths' }
XPathCompilingExpressionParserHandler >> handleAxis: anAxis [
	outputStream nextPutAll: anAxis replacementSelector.
	self emitStartGrouping.
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleDivision [
	outputStream nextPutAll: '///'
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleEndAdditiveExpression [
	self emitEndGrouping
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleEndAndExpression [
	self emitEndGrouping
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleEndEqualityExpression [
	self emitEndGrouping
]

{ #category : #'handling - location paths' }
XPathCompilingExpressionParserHandler >> handleEndFilterExpression [
	self emitEndGrouping
]

{ #category : #'handling - functions' }
XPathCompilingExpressionParserHandler >> handleEndFunctionArgument [
	outputStream nextPutAll: ');'
]

{ #category : #'handling - functions' }
XPathCompilingExpressionParserHandler >> handleEndFunctionCall [
	outputStream nextPutAll: 'invoke)'
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleEndMultiplicativeExpression [
	self emitEndGrouping
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleEndOrExpression [
	self emitEndGrouping
]

{ #category : #handling }
XPathCompilingExpressionParserHandler >> handleEndParsing [
	self
		emitEndBlock;
		parsingResult: outputStream contents
]

{ #category : #'handling - location paths' }
XPathCompilingExpressionParserHandler >> handleEndPathExpression [
	self emitEndGrouping
]

{ #category : #'handling - predicates' }
XPathCompilingExpressionParserHandler >> handleEndPredicate [
	self emitEndPredicateBlock
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleEndRelationalExpression [
	self emitEndGrouping
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleEndShortCircuited: anInteger [
	anInteger > 0
		ifTrue: [
			self emitBooleanConversion.
			anInteger timesRepeat: [self emitEndBlock]]
]

{ #category : #'handling - location paths' }
XPathCompilingExpressionParserHandler >> handleEndStep [
	self emitEndGrouping
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleEndUnaryExpression [
	self emitEndGrouping
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleEndUnionExpression [
	self emitEndGrouping
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleEquals [
	outputStream nextPutAll: '//='
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleGreaterThan [
	outputStream nextPutAll: '//>'
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleGreaterThanOrEqualTo [
	outputStream nextPutAll: '//>='
]

{ #category : #'handling - predicates' }
XPathCompilingExpressionParserHandler >> handleIntegerPredicate: anIntegerString [
	outputStream
		nextPutAll: '//?';
		nextPutAll: anIntegerString
]

{ #category : #'handling - functions' }
XPathCompilingExpressionParserHandler >> handleLastFunctionCall [
	outputStream
		nextPut: $(;
		nextPutAll: contextSizeVariable;
		nextPutAll: ' ifNil:[1])'
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleLessThan [
	outputStream nextPutAll: '//<'
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleLessThanOrEqualTo [
	outputStream nextPutAll: '//<='
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleModulus [
	outputStream nextPutAll: '//\\'
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleMultiplication [
	outputStream nextPutAll: '//*'
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleNegation [
	outputStream nextPutAll: '-1//*'
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleNotEquals [
	outputStream nextPutAll: '//!='
]

{ #category : #handling }
XPathCompilingExpressionParserHandler >> handleNumberLiteral: anIntegerOrFloatString [
	outputStream
		space;
		nextPutAll: anIntegerOrFloatString
]

{ #category : #'handling - functions' }
XPathCompilingExpressionParserHandler >> handlePositionFunctionCall [
	outputStream
		nextPut: $(;
		nextPutAll: contextPositionVariable;
		nextPutAll: ' ifNil:[1])'
]

{ #category : #'handling - predicates' }
XPathCompilingExpressionParserHandler >> handlePredicateAttribute: aName equalsStringLiteral: aStringLiteral [
	self emitStartAttributePredicate: aName.
	outputStream nextPut: $=.
	self
		emitQuotedString: aStringLiteral;
		emitEndAttributePredicate.
]

{ #category : #'handling - predicates' }
XPathCompilingExpressionParserHandler >> handlePredicateAttribute: aName notEqualsStringLiteral: aStringLiteral [
	self emitStartAttributePredicate: aName.
	outputStream nextPutAll: '~='.
	self
		emitQuotedString: aStringLiteral;
		emitEndAttributePredicate.
]

{ #category : #'handling - location paths' }
XPathCompilingExpressionParserHandler >> handleStartAbsoluteLocationPath [
	outputStream
		nextPutAll: contextNodeVariable;
		nextPutAll: ' asXPathLocationPathRoot documentRoot'
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleStartAdditiveExpression [
	self emitStartGrouping
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleStartAndExpression [
	self emitStartGrouping
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleStartEqualityExpression [
	self emitStartGrouping
]

{ #category : #'handling - location paths' }
XPathCompilingExpressionParserHandler >> handleStartFilterExpression [
	self emitStartGrouping
]

{ #category : #'handling - location paths' }
XPathCompilingExpressionParserHandler >> handleStartFilterExpressionLocationPath [
	outputStream nextPutAll: ' asXPathLocationPathRoot'
]

{ #category : #'handling - functions' }
XPathCompilingExpressionParserHandler >> handleStartFunctionArgument [
	outputStream nextPutAll: 'push: ('
]

{ #category : #'handling - functions' }
XPathCompilingExpressionParserHandler >> handleStartFunctionCall: aFunctionName [
	outputStream
		nextPutAll: '((c function: ''';
		nextPutAll: aFunctionName;
		nextPutAll: ''' contextNode: ';
		nextPutAll: contextNodeVariable;
		nextPut: $)
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleStartMultiplicativeExpression [
	self emitStartGrouping
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleStartOrExpression [
	self emitStartGrouping
]

{ #category : #handling }
XPathCompilingExpressionParserHandler >> handleStartParsing [
	outputStream := (String new: 128) writeStream.
	variableIndex := 1.
	self
		generateVariableNames;
		emitStartContextBlock.
]

{ #category : #'handling - location paths' }
XPathCompilingExpressionParserHandler >> handleStartPathExpression [
	self emitStartGrouping
]

{ #category : #'handling - predicates' }
XPathCompilingExpressionParserHandler >> handleStartPredicate [
	self emitStartPredicateBlock
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleStartRelationalExpression [
	self emitStartGrouping
]

{ #category : #'handling - location paths' }
XPathCompilingExpressionParserHandler >> handleStartRelativeLocationPath [
	outputStream
		nextPutAll: contextNodeVariable;
		nextPutAll: ' asXPathLocationPathRoot'
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleStartShortCircuitAnd [
	self emitBooleanConversion.
	outputStream nextPutAll: ' and:['.
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleStartShortCircuitOr [
	self emitBooleanConversion.
	outputStream nextPutAll: ' or:['.
]

{ #category : #'handling - location paths' }
XPathCompilingExpressionParserHandler >> handleStartStep [
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleStartUnaryExpression [
	self emitStartGrouping
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleStartUnionExpression [
	self emitStartGrouping
]

{ #category : #handling }
XPathCompilingExpressionParserHandler >> handleStringLiteral: aString [
	self emitQuotedString: aString
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleSubtraction [
	outputStream nextPutAll: '//-'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForAnyNodeType [
	outputStream nextPutAll: '[:n|true]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForAttributeWithAnyName [
	outputStream nextPutAll: '[:n|n isAttribute]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForAttributeWithLocalName: aLocalName [
	outputStream
		nextPutAll: '[:n|n isAttribute and:[n localName=''';
		nextPutAll: aLocalName;
		nextPutAll: ''']]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForAttributeWithName: aName [
	outputStream
		nextPutAll: '[:n|n isAttribute and:[n name=''';
		nextPutAll: aName;
		nextPutAll: ''']]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForAttributeWithNamespaceURI: aURI [
	outputStream
		nextPutAll: '[:n|n isAttribute and:[n namespaceURI=''';
		nextPutAll: aURI;
		nextPutAll: ''']]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForAttributeWithNamespaceURI: aURI localName: aLocalName [
	outputStream
		nextPutAll: '[:n|n isAttribute and:[n localName=''';
		nextPutAll: aLocalName;
		nextPutAll: '''and:[n namespaceURI=''';
		nextPutAll: aURI;
		nextPutAll: ''']]]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForAttributeWithPrefix: aPrefix [
	outputStream
		nextPutAll: '(c testForAttributeWithPrefix:''';
		nextPutAll: aPrefix;
		nextPutAll: ''')'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForAttributeWithPrefix: aPrefix localName: aLocalName [
	outputStream
		nextPutAll: '(c testForAttributeWithPrefix:''';
		nextPutAll: aPrefix;
		nextPutAll: '''localName:''';
		nextPutAll: aLocalName;
		nextPutAll: ''')'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForCommentType [
	outputStream nextPutAll: '[:n|n isComment]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForElementWithAnyName [
	outputStream nextPutAll: '[:n|n isElement]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForElementWithLocalName: aLocalName [
	outputStream
		nextPutAll: '[:n|n isElement and:[n localName=''';
		nextPutAll: aLocalName;
		nextPutAll: ''']]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForElementWithName: aName [
	outputStream
		nextPutAll: '[:n|n isElement and:[n name=''';
		nextPutAll: aName;
		nextPutAll: ''']]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForElementWithNamespaceURI: aURI [
	outputStream
		nextPutAll: '[:n|n isElement and:[n namespaceURI=''';
		nextPutAll: aURI;
		nextPutAll: ''']]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForElementWithNamespaceURI: aURI localName: aLocalName [
	outputStream
		nextPutAll: '[:n|n isElement and:[n localName=''';
		nextPutAll: aLocalName;
		nextPutAll: '''and:[n namespaceURI=''';
		nextPutAll: aURI;
		nextPutAll: ''']]]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForElementWithPrefix: aPrefix [
	outputStream
		nextPutAll: '(c testForElementWithPrefix:''';
		nextPutAll: aPrefix;
		nextPutAll: ''')'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForElementWithPrefix: aPrefix localName: aLocalName [
	outputStream
		nextPutAll: '(c testForElementWithPrefix:''';
		nextPutAll: aPrefix;
		nextPutAll: '''localName:''';
		nextPutAll: aLocalName;
		nextPutAll: ''')'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForNamespaceWithAnyName [
	outputStream nextPutAll: '[:n|n isNamespace]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForNamespaceWithLocalName: aLocalName [
	outputStream
		nextPutAll: '[:n|n isNamespace and:[n localName=''';
		nextPutAll: aLocalName;
		nextPutAll: ''']]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForNamespaceWithName: aName [
	outputStream
		nextPutAll: '[:n|n isNamespace and:[n name=''';
		nextPutAll: aName;
		nextPutAll: ''']]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForNamespaceWithNamespaceURI: aURI [
	outputStream
		nextPutAll: '[:n|n isNamespace and:[n namespaceURI=''';
		nextPutAll: aURI;
		nextPutAll: ''']]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForNamespaceWithNamespaceURI: aURI localName: aLocalName [
	outputStream
		nextPutAll: '[:n|n isNamespace and:[n localName=''';
		nextPutAll: aLocalName;
		nextPutAll: '''and:[n namespaceURI=''';
		nextPutAll: aURI;
		nextPutAll: ''']]]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForNamespaceWithPrefix: aPrefix [
	outputStream
		nextPutAll: '(c testForNamespaceWithPrefix:''';
		nextPutAll: aPrefix;
		nextPutAll: ''')'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForNamespaceWithPrefix: aPrefix localName: aLocalName [
	outputStream
		nextPutAll: '(c testForNamespaceWithPrefix:''';
		nextPutAll: aPrefix;
		nextPutAll: '''localName:''';
		nextPutAll: aLocalName;
		nextPutAll: ''')'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForPIWithAnyName [
	outputStream nextPutAll: '[:n|n isPI]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForPIWithName: aName [
	outputStream
		nextPutAll: '[:n|n isPI and:[n target=''';
		nextPutAll: aName;
		nextPutAll: ''']]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForTextType [
	outputStream nextPutAll: '[:n|n isStringNode]'
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleUnion [
	outputStream nextPutAll: '//\/'
]

{ #category : #handling }
XPathCompilingExpressionParserHandler >> handleVariableReference: aName [
	outputStream
		nextPutAll: '(c variableAt: ''';
		nextPutAll: aName;
		nextPutAll: ''')'
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> incrementVariableNames [
	variableIndex := variableIndex + 1.
	self generateVariableNames.
]
