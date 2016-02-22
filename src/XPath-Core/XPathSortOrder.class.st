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

{ #category : #'instance creation' }
XPathSortOrder class >> new [
	"these classes are immutable and shared, so they are only initialized once"
	^ instance ifNil: [instance := self basicNew initialize]
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
XPathSortOrder >> on: aNodeSet ancestorAxis: aStringOrBlockOrNodeTestWithFilters [
	| copy |

	aNodeSet isEmpty
		ifTrue: [^ aNodeSet copyEmpty].

	copy := aNodeSet first ancestorAxis: aStringOrBlockOrNodeTestWithFilters.
	aStringOrBlockOrNodeTestWithFilters hasXPathNodeSetFilters
		ifTrue: [
			2 to: aNodeSet size do: [:i |
				((aNodeSet at: i) ancestorAxis: aStringOrBlockOrNodeTestWithFilters)
					addAllIfNotPresentTo: copy]]
		ifFalse: [| nodeTestBlock |
			nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asXPathNodeTestBlock.
			2 to: aNodeSet size do: [:i |
				(aNodeSet at: i)
					ancestorAxisSelect: nodeTestBlock
					ifNotPresentInto: copy]].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet ancestorOrSelfAxis: aStringOrBlockOrNodeTestWithFilters [
	| copy |

	aNodeSet isEmpty
		ifTrue: [^ aNodeSet copyEmpty].

	copy := aNodeSet first ancestorOrSelfAxis: aStringOrBlockOrNodeTestWithFilters.
	aStringOrBlockOrNodeTestWithFilters hasXPathNodeSetFilters
		ifTrue: [
			2 to: aNodeSet size do: [:i |
				((aNodeSet at: i) ancestorOrSelfAxis: aStringOrBlockOrNodeTestWithFilters)
					addAllIfNotPresentTo: copy]]
		ifFalse: [| nodeTestBlock |
			nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asXPathNodeTestBlock.
			2 to: aNodeSet size do: [:i |
				(aNodeSet at: i)
					ancestorOrSelfAxisSelect: nodeTestBlock
					ifNotPresentInto: copy]].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet attributeAxis: aStringOrBlockOrNodeTestWithFilters [
	| copy |

	aNodeSet isEmpty
		ifTrue: [^ aNodeSet copyEmpty].

	copy := aNodeSet first attributeAxis: aStringOrBlockOrNodeTestWithFilters.
	aStringOrBlockOrNodeTestWithFilters hasXPathNodeSetFilters
		ifTrue: [
			2 to: aNodeSet size do: [:i |
				((aNodeSet at: i) attributeAxis: aStringOrBlockOrNodeTestWithFilters)
					addAllTo: copy]]
		ifFalse: [| nodeTestBlock |
			nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asXPathNodeTestBlock.
			2 to: aNodeSet size do: [:i |
				(aNodeSet at: i)
					attributeAxisSelect: nodeTestBlock
					into: copy]].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet childAxis: aStringOrBlockOrNodeTestWithFilters [
	| copy |

	aNodeSet isEmpty
		ifTrue: [^ aNodeSet copyEmpty].

	copy := aNodeSet first childAxis: aStringOrBlockOrNodeTestWithFilters.
	aStringOrBlockOrNodeTestWithFilters hasXPathNodeSetFilters
		ifTrue: [
			2 to: aNodeSet size do: [:i |
				((aNodeSet at: i) childAxis: aStringOrBlockOrNodeTestWithFilters)
					addAllTo: copy]]
		ifFalse: [| nodeTestBlock |
			nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asXPathNodeTestBlock.
			2 to: aNodeSet size do: [:i |
				(aNodeSet at: i)
					childAxisSelect: nodeTestBlock
					into: copy]].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet descendantAxis: aStringOrBlockOrNodeTestWithFilters [
	| copy |

	aNodeSet isEmpty
		ifTrue: [^ aNodeSet copyEmpty].

	copy := aNodeSet first descendantAxis: aStringOrBlockOrNodeTestWithFilters.
	aStringOrBlockOrNodeTestWithFilters hasXPathNodeSetFilters
		ifTrue: [
			2 to: aNodeSet size do: [:i |
				((aNodeSet at: i) descendantAxis: aStringOrBlockOrNodeTestWithFilters)
					addAllIfNotPresentTo: copy]]
		ifFalse: [| nodeTestBlock |
			nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asXPathNodeTestBlock.
			2 to: aNodeSet size do: [:i |
				(aNodeSet at: i)
					descendantAxisSelect: nodeTestBlock
					ifNotPresentInto: copy]].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet descendantOrSelfAxis: aStringOrBlockOrNodeTestWithFilters [
	| copy |

	aNodeSet isEmpty
		ifTrue: [^ aNodeSet copyEmpty].

	copy := aNodeSet first descendantOrSelfAxis: aStringOrBlockOrNodeTestWithFilters.
	aStringOrBlockOrNodeTestWithFilters hasXPathNodeSetFilters
		ifTrue: [
			2 to: aNodeSet size do: [:i |
				((aNodeSet at: i) descendantOrSelfAxis: aStringOrBlockOrNodeTestWithFilters)
					addAllIfNotPresentTo: copy]]
		ifFalse: [| nodeTestBlock |
			nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asXPathNodeTestBlock.
			2 to: aNodeSet size do: [:i |
				(aNodeSet at: i)
					descendantOrSelfAxisSelect: nodeTestBlock
					ifNotPresentInto: copy]].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet followingAxis: aStringOrBlockOrNodeTestWithFilters [
	| copy |

	aNodeSet isEmpty
		ifTrue: [^ aNodeSet copyEmpty].

	copy := aNodeSet first followingAxis: aStringOrBlockOrNodeTestWithFilters.
	aStringOrBlockOrNodeTestWithFilters hasXPathNodeSetFilters
		ifTrue: [
			2 to: aNodeSet size do: [:i |
				((aNodeSet at: i) followingAxis: aStringOrBlockOrNodeTestWithFilters)
					addAllIfNotPresentTo: copy]]
		ifFalse: [| nodeTestBlock |
			nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asXPathNodeTestBlock.
			2 to: aNodeSet size do: [:i |
				(aNodeSet at: i)
					followingAxisSelect: nodeTestBlock
					ifNotPresentInto: copy]].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet followingSiblingAxis: aStringOrBlockOrNodeTestWithFilters [
	| copy |

	aNodeSet isEmpty
		ifTrue: [^ aNodeSet copyEmpty].

	copy := aNodeSet first followingSiblingAxis: aStringOrBlockOrNodeTestWithFilters.
	aStringOrBlockOrNodeTestWithFilters hasXPathNodeSetFilters
		ifTrue: [
			2 to: aNodeSet size do: [:i |
				((aNodeSet at: i) followingSiblingAxis: aStringOrBlockOrNodeTestWithFilters)
					addAllIfNotPresentTo: copy]]
		ifFalse: [| nodeTestBlock |
			nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asXPathNodeTestBlock.
			2 to: aNodeSet size do: [:i |
				(aNodeSet at: i)
					followingSiblingAxisSelect: nodeTestBlock
					ifNotPresentInto: copy]].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet namespaceAxis: aStringOrBlockOrNodeTestWithFilters [
	| copy |

	aNodeSet isEmpty
		ifTrue: [^ aNodeSet copyEmpty].

	copy := aNodeSet first namespaceAxis: aStringOrBlockOrNodeTestWithFilters.
	aStringOrBlockOrNodeTestWithFilters hasXPathNodeSetFilters
		ifTrue: [
			2 to: aNodeSet size do: [:i |
				((aNodeSet at: i) namespaceAxis: aStringOrBlockOrNodeTestWithFilters)
					addAllTo: copy]]
		ifFalse: [| nodeTestBlock |
			nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asXPathNodeTestBlock.
			2 to: aNodeSet size do: [:i |
				(aNodeSet at: i)
					namespaceAxisSelect: nodeTestBlock
					into: copy]].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet parentAxis: aStringOrBlockOrNodeTestWithFilters [
	| copy nodeTestBlock |

	copy := aNodeSet copyEmpty.
	aNodeSet isEmpty
		ifTrue: [^ copy].

	nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asXPathNodeTestBlock.
	1 to: aNodeSet size do: [:i |
		(aNodeSet at: i)
			parentAxisSelect: nodeTestBlock
			ifNotPresentInto: copy].
	^ copy filterEachInSeparateContextWithAll:
		aStringOrBlockOrNodeTestWithFilters asXPathNodeSetFilters.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet precedingAxis: aStringOrBlockOrNodeTestWithFilters [
	| copy |

	aNodeSet isEmpty
		ifTrue: [^ aNodeSet copyEmpty].

	copy := aNodeSet first precedingAxis: aStringOrBlockOrNodeTestWithFilters.
	aStringOrBlockOrNodeTestWithFilters hasXPathNodeSetFilters
		ifTrue: [
			2 to: aNodeSet size do: [:i |
				((aNodeSet at: i) precedingAxis: aStringOrBlockOrNodeTestWithFilters)
					addAllIfNotPresentTo: copy]]
		ifFalse: [| nodeTestBlock |
			nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asXPathNodeTestBlock.
			2 to: aNodeSet size do: [:i |
				(aNodeSet at: i)
					precedingAxisSelect: nodeTestBlock
					ifNotPresentInto: copy]].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet precedingSiblingAxis: aStringOrBlockOrNodeTestWithFilters [
	| copy |

	aNodeSet isEmpty
		ifTrue: [^ aNodeSet copyEmpty].

	copy := aNodeSet first precedingSiblingAxis: aStringOrBlockOrNodeTestWithFilters.
	aStringOrBlockOrNodeTestWithFilters hasXPathNodeSetFilters
		ifTrue: [
			2 to: aNodeSet size do: [:i |
				((aNodeSet at: i) precedingSiblingAxis: aStringOrBlockOrNodeTestWithFilters)
					addAllIfNotPresentTo: copy]]
		ifFalse: [| nodeTestBlock |
			nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asXPathNodeTestBlock.
			2 to: aNodeSet size do: [:i |
				(aNodeSet at: i)
					precedingSiblingAxisSelect: nodeTestBlock
					ifNotPresentInto: copy]].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> on: aNodeSet selfAxis: aStringOrBlockOrNodeTestWithFilters [
	| copy nodeTestBlock |

	copy := aNodeSet copyEmpty.
	aNodeSet isEmpty
		ifTrue: [^ copy].

	nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asXPathNodeTestBlock.
	1 to: aNodeSet size do: [:i |
		(aNodeSet at: i)
			selfAxisSelect: nodeTestBlock
			into: copy].
	^ copy filterEachInSeparateContextWithAll:
		aStringOrBlockOrNodeTestWithFilters asXPathNodeSetFilters.
]
