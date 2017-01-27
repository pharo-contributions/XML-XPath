"
This is an XPath type class for strings.
"
Class {
	#name : #XPathStringType,
	#superclass : #XPathObjectType,
	#category : #'XPath-Core-Types'
}

{ #category : #testing }
XPathStringType >> isStringType [
	^ true
]

{ #category : #testing }
XPathStringType >> isTypeOf: anObject [
	^ anObject isString
]

{ #category : #accessing }
XPathStringType >> name [
	^ 'string'
]

{ #category : #'instance creation' }
XPathStringType >> newFrom: anObject [
	^ anObject asXPathString
]
