"
This is an XPath type class for any XPath value. Subclasses must implement #newFrom: to return the argument converted to the receiver type.
"
Class {
	#name : #XPathObjectValueType,
	#superclass : #XPathType,
	#category : #'XPath-Core-Types'
}

{ #category : #testing }
XPathObjectValueType >> isBooleanValueType [
	^ false
]

{ #category : #testing }
XPathObjectValueType >> isNodeSetValueType [
	^ false
]

{ #category : #testing }
XPathObjectValueType >> isNumberValueType [
	^ false
]

{ #category : #testing }
XPathObjectValueType >> isStringValueType [
	^ false
]

{ #category : #accessing }
XPathObjectValueType >> name [
	^ 'object'
]

{ #category : #'instance creation' }
XPathObjectValueType >> newFrom: anObject [
	^ anObject
]
