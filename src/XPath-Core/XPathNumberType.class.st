"
This is an XPath type class for Floats and instances of other Number subclasses.
"
Class {
	#name : #XPathNumberType,
	#superclass : #XPathObjectType,
	#category : #'XPath-Core-Types'
}

{ #category : #testing }
XPathNumberType >> isNumberType [
	^ true
]

{ #category : #testing }
XPathNumberType >> isTypeOf: anObject [
	^ anObject isNumber
]

{ #category : #accessing }
XPathNumberType >> name [
	^ 'number'
]

{ #category : #'instance creation' }
XPathNumberType >> newFrom: anObject [
	^ anObject asXPathNumber
]
