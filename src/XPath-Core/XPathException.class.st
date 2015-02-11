"
A base class for XPath exceptions.
"
Class {
	#name : #XPathException,
	#superclass : #XMLException,
	#category : #'XPath-Core-Exceptions'
}

{ #category : #appending }
XPathException >> appendPosition: aPosition [
	self
		append: aPosition
		withDescription: 'at pos.'
]
