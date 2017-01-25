"
A class for wrapping XPath booleans to polymorphically implement XPath comparison operators.
"
Class {
	#name : #XPathBooleanComparable,
	#superclass : #XPathComparable,
	#category : #'XPath-Core-Compilation'
}

{ #category : #comparing }
XPathBooleanComparable >> < aComparable [
	^ aComparable greaterThanBoolean: value
]

{ #category : #comparing }
XPathBooleanComparable >> <= aComparable [
	^ (aComparable greaterThanBoolean: value)
		or: [aComparable equalsBoolean: value]
]

{ #category : #comparing }
XPathBooleanComparable >> = aComparable [
	^ aComparable equalsBoolean: value
]

{ #category : #comparing }
XPathBooleanComparable >> > aComparable [
	^ aComparable lessThanBoolean: value
]

{ #category : #comparing }
XPathBooleanComparable >> >= aComparable [
	^ (aComparable lessThanBoolean: value)
		or: [aComparable equalsBoolean: value]
]

{ #category : #private }
XPathBooleanComparable >> equalsBoolean: aBoolean [
	^ value = aBoolean
]

{ #category : #private }
XPathBooleanComparable >> equalsNodeSet: aNodeSet [
	^ value = aNodeSet asXPathBoolean
]

{ #category : #private }
XPathBooleanComparable >> equalsNumber: aNumber [
	^ value = aNumber asXPathBoolean
]

{ #category : #private }
XPathBooleanComparable >> equalsString: aString [
	^ value = aString asXPathBoolean
]

{ #category : #private }
XPathBooleanComparable >> greaterThanBoolean: aBoolean [
	^ value asXPathNumber > aBoolean asXPathNumber
]

{ #category : #private }
XPathBooleanComparable >> greaterThanNodeSet: aNodeSet [
	^ value asXPathNumber > aNodeSet asXPathBoolean asXPathNumber
]

{ #category : #private }
XPathBooleanComparable >> greaterThanNumber: aNumber [
	^ value asXPathNumber > aNumber asXPathNumber
]

{ #category : #private }
XPathBooleanComparable >> greaterThanString: aString [
	^ value asXPathNumber > aString asXPathNumber
]

{ #category : #private }
XPathBooleanComparable >> lessThanBoolean: aBoolean [
	^ value asXPathNumber < aBoolean asXPathNumber
]

{ #category : #private }
XPathBooleanComparable >> lessThanNodeSet: aNodeSet [
	^ value asXPathNumber < aNodeSet asXPathBoolean asXPathNumber
]

{ #category : #private }
XPathBooleanComparable >> lessThanNumber: aNumber [
	^ value asXPathNumber < aNumber asXPathNumber
]

{ #category : #private }
XPathBooleanComparable >> lessThanString: aString [
	^ value asXPathNumber < aString asXPathNumber
]

{ #category : #private }
XPathBooleanComparable >> notEqualsBoolean: aBoolean [
	^ value ~= aBoolean
]

{ #category : #private }
XPathBooleanComparable >> notEqualsNodeSet: aNodeSet [
	^ value ~= aNodeSet asXPathBoolean
]

{ #category : #private }
XPathBooleanComparable >> notEqualsNumber: aNumber [
	^ value ~= aNumber asXPathBoolean
]

{ #category : #private }
XPathBooleanComparable >> notEqualsString: aString [
	^ value ~= aString asXPathBoolean
]

{ #category : #comparing }
XPathBooleanComparable >> ~= aComparable [
	^ aComparable notEqualsBoolean: value
]
