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

{ #category : #appending }
XPathException >> appendPosition: aPosition [
	self position
		ifNil: [
			position := aPosition.
			self
				append: aPosition
				withDescription: 'at pos.']
]

{ #category : #accessing }
XPathException >> position [
	^ position
]
