"
An abstract class for wrapping XPath types to polymorphically implement XPath comparison operators.
"
Class {
	#name : #XPathComparable,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'XPath-Core-Compilation'
}

{ #category : #'instance creation' }
XPathComparable class >> value: aValue [
	^ self new setValue: aValue
]

{ #category : #comparing }
XPathComparable >> < aComparable [
	self subclassResponsibility
]

{ #category : #comparing }
XPathComparable >> <= aComparable [
	self subclassResponsibility
]

{ #category : #comparing }
XPathComparable >> = aComparable [
	self subclassResponsibility
]

{ #category : #comparing }
XPathComparable >> > aComparable [
	self subclassResponsibility
]

{ #category : #comparing }
XPathComparable >> >= aComparable [
	self subclassResponsibility
]

{ #category : #private }
XPathComparable >> equalsBoolean: aBoolean [
	self subclassResponsibility
]

{ #category : #private }
XPathComparable >> equalsNodeSet: aNodeSet [
	self subclassResponsibility
]

{ #category : #private }
XPathComparable >> equalsNumber: aNumber [
	self subclassResponsibility
]

{ #category : #private }
XPathComparable >> equalsString: aString [
	self subclassResponsibility
]

{ #category : #private }
XPathComparable >> greaterThanBoolean: aBoolean [
	self subclassResponsibility
]

{ #category : #private }
XPathComparable >> greaterThanNodeSet: aNodeSet [
	self subclassResponsibility
]

{ #category : #private }
XPathComparable >> greaterThanNumber: aNumber [
	self subclassResponsibility
]

{ #category : #private }
XPathComparable >> greaterThanString: aString [
	self subclassResponsibility
]

{ #category : #private }
XPathComparable >> lessThanBoolean: aBoolean [
	self subclassResponsibility
]

{ #category : #private }
XPathComparable >> lessThanNodeSet: aNodeSet [
	self subclassResponsibility
]

{ #category : #private }
XPathComparable >> lessThanNumber: aNumber [
	self subclassResponsibility
]

{ #category : #private }
XPathComparable >> lessThanString: aString [
	self subclassResponsibility
]

{ #category : #private }
XPathComparable >> notEqualsBoolean: aBoolean [
	self subclassResponsibility
]

{ #category : #private }
XPathComparable >> notEqualsNodeSet: aNodeSet [
	self subclassResponsibility
]

{ #category : #private }
XPathComparable >> notEqualsNumber: aNumber [
	self subclassResponsibility
]

{ #category : #private }
XPathComparable >> notEqualsString: aString [
	self subclassResponsibility
]

{ #category : #printing }
XPathComparable >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		print: value;
		nextPut: $).
]

{ #category : #initialization }
XPathComparable >> setValue: anObject [
	value := anObject
]

{ #category : #comparing }
XPathComparable >> ~= aComparable [
	self subclassResponsibility
]
