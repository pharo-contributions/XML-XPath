"
This class is an adapter for positionable read streams that wraps them to be safe to send messages like next and peek when atEnd and supports efficient push back of token objects to minimize backtracking by parsers.
"
Class {
	#name : #XPathReadStreamAdapter,
	#superclass : #Object,
	#instVars : [
		'stream',
		'pushedBackToken'
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
XPathReadStreamAdapter >> hasPushedBackToken [
	^ pushedBackToken notNil
		and: [pushedBackToken position = self position]
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
XPathReadStreamAdapter >> nextPushedBackToken [
	| token |

	token := pushedBackToken token.
	self position: self position + token size.
	pushedBackToken := nil.
	^ token.
]

{ #category : #initialization }
XPathReadStreamAdapter >> on: aStream [
	stream := aStream
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
XPathReadStreamAdapter >> peekForAll: aString [
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
XPathReadStreamAdapter >> position [
	^ stream position
]

{ #category : #accessing }
XPathReadStreamAdapter >> position: aPosition [
	stream position: aPosition
]

{ #category : #accessing }
XPathReadStreamAdapter >> pushBackNCName: anNcName position: aPosition [
	self pushBackToken:
		(XPathPushedBackNCNameToken
			token: anNcName
			position: aPosition)
]

{ #category : #accessing }
XPathReadStreamAdapter >> pushBackToken: aPushedBackToken [
	pushedBackToken := aPushedBackToken.
	self position: aPushedBackToken position.
]

{ #category : #accessing }
XPathReadStreamAdapter >> pushedBackToken [
	^ pushedBackToken
]

{ #category : #streaming }
XPathReadStreamAdapter >> skipBack [
	"does not peek like #back"
	stream position: stream position - 1
]

{ #category : #streaming }
XPathReadStreamAdapter >> skipSeparators [
	stream xPathSkipSeparators
]
