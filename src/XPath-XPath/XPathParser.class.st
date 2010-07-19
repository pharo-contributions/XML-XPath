Class {
	#name : #XPathParser,
	#superclass : #Object,
	#instVars : [
		'stream',
		'path',
		'pathSource'
	],
	#category : #'XPath-XPath'
}

{ #category : #'instance creation' }
XPathParser class >> new [
	^super new initialize
]

{ #category : #'instance creation' }
XPathParser class >> on: aStream [
	| parser |
	parser := self new.
	parser stream: aStream.
	^parser
]

{ #category : #emitting }
XPathParser >> emit: string [
	pathSource := pathSource , string
]

{ #category : #emitting }
XPathParser >> emitAndBetween: operandCollection [

	| code |
	
	code := String streamContents: [: s |
		s nextPutAll: 'self andAttributes: ';
			nextPut: ${;
			space.
		operandCollection do: [: each |
			s nextPutAll: ( self quoted: each ).
			  ( operandCollection indexOf: each ) = operandCollection size
				ifFalse: [ s nextPut: $. ] ].
		s nextPut: $};
			nextPut: $. ].
	self emit: code.
]

{ #category : #emitting }
XPathParser >> emitArgList: args [
]

{ #category : #emitting }
XPathParser >> emitAttribute: name [ 
	
	| code |

	code := String streamContents: [: str |
		str nextPutAll: 'self attribute: ';
			nextPutAll: (self quoted: name);
			nextPut: $.. ].
	self emit: code
]

{ #category : #emitting }
XPathParser >> emitDescendants [
	self emit: 'self descendants.'
]

{ #category : #emitting }
XPathParser >> emitElement: name [ 

	| code |

	code := String streamContents: [: str |
		str nextPutAll: 'self element: ';
			nextPutAll: (self quoted: name);
			nextPut: $.. ].
	self emit: code

]

{ #category : #emitting }
XPathParser >> emitEndFilter [
	self emit: ']'
]

{ #category : #emitting }
XPathParser >> emitFinish [
	pathSource := pathSource , 'results := self pop. ^ self results'
]

{ #category : #emitting }
XPathParser >> emitFunction: name [ 
	"No lookup of function name in a reserved word table; assume it's right and embed in  
	instructions"
	self emit: ('self ' , name , '.').
]

{ #category : #emitting }
XPathParser >> emitOperation: aCollection [
	
	| operandsCollection |

	operandsCollection := aCollection select: [: each | ( aCollection indexOf: each ) odd ].
	aCollection second = 'and'
		ifTrue: [ self emitAndBetween: operandsCollection ]
		ifFalse: [ aCollection second = '|'
					ifTrue: [ self emitOrBetween: operandsCollection ] ].

]

{ #category : #emitting }
XPathParser >> emitOrBetween: operandCollection [

	| code |
	
	code := String streamContents: [: s |
		s nextPutAll: 'self orAttributes: ';
			nextPut: ${;
			space.
		operandCollection do: [: each |
			s nextPutAll: ( self quoted: each ).
		  ( operandCollection indexOf: each ) = operandCollection size
			ifFalse: [ s nextPut: $. ] ].
		s nextPut: $};
			nextPut: $. ].
	self emit: code.
]

{ #category : #emitting }
XPathParser >> emitParent [
	self emit: 'self parent.'
]

{ #category : #emitting }
XPathParser >> emitStart [
	pathSource := 'self push: (Array with: root).'
]

{ #category : #emitting }
XPathParser >> emitStartFilter [
	self emit: 'self filter: ['
]

{ #category : #emitting }
XPathParser >> emitThis [
]

{ #category : #initialization }
XPathParser >> initialize [
	path := XPath new.
	self emitStart.
	^self
]

{ #category : #streaming }
XPathParser >> next [
	^stream next
]

{ #category : #streaming }
XPathParser >> nextName [
	"Assume the stream is positioned at the beginning of a name. Read in that name and return it as a string." 
	| char name |
	name := String new.
	char := self peek. 
	char = $* ifTrue: [self next. ^'*'].
	[ 
		char := self peek.
		char notNil and:[(char isAlphaNumeric) or: [char = $-]]
		] 
		whileTrue:
			[char := self next. name := name , (char asString)].
	^name.
		

]

{ #category : #streaming }
XPathParser >> nextNumber [
	"Assume the stream is positioned at the beginning of a number. Read in that number and return it as a string." 
	| char number |
	number := String new.
	[ 
		char := self peek.
		char notNil and:[(char isDigit)]
		] 
		whileTrue:
			[char := self next. number := number , (char asString)].
	^number asInteger.
		

]

{ #category : #streaming }
XPathParser >> nextOperator [
	"Assume the stream is positioned at the beginning of an operator. 
	Read in that name and return it as a string." 
	
	^ String streamContents: [: s |	
		| char |
		[ char := self peek. 
		char = Character space ]
			whileFalse: [ 
				char := self next.
				s nextPut: char ]
		].

		

]

{ #category : #parsing }
XPathParser >> parse [
	"Parse the path found on the stream"
	self parseExpression.
	self emitFinish.
	^ pathSource
]

{ #category : #parsing }
XPathParser >> parseArgList [
	self next = $(
		ifTrue: [].
	[self peek = $)]
		whileFalse: [self parseExpression].
	self next = $)
		ifTrue: []
]

{ #category : #parsing }
XPathParser >> parseAttribute [
	"Parse the attribute found on the stream"
	| name |
	self next.	"Skip the @"
	name := self nextName.
	self emitAttribute: name.
]

{ #category : #parsing }
XPathParser >> parseDot [
	| char |
	char := self next; peek. "Skip the first $., then check to see if there is another behind it"
	char = $. 
		ifTrue: "Referencing parent node"
			[self next. self emitParent]
		ifFalse: [self emitThis]. "Do nothing--referencing current node"
		
]

{ #category : #parsing }
XPathParser >> parseElementOrFunction [
	"Parse the element found on the stream"
	| name |
	name := self nextName.
	"Do a quick check to see if this is really a function call"
	self peek = $(
		ifTrue: ["It is a function call"
			self parseArgList.
			self emitFunction: name.]
		ifFalse: ["It's an element name"
			self emitElement: name]
]

{ #category : #'parsing-unimplemented' }
XPathParser >> parseEqualityExpression [
]

{ #category : #parsing }
XPathParser >> parseExpression [
	self parseLocation.
]

{ #category : #parsing }
XPathParser >> parseFilter [
	self peek isDigit
		ifTrue: [self parsePosition]
		ifFalse: [ self emitStartFilter. self parseExpression. self emitEndFilter.].
	^ self
]

{ #category : #'parsing-unimplemented' }
XPathParser >> parseFunctionCall [
]

{ #category : #parsing }
XPathParser >> parseLiteral [
]

{ #category : #parsing }
XPathParser >> parseLocation [
	"Parse the location found on the stream"
	"path := XPath new."
	| char |
	[char := self peek.
	char notNil & ((char = $)) not)]
		whileTrue: [
			"Check to see if it's an element test"
			( char isLetter or: [char = $*] )
				ifTrue: [self parseElementOrFunction].
			char = $@
				ifTrue: [self parseAttribute].
			char = $.
				ifTrue: [self parseDot].
			char = $/
				ifTrue: [self parseSlash].
			char = $[
				ifTrue: [self parseFilter].
			char = $(
				ifTrue: [self parseOperator] ]
]

{ #category : #'parsing-unimplemented' }
XPathParser >> parseNotExpression [
]

{ #category : #'parsing-unimplemented' }
XPathParser >> parseNumber [
]

{ #category : #parsing }
XPathParser >> parseOperator [

	| nameLeft operator rem |
	
	self needsWork. " a lot really "
	rem := OrderedCollection new.
	" Skip the ( "
	self next.
	" Skip the @ "
	self next.
	nameLeft := self nextName.
	self peek = Character space
		ifTrue: [ 
			self next.
			operator := self nextOperator ].
	rem add: nameLeft;
		add: operator.
	[ self peek = Character space and: [ self peek ~= $) ] ]
		whileTrue: [ 
			" Skip space "
			self next.		
			" Skip the @ "
			self next.		
			rem add: self nextName.
			self peek = $)
				ifFalse: [ self next.
						rem add: self nextOperator ]
		].
				
				
	self emitOperation: rem.

]

{ #category : #'parsing-unimplemented' }
XPathParser >> parseOrExpression [
]

{ #category : #'parsing-unimplemented' }
XPathParser >> parseParentheticalExpression [
]

{ #category : #'parsing-unimplemented' }
XPathParser >> parsePosition [
	^ self
]

{ #category : #'parsing-unimplemented' }
XPathParser >> parsePrimaryExpression [
]

{ #category : #parsing }
XPathParser >> parseSlash [
	| char |
	char := self next; peek.
	char = $/ 
		ifTrue:
			[self next.  self emitDescendants]
		ifFalse: []. "Do nothing--parsing an element will take care of everything"

]

{ #category : #'parsing-unimplemented' }
XPathParser >> parseVariableReference [
]

{ #category : #accessing }
XPathParser >> path [
	path ifNil: [self parse].
	^path
]

{ #category : #streaming }
XPathParser >> peek [
	^stream peek
]

{ #category : #accessing }
XPathParser >> quoted: string [
	^ ($' asString) , string , ($' asString)
]

{ #category : #accessing }
XPathParser >> stream [
	^ stream
]

{ #category : #accessing }
XPathParser >> stream: aStream [
	stream := aStream
]
