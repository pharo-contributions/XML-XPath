"
This is an XPath type class for XPathNodeSet objects.
"
Class {
	#name : #XPathNodeSetType,
	#superclass : #XPathObjectType,
	#category : #'XPath-Core-Types'
}

{ #category : #testing }
XPathNodeSetType >> isNodeSetType [
	^ true
]

{ #category : #testing }
XPathNodeSetType >> isTypeOf: anObject [
	^ anObject isKindOf: XPathNodeSet
]

{ #category : #accessing }
XPathNodeSetType >> name [
	^ 'node-set'
]

{ #category : #'instance creation' }
XPathNodeSetType >> newFrom: anObject [
	^ anObject asXPathNodeSet
]
