"
This is a base class for XPath parsers.
"
Class {
	#name : #XPathParser,
	#superclass : #Object,
	#instVars : [
		'handler',
		'inputStream',
		'writeStream'
	],
	#category : #'XPath-Core-Parsers'
}

{ #category : #'instance creation' }
XPathParser class >> on: aStringOrStream for: aHandler [
	^ self new
		on: aStringOrStream
		for: aHandler
]

{ #category : #parsing }
XPathParser >> endParsing [
	handler handleEndParsing.
	handler mustBeAtEndAfterParsing
		ifTrue: [	
			inputStream skipSeparators.
			inputStream atEnd
				ifFalse: [self errorExpectedAtEnd]].
]

{ #category : #private }
XPathParser >> errorExpected: aString [
	XPathSyntaxException
		formatSignal: 'Expected {1}'
		with: aString
]

{ #category : #private }
XPathParser >> errorExpectedAtEnd [
	self errorExpected: 'end of input'
]

{ #category : #private }
XPathParser >> errorExpectedLiteral: anExpectedCharacterOrString butGot: aReceivedCharacterOrString [
	XPathSyntaxException
		formatSignal: 'Expected "{1}" but got "{2}"'
		with: anExpectedCharacterOrString
		with: (aReceivedCharacterOrString ifNil: [''])
]

{ #category : #private }
XPathParser >> errorExpectedName [
	self errorExpected: 'name'
]

{ #category : #private }
XPathParser >> errorExpectedRelativeLocationPath [
	self errorExpected: 'relative location path'
]

{ #category : #private }
XPathParser >> errorExpectedStringLiteral [
	self errorExpected: 'single or double quoted string literal'
]

{ #category : #private }
XPathParser >> expectNext: aCharacter [
	| nextChar |

	((nextChar := inputStream next) == aCharacter)
		ifFalse: [
			self
				errorExpectedLiteral: aCharacter
				butGot: nextChar].
	^ aCharacter.
]

{ #category : #private }
XPathParser >> expectUpTo: aCharacter [
	writeStream reset.
	[inputStream atEnd
		or: [inputStream peek == aCharacter]]
		whileFalse: [writeStream nextPut: inputStream next].
	self expectNext: aCharacter.
	^ writeStream contents.
]

{ #category : #accessing }
XPathParser >> handler [
	^ handler
]

{ #category : #accessing }
XPathParser >> inputStream [
	^ inputStream
]

{ #category : #parsing }
XPathParser >> nextArgument [
	"override to parse arguments in function argument lists"
]

{ #category : #parsing }
XPathParser >> nextArgumentList [
	"a template method; nextArgument must be overriden to handle arguments"
	self nextStartArgumentList.
	self peekForEndArgumentList
		ifFalse: [
			self nextArgument.
			[self peekForArgumentSeparator]
				whileTrue: [self nextArgument].
			self nextEndArgumentList].
]

{ #category : #parsing }
XPathParser >> nextEmptyArgumentList [
	self
		nextStartArgumentList;
		nextEndArgumentList

]

{ #category : #parsing }
XPathParser >> nextEndArgumentList [
	inputStream skipSeparators.
	self expectNext: $).
]

{ #category : #parsing }
XPathParser >> nextNCName [
	^ self nextNCNameOptional: false
]

{ #category : #parsing }
XPathParser >> nextNCNameOptional: aBoolean [
	(inputStream hasPushedBackToken
		and: [inputStream pushedBackToken isNCNameToken])
		ifTrue: [^ inputStream nextPushedBackToken].

	writeStream reset.
	(XMLWellFormedParserTokenizer
		nextNCNameFrom: inputStream
		on: writeStream)
		ifFalse: [
			aBoolean
				ifTrue: [^ nil]
				ifFalse: [self errorExpectedName]].
	^ writeStream contents.
]

{ #category : #parsing }
XPathParser >> nextName [
	^ self nextNameOptional: false
]

{ #category : #parsing }
XPathParser >> nextNameOptional: aBoolean [
	inputStream hasPushedBackToken
		ifTrue: [
			inputStream pushedBackToken isNCNameToken
				ifTrue: [
					writeStream
						reset;
						nextPutAll: inputStream nextPushedBackToken.
					(inputStream peekFor: $:)
						ifTrue: [
							writeStream
								nextPut: $:;
								nextPutAll:
									((self nextNCNameOptional: aBoolean)
										ifNil: [^ nil])].
					^ writeStream contents]].

	writeStream reset.
	(XMLWellFormedParserTokenizer
		nextNameFrom: inputStream
		on: writeStream)
			ifFalse: [
			aBoolean
				ifTrue: [^ nil]
				ifFalse: [self errorExpectedName]].
	^ writeStream contents.
]

{ #category : #parsing }
XPathParser >> nextStartArgumentList [
	inputStream skipSeparators.
	self expectNext: $(.
]

{ #category : #parsing }
XPathParser >> nextStringLiteral [
	^ self nextStringLiteralOptional: false
]

{ #category : #parsing }
XPathParser >> nextStringLiteralOptional: aBoolean [
	(inputStream peek == $"
		or: [inputStream peek == $'])
		ifTrue: [^ self expectUpTo: inputStream next]
		ifFalse: [
			aBoolean
				ifFalse: [self errorExpectedStringLiteral].
			^ nil]
]

{ #category : #initialization }
XPathParser >> on: aStringOrStream for: aHandler [
	inputStream :=
		(aStringOrStream isStream
			ifTrue: [aStringOrStream asXPathReadStreamAdapter]
			ifFalse: [aStringOrStream readStream asXPathReadStreamAdapter]).
	handler := aHandler.
	writeStream := (String new: 32) writeStream.
]

{ #category : #parsing }
XPathParser >> parse [
	[self
		startParsing;
		parseInput;
		endParsing]
		on: XPathException
		do: [:error |
			error
				appendPosition: inputStream position;
				pass].
	^ handler parsingResult.
]

{ #category : #parsing }
XPathParser >> parseInput [
	self subclassResponsibility
]

{ #category : #'parsing - peeking' }
XPathParser >> peekForArgumentSeparator [
	inputStream skipSeparators.
	^ inputStream peekFor: $,
]

{ #category : #'parsing - peeking' }
XPathParser >> peekForEndArgumentList [
	inputStream skipSeparators.
	^ inputStream peekFor: $)
]

{ #category : #parsing }
XPathParser >> startParsing [
	handler handleStartParsing
]
