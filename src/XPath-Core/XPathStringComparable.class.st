"
A class for wrapping XPath strings to polymorphically implement XPath comparison operators.
"
Class {
	#name : #XPathStringComparable,
	#superclass : #XPathComparable,
	#category : #'XPath-Core-Compilation'
}

{ #category : #comparing }
XPathStringComparable >> < aComparable [
	^ aComparable greaterThanString: value
]

{ #category : #comparing }
XPathStringComparable >> <= aComparable [
	^ (aComparable greaterThanString: value)
		or: [aComparable equalsString: value]
]

{ #category : #comparing }
XPathStringComparable >> = aComparable [
	^ aComparable equalsString: value
]

{ #category : #comparing }
XPathStringComparable >> > aComparable [
	^ aComparable lessThanString: value
]

{ #category : #comparing }
XPathStringComparable >> >= aComparable [
	^ (aComparable lessThanString: value)
		or: [aComparable equalsString: value]
]

{ #category : #private }
XPathStringComparable >> equalsBoolean: aBoolean [
	^ value asXPathBoolean = aBoolean
]

{ #category : #private }
XPathStringComparable >> equalsNodeSet: aNodeSet [
	^ aNodeSet anySatisfy: [:each | value = each stringValue]
]

{ #category : #private }
XPathStringComparable >> equalsNumber: aNumber [
	^ value asXPathNumber = aNumber
]

{ #category : #private }
XPathStringComparable >> equalsString: aString [
	^ value = aString
]

{ #category : #private }
XPathStringComparable >> greaterThanBoolean: aBoolean [
	^ value asXPathNumber > aBoolean asXPathNumber
]

{ #category : #private }
XPathStringComparable >> greaterThanNodeSet: aNodeSet [
	| number |
	
	number := value asXPathNumber.
	^ aNodeSet anySatisfy: [:each | number > each stringValue asXPathNumber].
]

{ #category : #private }
XPathStringComparable >> greaterThanNumber: aNumber [
	^ value asXPathNumber > aNumber
]

{ #category : #private }
XPathStringComparable >> greaterThanString: aString [
	^ value asXPathNumber > aString asXPathNumber
]

{ #category : #private }
XPathStringComparable >> lessThanBoolean: aBoolean [
	^ value asXPathNumber < aBoolean asXPathNumber
]

{ #category : #private }
XPathStringComparable >> lessThanNodeSet: aNodeSet [
	| number |
	
	number := value asXPathNumber.
	^ aNodeSet anySatisfy: [:each | number < each stringValue asXPathNumber].
]

{ #category : #private }
XPathStringComparable >> lessThanNumber: aNumber [
	^ value asXPathNumber < aNumber
]

{ #category : #private }
XPathStringComparable >> lessThanString: aString [
	^ value asXPathNumber < aString asXPathNumber
]

{ #category : #private }
XPathStringComparable >> notEqualsBoolean: aBoolean [
	^ value asXPathBoolean ~= aBoolean
]

{ #category : #private }
XPathStringComparable >> notEqualsNodeSet: aNodeSet [
	^ aNodeSet anySatisfy: [:each | value ~= each stringValue]
]

{ #category : #private }
XPathStringComparable >> notEqualsNumber: aNumber [
	^ value asXPathNumber ~= aNumber
]

{ #category : #private }
XPathStringComparable >> notEqualsString: aString [
	^ value ~= aString
]

{ #category : #comparing }
XPathStringComparable >> ~= aComparable [
	^ aComparable notEqualsString: value
]
