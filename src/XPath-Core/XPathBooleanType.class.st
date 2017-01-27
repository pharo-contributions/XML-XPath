"
This is an XPath type class for 'true' and 'false'.
"
Class {
	#name : #XPathBooleanType,
	#superclass : #XPathObjectType,
	#category : #'XPath-Core-Types'
}

{ #category : #testing }
XPathBooleanType >> isBooleanType [
	^ true
]

{ #category : #testing }
XPathBooleanType >> isTypeOf: anObject [
	^ anObject isKindOf: Boolean
]

{ #category : #accessing }
XPathBooleanType >> name [
	^ 'boolean'
]

{ #category : #'instance creation' }
XPathBooleanType >> newFrom: anObject [
	^ anObject asXPathBoolean
]
