"
This class is an adapter for positionable read streams that wraps them to be safe to send messages like next and peek when atEnd and supports efficient push back of token objects to minimize backtracking by parsers.
"
Class {
	#name : #XPathReadStreamAdapter,
	#superclass : #Object,
	#instVars : [
		'stream',
		'pushedBackToken',
		'writeStream'
	],
	#category : #'XPath-Core-Streams'
}

{ #category : #'instance creation' }
XPathReadStreamAdapter class >> on: aPositionableStream [
	^ self new on: aPositionableStream
]

{ #category : #converting }
XPathReadStreamAdapter >> asXPathReadStreamAdapter [
	^ self
]

{ #category : #testing }
XPathReadStreamAdapter >> atEnd [
	^ stream atEnd
]

{ #category : #testing }
XPathReadStreamAdapter >> isStream [
	^ true
]

{ #category : #accessing }
XPathReadStreamAdapter >> next [
	stream atEnd
		ifTrue: [^ nil]
		ifFalse: [^ stream next]
]

{ #category : #accessing }
XPathReadStreamAdapter >> nextMatchAll: aString [
	| oldPosition |

	(stream atEnd not
		and: [stream peek == (aString at: 1)])
		ifFalse: [^ false].

	oldPosition := stream position.
	stream next.
	2 to: aString size do: [:i |
		(stream atEnd not
			and: [stream next == (aString at: i)])
			ifFalse: [
				stream position: oldPosition.
				^ false]].
	^ true.
]

{ #category : #accessing }
XPathReadStreamAdapter >> nextNCName [
	"returns the next non-qualified name or nil"

	(self peekPushedBackToken notNil
		and: [self peekPushedBackToken isNCNameToken])
		ifTrue: [^ self nextPushedBackToken value].

	writeStream reset.
	self peek isXMLNCNameStartChar
		ifFalse: [^ nil].
	writeStream nextPut: self next.

	[self peek isXMLNCNameChar]
		whileTrue: [writeStream nextPut: self next].
	^ writeStream contents.
]

{ #category : #accessing }
XPathReadStreamAdapter >> nextName [
	"returns the next qualified or non-qualified name or nil"

	| oldPosition ncNameOrPrefix |

	oldPosition := self position.
	(ncNameOrPrefix := self nextNCName)
		ifNil: [^ nil].
	(self peekFor: $:)
		ifFalse: [
			"just a local name"
			^ ncNameOrPrefix].
	self nextNCName
		ifNil: [
			"an NCName followed by : must have a local name after"
			self position: oldPosition.
			^ nil]
		ifNotNil: [:localName |
			"a full qualified name"
			^ localName qualifyWithXMLPrefix: ncNameOrPrefix].
]

{ #category : #accessing }
XPathReadStreamAdapter >> nextPushedBackToken [
	self peekPushedBackToken
		ifNil: [^ nil]
		ifNotNil: [:token |
			self position: self position + token value size.
			^ token]
]

{ #category : #initialization }
XPathReadStreamAdapter >> on: aStream [
	stream := aStream.
	writeStream := (String new: 32) writeStream.
]

{ #category : #accessing }
XPathReadStreamAdapter >> peek [
	stream atEnd
		ifTrue: [^ nil]
		ifFalse: [^ stream peek]
]

{ #category : #accessing }
XPathReadStreamAdapter >> peekFor: aCharacter [
	(stream atEnd not
		and: [stream peek == aCharacter])
		ifTrue: [
			stream next.
			^ true]
		ifFalse: [^ false]
]

{ #category : #accessing }
XPathReadStreamAdapter >> peekPushedBackToken [
	^ (pushedBackToken notNil
		and: [pushedBackToken position = self position])
		ifTrue: [^ pushedBackToken]
		ifFalse: [^ nil]
]

{ #category : #accessing }
XPathReadStreamAdapter >> position [
	^ stream position
]

{ #category : #accessing }
XPathReadStreamAdapter >> position: aPosition [
	stream position: aPosition
]

{ #category : #positioning }
XPathReadStreamAdapter >> pushBackNCName: anNCName position: aPosition [
	self pushBackToken:
		(XPathPushedBackNCNameToken
			value: anNCName
			position: aPosition)
]

{ #category : #positioning }
XPathReadStreamAdapter >> pushBackToken: aPushedBackToken [
	pushedBackToken := aPushedBackToken.
	self position: aPushedBackToken position.
]

{ #category : #positioning }
XPathReadStreamAdapter >> skipBack [
	"does not peek like #back"
	stream position: stream position - 1
]

{ #category : #positioning }
XPathReadStreamAdapter >> skipSeparators [
	stream xPathSkipSeparators
]
