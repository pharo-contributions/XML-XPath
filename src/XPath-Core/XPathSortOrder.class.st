"
Abstract class for node sort orders to keep track of the order of nodes in a node set. Instances of subclasses are immutable and shared.
"
Class {
	#name : #XPathSortOrder,
	#superclass : #Object,
	#classInstVars : [
		'instance'
	],
	#category : #'XPath-Core-DOM'
}

{ #category : #accessing }
XPathSortOrder class >> instance [
	^ instance
		ifNil: [instance := self basicNew initialize]
]

{ #category : #'instance creation' }
XPathSortOrder class >> new [
	"these classes are immutable and shared, so they are only initialized once"
	^ self instance
]

{ #category : #converting }
XPathSortOrder >> asReversedSortOrder [
	self subclassResponsibility
]

{ #category : #sorting }
XPathSortOrder >> documentOrderSort: aNodeSet [
	self subclassResponsibility
]

{ #category : #accessing }
XPathSortOrder >> firstInDocumentOrderFrom: aNodeSet [
	self subclassResponsibility
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet ancestorAxis: aNodeTestStringOrBlock [
	| copy nodeTest |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTest := aNodeTestStringOrBlock asXPathNodeTest.
	copy := (aNodeSet at: 1) ancestorAxis: nodeTest.
	2 to: aNodeSet size do: [:i |
		(aNodeSet at: i)
			ancestorAxisSelect: nodeTest
			ifNotPresentInto: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet ancestorAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	| copy nodeTest |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTest := aNodeTestStringOrBlock asXPathNodeTest.
	copy :=
		(aNodeSet at: 1)
			ancestorAxis: nodeTest
			predicates: aPredicateCollection.
	2 to: aNodeSet size do: [:i |
		((aNodeSet at: i)
			ancestorAxis: nodeTest
			predicates: aPredicateCollection)
				addAllIfNotPresentTo: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet ancestorOrSelfAxis: aNodeTestStringOrBlock [
	| copy nodeTest |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTest := aNodeTestStringOrBlock asXPathNodeTest.
	copy := (aNodeSet at: 1) ancestorOrSelfAxis: nodeTest.
	2 to: aNodeSet size do: [:i |
		(aNodeSet at: i)
			ancestorOrSelfAxisSelect: nodeTest
			ifNotPresentInto: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet ancestorOrSelfAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	| copy nodeTest |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTest := aNodeTestStringOrBlock asXPathNodeTest.
	copy :=
		(aNodeSet at: 1)
			ancestorOrSelfAxis: nodeTest
			predicates: aPredicateCollection.
	2 to: aNodeSet size do: [:i |
		((aNodeSet at: i)
			ancestorOrSelfAxis: nodeTest
			predicates: aPredicateCollection)
				addAllIfNotPresentTo: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet attributeAxis: aNodeTestStringOrBlock [
	| copy attributeAxisNodeTest |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	attributeAxisNodeTest := aNodeTestStringOrBlock asXPathAttributeAxisNodeTest.
	copy := (aNodeSet at: 1) attributeAxis: attributeAxisNodeTest.
	2 to: aNodeSet size do: [:i |
		(aNodeSet at: i)
			attributeAxisSelect: attributeAxisNodeTest
			into: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet attributeAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	| copy attributeAxisNodeTest |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	attributeAxisNodeTest := aNodeTestStringOrBlock asXPathAttributeAxisNodeTest.
	copy :=
		(aNodeSet at: 1)
			attributeAxis: attributeAxisNodeTest
			predicates: aPredicateCollection.
	2 to: aNodeSet size do: [:i |
		((aNodeSet at: i)
			attributeAxis: attributeAxisNodeTest
			predicates: aPredicateCollection)
				addAllTo: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet childAxis: aNodeTestStringOrBlock [
	| copy nodeTest |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTest := aNodeTestStringOrBlock asXPathNodeTest.
	copy := (aNodeSet at: 1) childAxis: nodeTest.
	2 to: aNodeSet size do: [:i |
		(aNodeSet at: i)
			childAxisSelect: nodeTest
			into: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet childAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	| copy nodeTest |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTest := aNodeTestStringOrBlock asXPathNodeTest.
	copy :=
		(aNodeSet at: 1)
			childAxis: nodeTest
			predicates: aPredicateCollection.
	2 to: aNodeSet size do: [:i |
		((aNodeSet at: i)
			childAxis: nodeTest
			predicates: aPredicateCollection)
				addAllTo: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet descendantAxis: aNodeTestStringOrBlock [
	| copy nodeTest |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTest := aNodeTestStringOrBlock asXPathNodeTest.
	copy := (aNodeSet at: 1) descendantAxis: nodeTest.
	2 to: aNodeSet size do: [:i |
		(aNodeSet at: i)
			descendantAxisSelect: nodeTest
			ifNotPresentInto: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet descendantAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	| copy nodeTest |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTest := aNodeTestStringOrBlock asXPathNodeTest.
	copy :=
		(aNodeSet at: 1)
			descendantAxis: nodeTest
			predicates: aPredicateCollection.
	2 to: aNodeSet size do: [:i |
		((aNodeSet at: i)
			descendantAxis: nodeTest
			predicates: aPredicateCollection)
				addAllIfNotPresentTo: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet descendantOrSelfAxis: aNodeTestStringOrBlock [
	| copy nodeTest |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTest := aNodeTestStringOrBlock asXPathNodeTest.
	copy := (aNodeSet at: 1) descendantOrSelfAxis: nodeTest.
	2 to: aNodeSet size do: [:i |
		(aNodeSet at: i)
			descendantOrSelfAxisSelect: nodeTest
			ifNotPresentInto: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet descendantOrSelfAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	| copy nodeTest |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTest := aNodeTestStringOrBlock asXPathNodeTest.
	copy :=
		(aNodeSet at: 1)
			descendantOrSelfAxis: nodeTest
			predicates: aPredicateCollection.
	2 to: aNodeSet size do: [:i |
		((aNodeSet at: i)
			descendantOrSelfAxis: nodeTest
			predicates: aPredicateCollection)
				addAllIfNotPresentTo: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet followingAxis: aNodeTestStringOrBlock [
	| copy nodeTest |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTest := aNodeTestStringOrBlock asXPathNodeTest.
	copy := (aNodeSet at: 1) followingAxis: nodeTest.
	2 to: aNodeSet size do: [:i |
		(aNodeSet at: i)
			followingAxisSelect: nodeTest
			ifNotPresentInto: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet followingAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	| copy nodeTest |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTest := aNodeTestStringOrBlock asXPathNodeTest.
	copy :=
		(aNodeSet at: 1)
			followingAxis: nodeTest
			predicates: aPredicateCollection.
	2 to: aNodeSet size do: [:i |
		((aNodeSet at: i)
			followingAxis: nodeTest
			predicates: aPredicateCollection)
				addAllIfNotPresentTo: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet followingSiblingAxis: aNodeTestStringOrBlock [
	| copy nodeTest |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTest := aNodeTestStringOrBlock asXPathNodeTest.
	copy := (aNodeSet at: 1) followingSiblingAxis: nodeTest.
	2 to: aNodeSet size do: [:i |
		(aNodeSet at: i)
			followingSiblingAxisSelect: nodeTest
			ifNotPresentInto: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet followingSiblingAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	| copy nodeTest |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTest := aNodeTestStringOrBlock asXPathNodeTest.
	copy :=
		(aNodeSet at: 1)
			followingSiblingAxis: nodeTest
			predicates: aPredicateCollection.
	2 to: aNodeSet size do: [:i |
		((aNodeSet at: i)
			followingSiblingAxis: nodeTest
			predicates: aPredicateCollection)
				addAllIfNotPresentTo: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet namespaceAxis: aNodeTestStringOrBlock [
	| copy namespaceAxisNodeTest |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	namespaceAxisNodeTest := aNodeTestStringOrBlock asXPathNamespaceAxisNodeTest.
	copy := (aNodeSet at: 1) namespaceAxis: namespaceAxisNodeTest.
	2 to: aNodeSet size do: [:i |
		(aNodeSet at: i)
			namespaceAxisSelect: namespaceAxisNodeTest
			into: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet namespaceAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	| copy namespaceAxisNodeTest |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	namespaceAxisNodeTest := aNodeTestStringOrBlock asXPathNamespaceAxisNodeTest.
	copy :=
		(aNodeSet at: 1)
			namespaceAxis: namespaceAxisNodeTest
			predicates: aPredicateCollection.
	2 to: aNodeSet size do: [:i |
		((aNodeSet at: i)
			namespaceAxis: namespaceAxisNodeTest
			predicates: aPredicateCollection)
				addAllTo: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet parentAxis: aNodeTestStringOrBlock [
	| copy nodeTest |

	copy := aNodeSet copyEmpty.
	aNodeSet size > 0
		ifFalse: [^ copy].

	nodeTest := aNodeTestStringOrBlock asXPathNodeTest.
	1 to: aNodeSet size do: [:i |
		(aNodeSet at: i)
			parentAxisSelect: nodeTest
			ifNotPresentInto: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet parentAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	^ (self
		on: aNodeSet
		parentAxis: aNodeTestStringOrBlock)
			filterEachInSeparateContextWithAll: aPredicateCollection
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet precedingAxis: aNodeTestStringOrBlock [
	| copy nodeTest |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTest := aNodeTestStringOrBlock asXPathNodeTest.
	copy := (aNodeSet at: 1) precedingAxis: nodeTest.
	2 to: aNodeSet size do: [:i |
		(aNodeSet at: i)
			precedingAxisSelect: nodeTest
			ifNotPresentInto: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet precedingAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	| copy nodeTest |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTest := aNodeTestStringOrBlock asXPathNodeTest.
	copy :=
		(aNodeSet at: 1)
			precedingAxis: nodeTest
			predicates: aPredicateCollection.
	2 to: aNodeSet size do: [:i |
		((aNodeSet at: i)
			precedingAxis: nodeTest
			predicates: aPredicateCollection)
				addAllIfNotPresentTo: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet precedingSiblingAxis: aNodeTestStringOrBlock [
	| copy nodeTest |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTest := aNodeTestStringOrBlock asXPathNodeTest.
	copy := (aNodeSet at: 1) precedingSiblingAxis: nodeTest.
	2 to: aNodeSet size do: [:i |
		(aNodeSet at: i)
			precedingSiblingAxisSelect: nodeTest
			ifNotPresentInto: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet precedingSiblingAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	| copy nodeTest |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTest := aNodeTestStringOrBlock asXPathNodeTest.
	copy :=
		(aNodeSet at: 1)
			precedingSiblingAxis: nodeTest
			predicates: aPredicateCollection.
	2 to: aNodeSet size do: [:i |
		((aNodeSet at: i)
			precedingSiblingAxis: nodeTest
			predicates: aPredicateCollection)
				addAllIfNotPresentTo: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet selfAxis: aNodeTestStringOrBlock [
	| copy nodeTest |

	copy := aNodeSet copyEmpty.
	aNodeSet size > 0
		ifFalse: [^ copy].

	nodeTest := aNodeTestStringOrBlock asXPathNodeTest.
	1 to: aNodeSet size do: [:i |
		(aNodeSet at: i)
			selfAxisSelect: nodeTest
			into: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet selfAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	^ (self
		on: aNodeSet
		selfAxis: aNodeTestStringOrBlock)
			filterEachInSeparateContextWithAll: aPredicateCollection.
]
