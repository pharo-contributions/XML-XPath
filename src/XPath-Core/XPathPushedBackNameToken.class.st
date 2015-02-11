"
A pushed-back name token, to be read by nextName.
"
Class {
	#name : #XPathPushedBackNameToken,
	#superclass : #XPathPushedBackToken,
	#category : #'XPath-Core-Streams'
}

{ #category : #testing }
XPathPushedBackNameToken >> isNameToken [
	^ true
]
