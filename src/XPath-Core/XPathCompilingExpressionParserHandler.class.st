"
A handler class for XPath expression parsers that generates Smalltalk source implementing the XPath expression.
"
Class {
	#name : #XPathCompilingExpressionParserHandler,
	#superclass : #XPathExpressionParserHandler,
	#instVars : [
		'outputStream',
		'variableStack',
		'operatorStack'
	],
	#category : #'XPath-Core-Compilation'
}

{ #category : #private }
XPathCompilingExpressionParserHandler >> contextNodeVariable [
	^ self currentVariablesAt: 1
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> contextPositionVariable [
	^ self currentVariablesAt: 2
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> contextSizeVariable [
	^ self currentVariablesAt: 3
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> contextVariable [
	^ 'c'
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> currentOperator [
	^ operatorStack xmlLastOrNil
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> currentOperator: anOperator [
	operatorStack
		at: operatorStack size
		put: anOperator.
	anOperator isString
		ifTrue: [self emitAll: anOperator]
		ifFalse: [self emit: anOperator].
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> currentShortCurcuitOperator: anOperator [
	| association |

	"count the number of short curcuited operators"
	association :=
		operatorStack
			at: operatorStack size
			ifAbsentPut: [anOperator -> 0].
	"increment it"
	association value: (association value + 1).
	self
		emitAll: ' ';
		emitAll: association key;
		emitAll: ':['.
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> currentVariablesAt: anIndex [
	^ variableStack last at: anIndex
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> emit: aCharacter [
	outputStream nextPut: aCharacter
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> emitAll: aString [
	outputStream nextPutAll: aString
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> emitBooleanConversion [
	self emitAll: ' asXPathBoolean'
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> emitComparableConversion [
	self emitAll: ' asXPathComparable'
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> emitEndAttributePredicate [
	self
		emitAll: ']]';
		emitEndBlock
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> emitEndBlock [
	self
		emit: $];
		popVariables
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> emitEndShortCurcuitOperators [
	self emitBooleanConversion.
	self currentOperator value timesRepeat: [
		self emit: $]].
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> emitNumberConversion [
	self emitAll: ' asXPathNumber'
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> emitNumberLiteral: anIntegerOrFloatString [
	self
		emit: $(;
		emitAll: anIntegerOrFloatString;
		emit: $)
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> emitPredicateSeparator [
	self emit: $.
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> emitQuotedString: aString [
	self emit: $'.
	"escape ' by outputting another ' before it"
	1 to: aString size do: [:i | | nextChar |
		(nextChar := aString at: i) == $'
			ifTrue: [self emit: $'].
		self emit: nextChar].
	self emit: $'.
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> emitStartAttributePredicate: aName [
	self
		emitStartPredicateBlock;
		emitAll: self contextNodeVariable;
		emitAll: ' isElement and:[';
		emitAll: self contextNodeVariable;
		emitAll: ' hasAttributes and:[(';
		emitAll: self contextNodeVariable;
		emitAll: ' attributeAt:';
		emitQuotedString: aName;
		emit: $)
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> emitStartContextBlock [
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
XPathCompilingExpressionParserHandler >> emitStartPredicateBlock [
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
XPathCompilingExpressionParserHandler >> emitUnionableConversion [
	self emitAll: ' asXPathUnionable'
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleAddition [
	self
		emitNumberConversion;
		currentOperator: $+
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleAnd [
	self
		emitBooleanConversion;
		currentShortCurcuitOperator: 'and'
]

{ #category : #'handling - location paths' }
XPathCompilingExpressionParserHandler >> handleAxis: anAxis [
	self
		emitAll: anAxis replacementSelector;
		emit: $(
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleDivision [
	self
		emitNumberConversion;
		currentOperator: $/
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleEndAdditiveExpression [
	self hasCurrentOperator
		ifTrue: [self emitNumberConversion].
	self
		popOperator;
		emit: $).
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleEndAndExpression [
	self hasCurrentOperator
		ifTrue: [self emitEndShortCurcuitOperators].
	self
		popOperator;
		emit: $).
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleEndEqualityExpression [
	self hasCurrentOperator
		ifTrue: [self emitComparableConversion].
	self
		popOperator;
		emit: $).
]

{ #category : #'handling - location paths' }
XPathCompilingExpressionParserHandler >> handleEndFilterExpression [
	self emit: $)
]

{ #category : #'handling - functions' }
XPathCompilingExpressionParserHandler >> handleEndFunctionArgument [
	self emitAll: ');'
]

{ #category : #'handling - functions' }
XPathCompilingExpressionParserHandler >> handleEndFunctionCall [
	self emitAll: 'invoke)'
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleEndMultiplicativeExpression [
	self hasCurrentOperator
		ifTrue: [self emitNumberConversion].
	self
		popOperator;
		emit: $).
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleEndOrExpression [
	self hasCurrentOperator
		ifTrue: [self emitEndShortCurcuitOperators].
	self
		popOperator;
		emit: $).
]

{ #category : #handling }
XPathCompilingExpressionParserHandler >> handleEndParsing [
	self
		emitEndBlock;
		parsingResult: outputStream contents
]

{ #category : #'handling - location paths' }
XPathCompilingExpressionParserHandler >> handleEndPathExpression [
	self emit: $)
]

{ #category : #'handling - predicates' }
XPathCompilingExpressionParserHandler >> handleEndPredicate [
	self
		emitEndBlock;
		emitPredicateSeparator
]

{ #category : #'handling - predicates' }
XPathCompilingExpressionParserHandler >> handleEndPredicates [
	self emit: $}
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleEndRelationalExpression [
	self hasCurrentOperator
		ifTrue: [self emitComparableConversion].
	self
		popOperator;
		emit: $).
]

{ #category : #'handling - location paths' }
XPathCompilingExpressionParserHandler >> handleEndStep [
	self emit: $)
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleEndUnaryExpression [
	self hasCurrentOperator
		ifTrue: [self emitNumberConversion].
	self
		popOperator;
		emit: $).
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleEndUnionExpression [
	self hasCurrentOperator
		ifTrue: [self emitUnionableConversion].
	self
		popOperator;
		emit: $).
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleEquals [
	self
		emitComparableConversion;
		currentOperator: $=
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleGreaterThan [
	self
		emitComparableConversion;
		currentOperator: $>
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleGreaterThanOrEqualTo [
	self
		emitComparableConversion;
		currentOperator: '>='
]

{ #category : #'handling - predicates' }
XPathCompilingExpressionParserHandler >> handleIntegerPredicate: anIntegerString [
	self
		emitNumberLiteral: anIntegerString;
		emitPredicateSeparator
]

{ #category : #'handling - functions' }
XPathCompilingExpressionParserHandler >> handleLastFunctionCall [
	self
		emit: $(;
		emitAll: self contextSizeVariable;
		emitAll: ' ifNil:[1])'
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleLessThan [
	self
		emitComparableConversion;
		currentOperator: $<
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleLessThanOrEqualTo [
	self
		emitComparableConversion;
		currentOperator: '<='
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleModulus [
	self
		emitNumberConversion;
		currentOperator: '\\'
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleMultiplication [
	self
		emitNumberConversion;
		currentOperator: $*
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleNegation [
	self
		emitNumberLiteral: '-1';
		handleMultiplication
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleNotEquals [
	self
		emitComparableConversion;
		currentOperator: '!='
]

{ #category : #handling }
XPathCompilingExpressionParserHandler >> handleNumberLiteral: anIntegerOrFloatString [
	self emitNumberLiteral: anIntegerOrFloatString
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleOr [
	self
		emitBooleanConversion;
		currentShortCurcuitOperator: 'or'
]

{ #category : #'handling - functions' }
XPathCompilingExpressionParserHandler >> handlePositionFunctionCall [
	self
		emit: $(;
		emitAll: self contextPositionVariable;
		emitAll: ' ifNil:[1])'
]

{ #category : #'handling - predicates' }
XPathCompilingExpressionParserHandler >> handlePredicateAttribute: aName equalsStringLiteral: aStringLiteral [
	self
		emitStartAttributePredicate: aName;
		emit: $=;
		emitQuotedString: aStringLiteral;
		emitEndAttributePredicate
]

{ #category : #'handling - predicates' }
XPathCompilingExpressionParserHandler >> handlePredicateAttribute: aName notEqualsStringLiteral: aStringLiteral [
	self
		emitStartAttributePredicate: aName;
		emitAll: '~=';
		emitQuotedString: aStringLiteral;
		emitEndAttributePredicate
]

{ #category : #'handling - location paths' }
XPathCompilingExpressionParserHandler >> handleStartAbsoluteLocationPath [
	self
		emitAll: self contextNodeVariable;
		emitAll: ' asXPathLocationPathRoot documentRoot'
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleStartAdditiveExpression [
	self
		emit: $(;
		pushOperator
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleStartAndExpression [
	self
		emit: $(;
		pushOperator
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleStartEqualityExpression [
	self
		emit: $(;
		pushOperator
]

{ #category : #'handling - location paths' }
XPathCompilingExpressionParserHandler >> handleStartFilterExpression [
	self emit: $(
]

{ #category : #'handling - location paths' }
XPathCompilingExpressionParserHandler >> handleStartFilterExpressionLocationPath [
	self emitAll: ' asXPathLocationPathRoot'
]

{ #category : #'handling - functions' }
XPathCompilingExpressionParserHandler >> handleStartFunctionArgument [
	self emitAll: 'push: ('
]

{ #category : #'handling - functions' }
XPathCompilingExpressionParserHandler >> handleStartFunctionCall: aFunctionName [
	self
		emitAll: '((';
		emitAll: self contextVariable;
		emitAll: ' resolveFunctionReference: ''';
		emitAll: aFunctionName;
		emitAll: ''' contextNode: ';
		emitAll: self contextNodeVariable;
		emit: $)
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleStartMultiplicativeExpression [
	self
		emit: $(;
		pushOperator
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleStartOrExpression [
	self
		emit: $(;
		pushOperator
]

{ #category : #handling }
XPathCompilingExpressionParserHandler >> handleStartParsing [
	"must use #writeStream instead of 'WriteStream on:' to get a 0-based
	stream on Gemstone"
	outputStream := (String new: 128) writeStream.
	variableStack := OrderedCollection new.
	operatorStack := OrderedCollection new.

	self emitStartContextBlock.
]

{ #category : #'handling - location paths' }
XPathCompilingExpressionParserHandler >> handleStartPathExpression [
	self emit: $(
]

{ #category : #'handling - predicates' }
XPathCompilingExpressionParserHandler >> handleStartPredicate [
	self emitStartPredicateBlock
]

{ #category : #'handling - predicates' }
XPathCompilingExpressionParserHandler >> handleStartPredicates [
	self emitAll: ' asXPathFilterable filterWithAll: {'
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleStartRelationalExpression [
	self
		emit: $(;
		pushOperator
]

{ #category : #'handling - location paths' }
XPathCompilingExpressionParserHandler >> handleStartRelativeLocationPath [
	self
		emitAll: self contextNodeVariable;
		emitAll: ' asXPathLocationPathRoot'
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleStartUnaryExpression [
	self
		emit: $(;
		pushOperator
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleStartUnionExpression [
	self
		emit: $(;
		pushOperator
]

{ #category : #handling }
XPathCompilingExpressionParserHandler >> handleStringLiteral: aString [
	self emitQuotedString: aString
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleSubtraction [
	self
		emitNumberConversion;
		currentOperator: $-
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForAnyNodeType [
	self emitAll: '[:n|true]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForAttributeWithAnyName [
	self emitAll: '[:n|n isAttribute]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForAttributeWithLocalName: aLocalName [
	self
		emitAll: '[:n|n isAttribute and:[n localName=''';
		emitAll: aLocalName;
		emitAll: ''']]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForAttributeWithName: aName [
	self
		emitAll: '[:n|n isAttribute and:[n name=''';
		emitAll: aName;
		emitAll: ''']]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForAttributeWithNamespaceURI: aURI [
	self
		emitAll: '[:n|n isAttribute and:[n namespaceURI=''';
		emitAll: aURI;
		emitAll: ''']]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForAttributeWithNamespaceURI: aURI localName: aLocalName [
	self
		emitAll: '[:n|n isAttribute and:[n localName=''';
		emitAll: aLocalName;
		emitAll: '''and:[n namespaceURI=''';
		emitAll: aURI;
		emitAll: ''']]]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForAttributeWithPrefix: aPrefix [
	self
		emit: $(;
		emitAll: self contextVariable;
		emitAll: ' testForAttributeWithPrefix:''';
		emitAll: aPrefix;
		emitAll: ''')'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForAttributeWithPrefix: aPrefix localName: aLocalName [
	self
		emit: $(;
		emitAll: self contextVariable;
		emitAll: ' testForAttributeWithPrefix:''';
		emitAll: aPrefix;
		emitAll: '''localName:''';
		emitAll: aLocalName;
		emitAll: ''')'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForCommentType [
	self emitAll: '[:n|n isComment]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForElementWithAnyName [
	self emitAll: '[:n|n isElement]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForElementWithLocalName: aLocalName [
	self
		emitAll: '[:n|n isElement and:[n localName=''';
		emitAll: aLocalName;
		emitAll: ''']]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForElementWithName: aName [
	self
		emitAll: '[:n|n isElement and:[n name=''';
		emitAll: aName;
		emitAll: ''']]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForElementWithNamespaceURI: aURI [
	self
		emitAll: '[:n|n isElement and:[n namespaceURI=''';
		emitAll: aURI;
		emitAll: ''']]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForElementWithNamespaceURI: aURI localName: aLocalName [
	self
		emitAll: '[:n|n isElement and:[n localName=''';
		emitAll: aLocalName;
		emitAll: '''and:[n namespaceURI=''';
		emitAll: aURI;
		emitAll: ''']]]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForElementWithPrefix: aPrefix [
	self
		emit: $(;
		emitAll: self contextVariable;
		emitAll: ' testForElementWithPrefix:''';
		emitAll: aPrefix;
		emitAll: ''')'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForElementWithPrefix: aPrefix localName: aLocalName [
	self
		emit: $(;
		emitAll: self contextVariable;
		emitAll: ' testForElementWithPrefix:''';
		emitAll: aPrefix;
		emitAll: '''localName:''';
		emitAll: aLocalName;
		emitAll: ''')'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForNamespaceWithAnyName [
	self emitAll: '[:n|n isNamespace]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForNamespaceWithLocalName: aLocalName [
	self
		emitAll: '[:n|n isNamespace and:[n localName=''';
		emitAll: aLocalName;
		emitAll: ''']]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForNamespaceWithName: aName [
	self
		emitAll: '[:n|n isNamespace and:[n name=''';
		emitAll: aName;
		emitAll: ''']]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForNamespaceWithNamespaceURI: aURI [
	self
		emitAll: '[:n|n isNamespace and:[n namespaceURI=''';
		emitAll: aURI;
		emitAll: ''']]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForNamespaceWithNamespaceURI: aURI localName: aLocalName [
	self
		emitAll: '[:n|n isNamespace and:[n localName=''';
		emitAll: aLocalName;
		emitAll: '''and:[n namespaceURI=''';
		emitAll: aURI;
		emitAll: ''']]]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForNamespaceWithPrefix: aPrefix [
	self
		emit: $(;
		emitAll: self contextVariable;
		emitAll: ' testForNamespaceWithPrefix:''';
		emitAll: aPrefix;
		emitAll: ''')'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForNamespaceWithPrefix: aPrefix localName: aLocalName [
	self
		emit: $(;
		emitAll: self contextVariable;
		emitAll: ' testForNamespaceWithPrefix:''';
		emitAll: aPrefix;
		emitAll: '''localName:''';
		emitAll: aLocalName;
		emitAll: ''')'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForPIWithAnyName [
	self emitAll: '[:n|n isPI]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForPIWithName: aName [
	self
		emitAll: '[:n|n isPI and:[n target=''';
		emitAll: aName;
		emitAll: ''']]'
]

{ #category : #'handling - node tests' }
XPathCompilingExpressionParserHandler >> handleTestForTextType [
	self emitAll: '[:n|n isStringNode]'
]

{ #category : #'handling - operators' }
XPathCompilingExpressionParserHandler >> handleUnion [
	self
		emitUnionableConversion;
		currentOperator: $|
]

{ #category : #handling }
XPathCompilingExpressionParserHandler >> handleVariableReference: aName [
	self
		emit: $(;
		emitAll: self contextVariable;
		emitAll: ' resolveVariableReference: ''';
		emitAll: aName;
		emitAll: ''')'
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> hasCurrentOperator [
	^ self currentOperator notNil
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> popOperator [
	operatorStack removeLast
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> popVariables [
	variableStack removeLast
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> pushOperator [
	operatorStack addLast: nil
]

{ #category : #private }
XPathCompilingExpressionParserHandler >> pushVariables [
	| indexString |

	indexString := (variableStack size + 1) printString.
	variableStack addLast:
		(Array
			with: (indexString copyWithFirst: $n) "node variable"
			with: (indexString copyWithFirst: $p) "position variable"
			with: (indexString copyWithFirst: $s)). "size variable"
]
