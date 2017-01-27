"
This is an abstract base class for XPath types. Subclasses must implement the #name method to return a printable type name, #isTypeOf: to return true if the argument is of the receiver type, and #newFrom: to return the argument converted to the receiver type.
"
Class {
	#name : #XPathType,
	#superclass : #Object,
	#classInstVars : [
		'instance'
	],
	#category : #'XPath-Core-Types'
}

{ #category : #accessing }
XPathType class >> instance [
	^ instance ifNil: [instance := self basicNew initialize]
]

{ #category : #'instance creation' }
XPathType class >> new [
	^ self instance
]

{ #category : #testing }
XPathType >> isTypeOf: anObject [
	self subclassResponsibility
]

{ #category : #accessing }
XPathType >> name [
	self subclassResponsibility
]

{ #category : #'instance creation' }
XPathType >> newFrom: anObject [
	self subclassResponsibility
]

{ #category : #printing }
XPathType >> printOn: aStream [
	aStream nextPutAll: self name
]
