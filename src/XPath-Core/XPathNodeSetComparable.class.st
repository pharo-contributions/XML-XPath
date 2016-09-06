"
A class for wrapping XPath node sets to polymorphically implement XPath comparison operators.
"
Class {
	#name : #XPathNodeSetComparable,
	#superclass : #XPathComparable,
	#category : #'XPath-Core-Compilation'
}

{ #category : #comparing }
XPathNodeSetComparable >> != aComparable [
	^ aComparable notEqualsNodeSet: value
]

{ #category : #comparing }
XPathNodeSetComparable >> < aComparable [
	^ aComparable greaterThanNodeSet: value
]

{ #category : #comparing }
XPathNodeSetComparable >> <= aComparable [
	^ (aComparable greaterThanNodeSet: value)
		or: [aComparable equalsNodeSet: value]
]

{ #category : #comparing }
XPathNodeSetComparable >> = aComparable [
	^ aComparable equalsNodeSet: value
]

{ #category : #comparing }
XPathNodeSetComparable >> > aComparable [
	^ aComparable lessThanNodeSet: value
]

{ #category : #comparing }
XPathNodeSetComparable >> >= aComparable [
	^ (aComparable lessThanNodeSet: value)
		or: [aComparable equalsNodeSet: value]
]

{ #category : #private }
XPathNodeSetComparable >> equalsBoolean: aBoolean [
	^ value asXPathBoolean = aBoolean
]

{ #category : #private }
XPathNodeSetComparable >> equalsNodeSet: aNodeSet [
	| stringValues |

	stringValues := Set new: value size.
	value do: [:each | stringValues add: each stringValue].
	^ aNodeSet anySatisfy: [:node | stringValues includes: node stringValue].
]

{ #category : #private }
XPathNodeSetComparable >> equalsNumber: aNumber [
	^ value anySatisfy: [:each | each stringValue asXPathNumber = aNumber]
]

{ #category : #private }
XPathNodeSetComparable >> equalsString: aString [
	^ value anySatisfy: [:each | each stringValue = aString]
]

{ #category : #private }
XPathNodeSetComparable >> greaterThanBoolean: aBoolean [
	^ value asXPathBoolean asXPathNumber > aBoolean asXPathNumber
]

{ #category : #private }
XPathNodeSetComparable >> greaterThanNodeSet: aNodeSet [
	| least |

	aNodeSet do: [:each | | number |
		number := each stringValue asXPathNumber.
		(least isNil
			or: [number < least])
			ifTrue: [least := number]].
	^ least notNil
		and: [value anySatisfy: [:each | each stringValue asXPathNumber > least]].
]

{ #category : #private }
XPathNodeSetComparable >> greaterThanNumber: aNumber [
	^ value anySatisfy: [:each | each stringValue asXPathNumber > aNumber]
]

{ #category : #private }
XPathNodeSetComparable >> greaterThanString: aString [
	| number |

	number := aString asXPathNumber.
	^ value anySatisfy: [:each | each stringValue asXPathNumber > number]
]

{ #category : #private }
XPathNodeSetComparable >> lessThanBoolean: aBoolean [
	^ value asXPathBoolean asXPathNumber < aBoolean asXPathNumber
]

{ #category : #private }
XPathNodeSetComparable >> lessThanNodeSet: aNodeSet [
	| greatest |

	aNodeSet do: [:each | | number |
		number := each stringValue asXPathNumber.
		(greatest isNil
			or: [number > greatest])
			ifTrue: [greatest := number]].
	^ greatest notNil
		and: [value anySatisfy: [:each | each stringValue asXPathNumber < greatest]].
]

{ #category : #private }
XPathNodeSetComparable >> lessThanNumber: aNumber [
	^ value anySatisfy: [:each | each stringValue asXPathNumber < aNumber]
]

{ #category : #private }
XPathNodeSetComparable >> lessThanString: aString [
	| number |

	number := aString asXPathNumber.
	^ value anySatisfy: [:each | each asXPathNumber < number]
]

{ #category : #private }
XPathNodeSetComparable >> notEqualsBoolean: aBoolean [
	^ value asXPathBoolean ~= aBoolean
]

{ #category : #private }
XPathNodeSetComparable >> notEqualsNodeSet: aNodeSet [
	| stringValues |

	"should return true according to spec when aNodeSet and value each have at
	least one node that don't have the same string-values"
	stringValues := value collect: [:each | each stringValue].
	aNodeSet do: [:node | | stringValue |
		stringValue := node stringValue.
		stringValues do: [:each |
			each = stringValue
				ifFalse: [^ true]]].
	^ false.
]

{ #category : #private }
XPathNodeSetComparable >> notEqualsNumber: aNumber [
	^ value anySatisfy: [:each | each stringValue asXPathNumber ~= aNumber]
]

{ #category : #private }
XPathNodeSetComparable >> notEqualsString: aString [
	^ value anySatisfy: [:each | each stringValue ~= aString]
]
