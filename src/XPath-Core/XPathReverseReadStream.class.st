"
A basic read stream that streams a collection in reverse with next, peek, and atEnd.
"
Class {
	#name : #XPathReverseReadStream,
	#superclass : #Object,
	#instVars : [
		'collection',
		'position',
		'readLimit'
	],
	#category : #'XPath-Core-Streams'
}

{ #category : #'instance creation' }
XPathReverseReadStream class >> on: aCollection [
	^ self new on: aCollection
]

{ #category : #testing }
XPathReverseReadStream >> atEnd [
	^ position >= readLimit
]

{ #category : #testing }
XPathReverseReadStream >> isStream [
	^ true
]

{ #category : #accessing }
XPathReverseReadStream >> next [
	self atEnd
		ifTrue: [^ nil]
		ifFalse: [| next |
			next := collection at: readLimit - position.
			position := position + 1.
			^ next]
]

{ #category : #initialization }
XPathReverseReadStream >> on: aCollection [
	collection := aCollection.
	position := 0.
	readLimit := aCollection size.
]

{ #category : #accessing }
XPathReverseReadStream >> peek [
	self atEnd
		ifTrue: [^ nil]
		ifFalse: [^ collection at: readLimit - position]
]

{ #category : #accessing }
XPathReverseReadStream >> position [
	^ position
]
