"
A class for storing the axis of a step while it is being parsed.
"
Class {
	#name : #XPathAxis,
	#superclass : #Object,
	#instVars : [
		'axisSpecifier',
		'isImplicit',
		'isStartOfRelativeLocationPath'
	],
	#category : #'XPath-Core-Parsers'
}

{ #category : #accessing }
XPathAxis >> axisSpecifier [
	^ axisSpecifier
]

{ #category : #accessing }
XPathAxis >> axisSpecifier: anAxisSpecifier [
	axisSpecifier := anAxisSpecifier.
	isImplicit := false.
]

{ #category : #handling }
XPathAxis >> handleWith: aHandler [
	self isStartOfRelativeLocationPath
		ifTrue: [aHandler handleStartRelativeLocationPath].
	aHandler handleAxisSpecifier: self axisSpecifier.
	self reset.
]

{ #category : #testing }
XPathAxis >> isImplicit [
	^ isImplicit
]

{ #category : #testing }
XPathAxis >> isStartOfRelativeLocationPath [
	^ isStartOfRelativeLocationPath
]

{ #category : #accessing }
XPathAxis >> isStartOfRelativeLocationPath: aBoolean [
	isStartOfRelativeLocationPath := aBoolean
]

{ #category : #accessing }
XPathAxis >> reset [
	axisSpecifier := 'child'.
	isImplicit := true.
	isStartOfRelativeLocationPath := false.
]
