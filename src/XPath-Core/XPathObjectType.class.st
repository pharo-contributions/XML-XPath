"
This is an XPath type class for any object.
"
Class {
	#name : #XPathObjectType,
	#superclass : #XPathType,
	#category : #'XPath-Core-Types'
}

{ #category : #testing }
XPathObjectType >> isBooleanType [
	^ false
]

{ #category : #testing }
XPathObjectType >> isNodeSetType [
	^ false
]

{ #category : #testing }
XPathObjectType >> isNumberType [
	^ false
]

{ #category : #testing }
XPathObjectType >> isObjectType [
	^ true
]

{ #category : #testing }
XPathObjectType >> isStringType [
	^ false
]

{ #category : #testing }
XPathObjectType >> isTypeOf: anObject [
	^ true
]

{ #category : #accessing }
XPathObjectType >> name [
	^ 'object'
]

{ #category : #'instance creation' }
XPathObjectType >> newFrom: anObject [
	^ anObject
]
