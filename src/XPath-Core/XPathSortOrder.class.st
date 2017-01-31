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
	| copy nodeTestBlock |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTestBlock := aNodeTestStringOrBlock asXPathNodeTestBlock.
	copy := (aNodeSet at: 1) ancestorAxis: nodeTestBlock.
	2 to: aNodeSet size do: [:i |
		(aNodeSet at: i)
			ancestorAxisSelect: nodeTestBlock
			ifNotPresentInto: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet ancestorAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	| copy nodeTestBlock |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTestBlock := aNodeTestStringOrBlock asXPathNodeTestBlock.
	copy :=
		(aNodeSet at: 1)
			ancestorAxis: nodeTestBlock
			predicates: aPredicateCollection.
	2 to: aNodeSet size do: [:i |
		((aNodeSet at: i)
			ancestorAxis: nodeTestBlock
			predicates: aPredicateCollection)
				addAllIfNotPresentTo: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet ancestorOrSelfAxis: aNodeTestStringOrBlock [
	| copy nodeTestBlock |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTestBlock := aNodeTestStringOrBlock asXPathNodeTestBlock.
	copy := (aNodeSet at: 1) ancestorOrSelfAxis: nodeTestBlock.
	2 to: aNodeSet size do: [:i |
		(aNodeSet at: i)
			ancestorOrSelfAxisSelect: nodeTestBlock
			ifNotPresentInto: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet ancestorOrSelfAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	| copy nodeTestBlock |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTestBlock := aNodeTestStringOrBlock asXPathNodeTestBlock.
	copy :=
		(aNodeSet at: 1)
			ancestorOrSelfAxis: nodeTestBlock
			predicates: aPredicateCollection.
	2 to: aNodeSet size do: [:i |
		((aNodeSet at: i)
			ancestorOrSelfAxis: nodeTestBlock
			predicates: aPredicateCollection)
				addAllIfNotPresentTo: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet attributeAxis: aNodeTestStringOrBlock [
	| copy nodeTestBlock |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTestBlock := aNodeTestStringOrBlock asXPathAttributeNodeTestBlock.
	copy := (aNodeSet at: 1) attributeAxis: nodeTestBlock.
	2 to: aNodeSet size do: [:i |
		(aNodeSet at: i)
			attributeAxisSelect: nodeTestBlock
			into: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet attributeAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	| copy nodeTestBlock |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTestBlock := aNodeTestStringOrBlock asXPathAttributeNodeTestBlock.
	copy :=
		(aNodeSet at: 1)
			attributeAxis: nodeTestBlock
			predicates: aPredicateCollection.
	2 to: aNodeSet size do: [:i |
		((aNodeSet at: i)
			attributeAxis: nodeTestBlock
			predicates: aPredicateCollection)
				addAllTo: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet childAxis: aNodeTestStringOrBlock [
	| copy nodeTestBlock |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTestBlock := aNodeTestStringOrBlock asXPathNodeTestBlock.
	copy := (aNodeSet at: 1) childAxis: nodeTestBlock.
	2 to: aNodeSet size do: [:i |
		(aNodeSet at: i)
			childAxisSelect: nodeTestBlock
			into: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet childAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	| copy nodeTestBlock |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTestBlock := aNodeTestStringOrBlock asXPathNodeTestBlock.
	copy :=
		(aNodeSet at: 1)
			childAxis: nodeTestBlock
			predicates: aPredicateCollection.
	2 to: aNodeSet size do: [:i |
		((aNodeSet at: i)
			childAxis: nodeTestBlock
			predicates: aPredicateCollection)
				addAllTo: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet descendantAxis: aNodeTestStringOrBlock [
	| copy nodeTestBlock |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTestBlock := aNodeTestStringOrBlock asXPathNodeTestBlock.
	copy := (aNodeSet at: 1) descendantAxis: nodeTestBlock.
	2 to: aNodeSet size do: [:i |
		(aNodeSet at: i)
			descendantAxisSelect: nodeTestBlock
			ifNotPresentInto: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet descendantAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	| copy nodeTestBlock |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTestBlock := aNodeTestStringOrBlock asXPathNodeTestBlock.
	copy :=
		(aNodeSet at: 1)
			descendantAxis: nodeTestBlock
			predicates: aPredicateCollection.
	2 to: aNodeSet size do: [:i |
		((aNodeSet at: i)
			descendantAxis: nodeTestBlock
			predicates: aPredicateCollection)
				addAllIfNotPresentTo: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet descendantOrSelfAxis: aNodeTestStringOrBlock [
	| copy nodeTestBlock |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTestBlock := aNodeTestStringOrBlock asXPathNodeTestBlock.
	copy := (aNodeSet at: 1) descendantOrSelfAxis: nodeTestBlock.
	2 to: aNodeSet size do: [:i |
		(aNodeSet at: i)
			descendantOrSelfAxisSelect: nodeTestBlock
			ifNotPresentInto: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet descendantOrSelfAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	| copy nodeTestBlock |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTestBlock := aNodeTestStringOrBlock asXPathNodeTestBlock.
	copy :=
		(aNodeSet at: 1)
			descendantOrSelfAxis: nodeTestBlock
			predicates: aPredicateCollection.
	2 to: aNodeSet size do: [:i |
		((aNodeSet at: i)
			descendantOrSelfAxis: nodeTestBlock
			predicates: aPredicateCollection)
				addAllIfNotPresentTo: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet followingAxis: aNodeTestStringOrBlock [
	| copy nodeTestBlock |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTestBlock := aNodeTestStringOrBlock asXPathNodeTestBlock.
	copy := (aNodeSet at: 1) followingAxis: nodeTestBlock.
	2 to: aNodeSet size do: [:i |
		(aNodeSet at: i)
			followingAxisSelect: nodeTestBlock
			ifNotPresentInto: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet followingAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	| copy nodeTestBlock |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTestBlock := aNodeTestStringOrBlock asXPathNodeTestBlock.
	copy :=
		(aNodeSet at: 1)
			followingAxis: nodeTestBlock
			predicates: aPredicateCollection.
	2 to: aNodeSet size do: [:i |
		((aNodeSet at: i)
			followingAxis: nodeTestBlock
			predicates: aPredicateCollection)
				addAllIfNotPresentTo: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet followingSiblingAxis: aNodeTestStringOrBlock [
	| copy nodeTestBlock |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTestBlock := aNodeTestStringOrBlock asXPathNodeTestBlock.
	copy := (aNodeSet at: 1) followingSiblingAxis: nodeTestBlock.
	2 to: aNodeSet size do: [:i |
		(aNodeSet at: i)
			followingSiblingAxisSelect: nodeTestBlock
			ifNotPresentInto: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet followingSiblingAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	| copy nodeTestBlock |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTestBlock := aNodeTestStringOrBlock asXPathNodeTestBlock.
	copy :=
		(aNodeSet at: 1)
			followingSiblingAxis: nodeTestBlock
			predicates: aPredicateCollection.
	2 to: aNodeSet size do: [:i |
		((aNodeSet at: i)
			followingSiblingAxis: nodeTestBlock
			predicates: aPredicateCollection)
				addAllIfNotPresentTo: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet namespaceAxis: aNodeTestStringOrBlock [
	| copy nodeTestBlock |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTestBlock := aNodeTestStringOrBlock asXPathNamespaceNodeTestBlock.
	copy := (aNodeSet at: 1) namespaceAxis: nodeTestBlock.
	2 to: aNodeSet size do: [:i |
		(aNodeSet at: i)
			namespaceAxisSelect: nodeTestBlock
			into: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet namespaceAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	| copy nodeTestBlock |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTestBlock := aNodeTestStringOrBlock asXPathNamespaceNodeTestBlock.
	copy :=
		(aNodeSet at: 1)
			namespaceAxis: nodeTestBlock
			predicates: aPredicateCollection.
	2 to: aNodeSet size do: [:i |
		((aNodeSet at: i)
			namespaceAxis: nodeTestBlock
			predicates: aPredicateCollection)
				addAllTo: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet parentAxis: aNodeTestStringOrBlock [
	| copy nodeTestBlock |

	copy := aNodeSet copyEmpty.
	aNodeSet size > 0
		ifFalse: [^ copy].

	nodeTestBlock := aNodeTestStringOrBlock asXPathNodeTestBlock.
	1 to: aNodeSet size do: [:i |
		(aNodeSet at: i)
			parentAxisSelect: nodeTestBlock
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
	| copy nodeTestBlock |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTestBlock := aNodeTestStringOrBlock asXPathNodeTestBlock.
	copy := (aNodeSet at: 1) precedingAxis: nodeTestBlock.
	2 to: aNodeSet size do: [:i |
		(aNodeSet at: i)
			precedingAxisSelect: nodeTestBlock
			ifNotPresentInto: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet precedingAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	| copy nodeTestBlock |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTestBlock := aNodeTestStringOrBlock asXPathNodeTestBlock.
	copy :=
		(aNodeSet at: 1)
			precedingAxis: nodeTestBlock
			predicates: aPredicateCollection.
	2 to: aNodeSet size do: [:i |
		((aNodeSet at: i)
			precedingAxis: nodeTestBlock
			predicates: aPredicateCollection)
				addAllIfNotPresentTo: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet precedingSiblingAxis: aNodeTestStringOrBlock [
	| copy nodeTestBlock |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTestBlock := aNodeTestStringOrBlock asXPathNodeTestBlock.
	copy := (aNodeSet at: 1) precedingSiblingAxis: nodeTestBlock.
	2 to: aNodeSet size do: [:i |
		(aNodeSet at: i)
			precedingSiblingAxisSelect: nodeTestBlock
			ifNotPresentInto: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet precedingSiblingAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	| copy nodeTestBlock |

	aNodeSet size > 0
		ifFalse: [^ aNodeSet copyEmpty].

	nodeTestBlock := aNodeTestStringOrBlock asXPathNodeTestBlock.
	copy :=
		(aNodeSet at: 1)
			precedingSiblingAxis: nodeTestBlock
			predicates: aPredicateCollection.
	2 to: aNodeSet size do: [:i |
		((aNodeSet at: i)
			precedingSiblingAxis: nodeTestBlock
			predicates: aPredicateCollection)
				addAllIfNotPresentTo: copy].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet selfAxis: aNodeTestStringOrBlock [
	| copy nodeTestBlock |

	copy := aNodeSet copyEmpty.
	aNodeSet size > 0
		ifFalse: [^ copy].

	nodeTestBlock := aNodeTestStringOrBlock asXPathNodeTestBlock.
	1 to: aNodeSet size do: [:i |
		(aNodeSet at: i)
			selfAxisSelect: nodeTestBlock
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
