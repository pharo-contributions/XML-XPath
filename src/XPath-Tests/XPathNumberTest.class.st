Class {
	#name : #XPathNumberTest,
	#superclass : #TestCase,
	#category : #'XPath-Tests'
}

{ #category : #tests }
XPathNumberTest >> testAsXPathBoolean [
	self
		assert: 1 asXPathBoolean;
		assert: -1 asXPathBoolean;
		assert: Float infinity asXPathBoolean;
		"avoid #negativeInfinity for portability"
		assert: Float infinity negated asXPathBoolean;
		deny: 0.0 asXPathBoolean;
		deny: -0.0 asXPathBoolean;
		deny: Float nan asXPathBoolean
]

{ #category : #tests }
XPathNumberTest >> testAsXPathNodeSet [
	self
		should: [1.0 asXPathNodeSet]
		raise: XPathTypeException
]

{ #category : #tests }
XPathNumberTest >> testAsXPathNumber [
	| number |

	number := 1.0.
	self assert: number asXPathNumber == number.

	"should convert to float"
	number := 1.
	self
		assert: number asXPathNumber = number;
		assert: number asXPathNumber isFloat.
]

{ #category : #tests }
XPathNumberTest >> testAsXPathString [
	self
		assert: 1 asXPathString = '1';
		assert: 1.0 asXPathString = '1';
		assert: Float infinity asXPathString = 'Infinity';
		"avoid #negativeInfinity for portability"
		assert: Float infinity negated asXPathString = '-Infinity';
		assert: Float nan asXPathString = 'NaN';
		assert: 0.0 asXPathString = '0';
		assert: -0.0 asXPathString = '0'
]

{ #category : #tests }
XPathNumberTest >> testIsXPathNegativeZero [
	self
		deny: 0 isXPathNegativeZero;
		deny: 0.0 isXPathNegativeZero;
		assert: -0.0 isXPathNegativeZero
]

{ #category : #tests }
XPathNumberTest >> testIsXPathPositiveZero [
	self
		assert: 0 isXPathPositiveZero;
		assert: 0.0 isXPathPositiveZero;
		deny: -0.0 isXPathPositiveZero
]
