"
This is a class for storing pushed-back tokens so they can be quickly read again.
"
Class {
	#name : #XPathPushedBackToken,
	#superclass : #Object,
	#instVars : [
		'token',
		'position'
	],
	#category : #'XPath-Core-Streams'
}

{ #category : #'instance creation' }
XPathPushedBackToken class >> token: aToken position: aPosition [
	^ self new
		setToken: aToken
		position: aPosition
]

{ #category : #testing }
XPathPushedBackToken >> isNCNameToken [
	^ false
]

{ #category : #accessing }
XPathPushedBackToken >> position [
	^ position
]

{ #category : #initialization }
XPathPushedBackToken >> setToken: aToken position: aPosition [
	token := aToken.
	position := aPosition.
]

{ #category : #accessing }
XPathPushedBackToken >> token [
	^ token
]
