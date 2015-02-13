"
This class parses XPath expressions. It understands all of XPath 1.0 syntax and supports some extensions like abbreviated syntax for other axis specifiers.
"
Class {
	#name : #XPathExpressionParser,
	#superclass : #XPathParser,
	#instVars : [
		'currentAxis',
		'nodeTestParser'
	],
	#classVars : [
		'AbbreviatedAxisSpecifierCharacters'
	],
	#category : #'XPath-Core-Parsers'
}

{ #category : #'class initialization' }
XPathExpressionParser class >> initialize [
	"self initialzie"

	self initializeAbbreviatedAxisSpecifierCharacters
]

{ #category : #'class initialization' }
XPathExpressionParser class >> initializeAbbreviatedAxisSpecifierCharacters [
	(AbbreviatedAxisSpecifierCharacters := BitmapCharacterSet new)
		addAll: '%@~<>'
]

{ #category : #testing }
XPathExpressionParser >> atDigit [
	^ inputStream peek notNil
		and: [inputStream peek isDigit]
]

{ #category : #private }
XPathExpressionParser >> errorExpectedNodeTest [
	self errorExpected: 'node test after axis'
]

{ #category : #private }
XPathExpressionParser >> errorExpectedStep [
	self errorExpected: 'location path step'
]

{ #category : #parsing }
XPathExpressionParser >> nextAdditionalSteps [
	currentAxis reset.
	(self peekForAbbreviatedDescendantStep
		or: [self peekForStep])
		ifFalse: [self errorExpectedStep].
	[self peekForLocationPathSeparator]
		whileTrue: [
			(self peekForAbbreviatedDescendantStep
				or: [self peekForStep])
				ifFalse: [self errorExpectedStep]].
]

{ #category : #parsing }
XPathExpressionParser >> nextAdditiveExpression [
	handler handleStartAdditiveExpression.
	self nextMultiplicativeExpression.
	[self peekForAdditiveOperator]
		whileTrue: [self nextMultiplicativeExpression].
	handler handleEndAdditiveExpression.
]

{ #category : #parsing }
XPathExpressionParser >> nextAndExpression [
	| totalShortCircuited |

	handler handleStartAndExpression.
	self nextEqualityExpression.
	totalShortCircuited := 0.
	[self peekForAndOperator]
		whileTrue: [
			handler handleStartShortCircuitAnd.
			totalShortCircuited := totalShortCircuited + 1.
			self nextEqualityExpression].
	handler
		handleEndShortCircuited: totalShortCircuited;
		handleEndAndExpression.
]

{ #category : #parsing }
XPathExpressionParser >> nextDigitsOnWriteStream [
	"first digit"
	writeStream nextPut: inputStream next.
	[self atDigit]
		whileTrue: [writeStream nextPut: inputStream next].
]

{ #category : #parsing }
XPathExpressionParser >> nextEqualityExpression [
	handler handleStartEqualityExpression.
	self nextRelationalExpression.
	[self peekForEqualityOperator]
		whileTrue: [self nextRelationalExpression].
	handler handleEndEqualityExpression.
]

{ #category : #parsing }
XPathExpressionParser >> nextFilterExpression [
	self
		nextPrimaryExpression;
		peekForPredicates
]

{ #category : #parsing }
XPathExpressionParser >> nextFunctionArgument [
	handler handleStartFunctionArgument.
	self nextOrExpression.
	handler handleEndFunctionArgument.
]

{ #category : #parsing }
XPathExpressionParser >> nextFunctionCall [
	| name |

	name := self nextName.
	name = 'position'
		ifTrue: [
			handler handlePositionFunctionCall.
			^ self nextEmptyArgumentList].
	name = 'last'
		ifTrue: [
			handler handleLastFunctionCall.
			^ self nextEmptyArgumentList].

	handler handleStartFunctionCall: name.
	self nextStartArgumentList.
	inputStream skipSeparators.
	inputStream peek == $)
		ifFalse: [
			self nextFunctionArgument.
			[self peekForArgumentSeparator]
				whileTrue: [self nextFunctionArgument]].
	self nextEndArgumentList.
	handler handleEndFunctionCall.
]

{ #category : #parsing }
XPathExpressionParser >> nextMultiplicativeExpression [
	handler handleStartMultiplicativeExpression.
	self nextUnaryExpression.
	[self peekForMultiplicativeOperator]
		whileTrue: [self nextUnaryExpression].
	handler handleEndMultiplicativeExpression.
]

{ #category : #parsing }
XPathExpressionParser >> nextOrExpression [
	| totalShortCircuited |

	handler handleStartOrExpression.
	self nextAndExpression.
	totalShortCircuited := 0.
	[self peekForOrOperator]
		whileTrue: [
			handler handleStartShortCircuitOr.
			totalShortCircuited := totalShortCircuited + 1.
			self nextAndExpression].
	handler
		handleEndShortCircuited: totalShortCircuited;
		handleEndOrExpression.
]

{ #category : #parsing }
XPathExpressionParser >> nextPathExpression [
	handler handleStartPathExpression.
	self peekForLocationPathExpression
		ifFalse: [
			self nextFilterExpression.
			self peekForLocationPathSeparator
				ifTrue: [self nextAdditionalSteps]].
	handler handleEndPathExpression.
]

{ #category : #parsing }
XPathExpressionParser >> nextPrimaryExpression [
	inputStream skipSeparators.
	(self peekForVariableReference
		or: [self peekForParenthesizedExpression
			or: [self peekForStringLiteral
				or: [self peekForNumber]]])
		ifFalse: [self nextFunctionCall].
]

{ #category : #parsing }
XPathExpressionParser >> nextRelationalExpression [
	handler handleStartRelationalExpression.
	self nextAdditiveExpression.
	[self peekForRelationalOperator]
		whileTrue: [self nextAdditiveExpression].
	handler handleEndRelationalExpression.
]

{ #category : #parsing }
XPathExpressionParser >> nextUnaryExpression [
	| totalNegations |

	handler handleStartUnaryExpression.
	totalNegations := 0.
	[self peekForNegationOperator]
		whileTrue: [totalNegations := totalNegations + 1].
	totalNegations odd
		ifTrue: [handler handleNegation].
	self nextUnionExpression.
	handler handleEndUnaryExpression.
]

{ #category : #parsing }
XPathExpressionParser >> nextUnionExpression [
	handler handleStartUnionExpression.
	self nextPathExpression.
	[self peekForUnion]
		whileTrue: [self nextPathExpression].
	handler handleEndUnionExpression.
]

{ #category : #parsing }
XPathExpressionParser >> parseInput [
	currentAxis := XPathAxis new.
	nodeTestParser :=
		XPathNodeTestParser
			on: inputStream
			for:
				(XPathExpressionNodeTestParserHandler
					currentAxis: currentAxis
					expressionParserHandler: handler).
	self nextOrExpression.
]

{ #category : #'parsing - peeking' }
XPathExpressionParser >> peekFailedAt: aPosition [
	inputStream position: aPosition.
	^ false.
]

{ #category : #'parsing - peeking' }
XPathExpressionParser >> peekForAbbreviatedAxis [
	| nextChar |

	((nextChar := inputStream peek) notNil
		and: [AbbreviatedAxisSpecifierCharacters includes: nextChar])
		ifFalse: [^ false].
	writeStream
		reset;
		nextPut: inputStream next.
	[(nextChar := inputStream peek) notNil
		and: [AbbreviatedAxisSpecifierCharacters includes: nextChar]]
		whileTrue: [writeStream nextPut: inputStream next].
	currentAxis axisSpecifier: writeStream contents.
	^ true.
]

{ #category : #'parsing - peeking' }
XPathExpressionParser >> peekForAbbreviatedDescendantStep [
	self peekForLocationPathSeparator
		ifFalse: [^ false].

	"// followed by a node test is the same as
	descendant:: followed by the node test"
	currentAxis axisSpecifier: 'descendant'.
	nodeTestParser parse
		ifTrue: [
			self peekForPredicates.
			^ true]
		ifFalse: [
			"// followed by an abbreviated step or step with an
			explicit axis is the same as descendant-or-self::node()/
			followed by the step"
			currentAxis
				axisSpecifier: 'descendant-or-self';
				handleWith: handler.
			handler handleTestForNodeType.
			^ false].
]

{ #category : #'parsing - peeking' }
XPathExpressionParser >> peekForAbbreviatedStep [
	(inputStream peekFor: $.)
		ifFalse: [^ false].
	self atDigit
		ifTrue: [
			inputStream skipBack.
			^ false].
	(inputStream peekFor: $.)
		ifTrue: [currentAxis axisSpecifier: 'parent']
		ifFalse: [
			currentAxis isStartOfRelativeLocationPath
				ifFalse: [
					"can be omitted"
					currentAxis reset.
					^ true].
			currentAxis axisSpecifier: 'self'].
	currentAxis handleWith: handler.
	handler handleTestForNodeType.

	"abbreviated steps cannot have filters"
	^ true.
]

{ #category : #'parsing - peeking' }
XPathExpressionParser >> peekForAbsoluteLocationPath [
	self peekForLocationPathSeparator
		ifTrue: [
			handler handleStartAbsoluteLocationPath.
			self nextAdditionalSteps.
			^ true]
		ifFalse: [^ false]
]

{ #category : #'parsing - peeking' }
XPathExpressionParser >> peekForAdditiveOperator [
	inputStream skipSeparators.
	(inputStream peekFor: $+)
		ifTrue: [
			handler handleAddition.
			^ true].
	(inputStream peekFor: $-)
		ifTrue: [
			handler handleSubtraction.
			^ true].
	^ false.
]

{ #category : #'parsing - peeking' }
XPathExpressionParser >> peekForAndOperator [
	inputStream skipSeparators.
	^ inputStream peekForAll: 'and'.
]

{ #category : #'parsing - peeking' }
XPathExpressionParser >> peekForArgumentSeparator [
	inputStream skipSeparators.
	^ inputStream peekFor: $,
]

{ #category : #'parsing - peeking' }
XPathExpressionParser >> peekForAttributePredicate [
	| startPosition name isEquals literal |

	inputStream peek == $@
		ifFalse: [^ false].
	
	startPosition := inputStream position.
	inputStream
		next;
		skipSeparators.
	(name := self nextNameOptional: true)
		ifNil: [^ self peekFailedAt: startPosition].

	inputStream skipSeparators.
	(inputStream peekFor: $=)
		ifTrue: [isEquals := true]
		ifFalse: [
			(inputStream peekForAll: '!=')
				ifTrue: [isEquals := false]
				ifFalse: [^ self peekFailedAt: startPosition]].

	inputStream skipSeparators.
	(literal := self nextStringLiteralOptional: true)
		ifNil: [^ self peekFailedAt: startPosition].

	self peekForEndPredicate
		ifFalse: [^ self peekFailedAt: startPosition].
	isEquals
		ifTrue: [
			handler
				handlePredicateAttribute: name
				equalsStringLiteral: literal]
		ifFalse: [
			handler
				handlePredicateAttribute: name
				notEqualsStringLiteral: literal].
	^ true.
]

{ #category : #'parsing - peeking' }
XPathExpressionParser >> peekForAxis [
	| startPosition ncName |

	self peekForAbbreviatedAxis
		ifTrue: [^ true].
	startPosition := inputStream position.
	(ncName := self nextNCNameOptional: true)
		ifNil: [^ false].
	inputStream skipSeparators.
	((inputStream peekFor: $:)
		and: [inputStream peekFor: $:])
		ifFalse: [
			inputStream pushBackToken:
				(XPathPushedBackNCNameToken
					token: ncName
					position: startPosition).
			^ false].
	currentAxis axisSpecifier: ncName.
	^ true.
]

{ #category : #'parsing - peeking' }
XPathExpressionParser >> peekForEndPredicate [
	inputStream skipSeparators.
	^ inputStream peekFor: $].
]

{ #category : #'parsing - peeking' }
XPathExpressionParser >> peekForEqualityOperator [
	inputStream skipSeparators.
	(inputStream peekForAll: '!=')
		ifTrue: [
			handler handleNotEquals.
			^ true].
	(inputStream peekFor: $=)
		ifTrue: [
			handler handleEquals.
			^ true].
	^ false.
]

{ #category : #'parsing - peeking' }
XPathExpressionParser >> peekForIntegerPredicate [
	| startPosition |

	self atDigit
		ifFalse: [^ false].
	
	startPosition := inputStream position.
	writeStream reset.
	self nextDigitsOnWriteStream.
	self peekForEndPredicate
		ifTrue: [
			handler handleIntegerPredicate: writeStream contents.
			^ true]
		ifFalse: [^ self peekFailedAt: startPosition].
]

{ #category : #'parsing - peeking' }
XPathExpressionParser >> peekForLocationPathExpression [
	^ self peekForAbsoluteLocationPath
		or: [self peekForRelativeLocationPath]
]

{ #category : #'parsing - peeking' }
XPathExpressionParser >> peekForLocationPathSeparator [
	inputStream skipSeparators.
	^ inputStream peekFor: $/.
]

{ #category : #'parsing - peeking' }
XPathExpressionParser >> peekForMultiplicativeOperator [
	inputStream skipSeparators.
	inputStream atEnd
		ifTrue: [^ false].
	(inputStream peekFor: $*)
		ifTrue: [
			handler handleMultiplication.
			^ true].
	(inputStream peekForAll: 'div')
		ifTrue: [
			handler handleDivision.
			^ true].
	(inputStream peekForAll: 'mod')
		ifTrue: [
			handler handleModulus.
			^ true].
	^ false.
]

{ #category : #'parsing - peeking' }
XPathExpressionParser >> peekForNegationOperator [
	inputStream skipSeparators.
	^ inputStream peekFor: $-.
]

{ #category : #'parsing - peeking' }
XPathExpressionParser >> peekForNumber [
	| startPosition |

	startPosition := inputStream position.
	writeStream reset.
	self atDigit
		ifTrue: [
			self nextDigitsOnWriteStream.
			(inputStream peekFor: $.)
				ifTrue: [
					"float literals cannot have trailing '.'"
					self atDigit
						ifTrue: [
							writeStream nextPut: $..
							self nextDigitsOnWriteStream]].
			handler handleNumberLiteral: writeStream contents.
			^ true].
	(inputStream peekFor: $.)
		ifTrue: [
			self atDigit
				ifTrue: [
					"float literals can't have leading '.'"
					writeStream nextPutAll: '0.'.
					self nextDigitsOnWriteStream.
					handler handleNumberLiteral: writeStream contents.
					^ true]].
	^ self peekFailedAt: startPosition.
]

{ #category : #'parsing - peeking' }
XPathExpressionParser >> peekForOrOperator [
	inputStream skipSeparators.
	^ inputStream peekForAll: 'or'.
]

{ #category : #'parsing - peeking' }
XPathExpressionParser >> peekForParenthesizedExpression [
	(inputStream peekFor: $()
		ifFalse: [^ false].

	self nextOrExpression.
	inputStream skipSeparators.
	self expectNext: $).
	^ true.

]

{ #category : #'parsing - peeking' }
XPathExpressionParser >> peekForPredicate [
	inputStream skipSeparators.
	(inputStream peekFor: $[)
			ifFalse: [^ false].

	inputStream skipSeparators.
	(self peekForIntegerPredicate
		or: [self peekForAttributePredicate])
		ifTrue: [^ true].

	handler handleStartPredicate.
	self nextOrExpression.
	inputStream skipSeparators.
	self expectNext: $].
	handler handleEndPredicate.
	^ true.
]

{ #category : #'parsing - peeking' }
XPathExpressionParser >> peekForPredicates [
	[self peekForPredicate] whileTrue
]

{ #category : #'parsing - peeking' }
XPathExpressionParser >> peekForRelationalOperator [
	inputStream skipSeparators.
	(inputStream peekFor: $<)
		ifTrue: [
			(inputStream peekFor: $=)
				ifTrue: [handler handleLessThanOrEqualTo]
				ifFalse: [handler handleLessThan].
			^ true].
	(inputStream peekFor: $>)
		ifTrue: [
			(inputStream peekFor: $=)
				ifTrue: [handler handleGreaterThanOrEqualTo]
				ifFalse: [handler handleGreaterThan].
			^ true].
	^ false.
]

{ #category : #'parsing - peeking' }
XPathExpressionParser >> peekForRelativeLocationPath [
	currentAxis
		reset;
		isStartOfRelativeLocationPath: true.
	self peekForStep
		ifFalse: [^ false].
	self peekForLocationPathSeparator
		ifTrue: [self nextAdditionalSteps].
	^ true.
]

{ #category : #'parsing - peeking' }
XPathExpressionParser >> peekForStep [
	inputStream skipSeparators.
	inputStream atEnd
		ifTrue: [^ false].
	self peekForAbbreviatedStep
		ifTrue: [^ true].
	self peekForAxis.
	nodeTestParser parse
		ifFalse: [
			currentAxis isImplicit
				ifFalse: [self errorExpectedNodeTest].
			currentAxis reset.
			^ false].
	self peekForPredicates.
	^ true.
]

{ #category : #'parsing - peeking' }
XPathExpressionParser >> peekForStringLiteral [
	(self nextStringLiteralOptional: true)
		ifNil: [^ false]
		ifNotNil: [:string |
			handler handleStringLiteral: string.
			^ true]
]

{ #category : #'parsing - peeking' }
XPathExpressionParser >> peekForUnion [
	inputStream skipSeparators.
	(inputStream peekFor: $|)
		ifTrue: [
			handler handleUnion.
			^ true]
		ifFalse: [^ false]
]

{ #category : #'parsing - peeking' }
XPathExpressionParser >> peekForVariableReference [
	(inputStream peekFor: $$)
		ifTrue: [
			handler handleVariableReference: self nextName.
			^ true]
		ifFalse: [^ false]
]