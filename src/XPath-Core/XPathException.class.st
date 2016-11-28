"
A base class for XPath exceptions.
"
Class {
	#name : #XPathException,
	#superclass : #XMLException,
	#instVars : [
		'position'
	],
	#category : #'XPath-Core-Exceptions'
}

{ #category : #testing }
XPathException >> hasPosition [
	^ position notNil
]

{ #category : #accessing }
XPathException >> position [
	^ position
]

{ #category : #accessing }
XPathException >> position: aPosition [
	position := aPosition.
	self
		messageTextAppend: aPosition
		withDescription: 'at pos.'.
]
