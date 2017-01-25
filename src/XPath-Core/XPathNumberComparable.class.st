"
A class for wrapping XPath numbers to polymorphically implement XPath comparison operators.
"
Class {
	#name : #XPathNumberComparable,
	#superclass : #XPathComparable,
	#category : #'XPath-Core-Compilation'
}

{ #category : #comparing }
XPathNumberComparable >> < aComparable [
	^ aComparable greaterThanNumber: value
]

{ #category : #comparing }
XPathNumberComparable >> <= aComparable [
	^ (aComparable greaterThanNumber: value)
		or: [aComparable equalsNumber: value]
]

{ #category : #comparing }
XPathNumberComparable >> = aComparable [
	^ aComparable equalsNumber: value
]

{ #category : #comparing }
XPathNumberComparable >> > aComparable [
	^ aComparable lessThanNumber: value
]

{ #category : #comparing }
XPathNumberComparable >> >= aComparable [
	^ (aComparable lessThanNumber: value)
		or: [aComparable equalsNumber: value]
]

{ #category : #private }
XPathNumberComparable >> equalsBoolean: aBoolean [
	^ value asXPathBoolean = aBoolean
]

{ #category : #private }
XPathNumberComparable >> equalsNodeSet: aNodeSet [
	^ aNodeSet anySatisfy: [:each | value = each stringValue asXPathNumber]
]

{ #category : #private }
XPathNumberComparable >> equalsNumber: aNumber [
	^ value = aNumber
]

{ #category : #private }
XPathNumberComparable >> equalsString: aString [
	^ value = aString asXPathNumber
]

{ #category : #private }
XPathNumberComparable >> greaterThanBoolean: aBoolean [
	^ value > aBoolean asXPathNumber
]

{ #category : #private }
XPathNumberComparable >> greaterThanNodeSet: aNodeSet [
	^ aNodeSet anySatisfy: [:each | value > each stringValue asXPathNumber]
]

{ #category : #private }
XPathNumberComparable >> greaterThanNumber: aNumber [
	^ value > aNumber
]

{ #category : #private }
XPathNumberComparable >> greaterThanString: aString [
	^ value > aString asXPathNumber
]

{ #category : #private }
XPathNumberComparable >> lessThanBoolean: aBoolean [
	^ value < aBoolean asXPathNumber
]

{ #category : #private }
XPathNumberComparable >> lessThanNodeSet: aNodeSet [
	^ aNodeSet anySatisfy: [:each | value < each stringValue asXPathNumber]
]

{ #category : #private }
XPathNumberComparable >> lessThanNumber: aNumber [
	^ value < aNumber
]

{ #category : #private }
XPathNumberComparable >> lessThanString: aString [
	^ value < aString asXPathNumber
]

{ #category : #private }
XPathNumberComparable >> notEqualsBoolean: aBoolean [
	^ value asXPathBoolean ~= aBoolean
]

{ #category : #private }
XPathNumberComparable >> notEqualsNodeSet: aNodeSet [
	^ aNodeSet anySatisfy: [:each | value ~= each stringValue asXPathNumber]
]

{ #category : #private }
XPathNumberComparable >> notEqualsNumber: aNumber [
	^ value ~= aNumber
]

{ #category : #private }
XPathNumberComparable >> notEqualsString: aString [
	^ value ~= aString asXPathNumber
]

{ #category : #comparing }
XPathNumberComparable >> ~= aComparable [
	^ aComparable notEqualsNumber: value
]
