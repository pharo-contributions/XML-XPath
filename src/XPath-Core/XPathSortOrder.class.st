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

{ #category : #enumerating }
XPathSortOrder >> ancestorAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	| copy |

	aNodeSet isEmpty
		ifTrue: [^ aNodeSet copyEmpty].

	copy := aNodeSet first %% aStringOrBlockOrNodeTestWithFilters.
	aStringOrBlockOrNodeTestWithFilters hasNodeSetFilters
		ifTrue: [
			2 to: aNodeSet size do: [:i |
				((aNodeSet at: i) %% aStringOrBlockOrNodeTestWithFilters)
					addAllIfNotPresentTo: copy]]
		ifFalse: [| nodeTestBlock |
			nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asNodeTestBlock.
			2 to: aNodeSet size do: [:i |
				(aNodeSet at: i)
					ancestorAxisSelect: nodeTestBlock
					ifNotPresentInto: copy]].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> ancestorOrSelfAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	| copy |

	aNodeSet isEmpty
		ifTrue: [^ aNodeSet copyEmpty].

	copy := aNodeSet first %%~ aStringOrBlockOrNodeTestWithFilters.
	aStringOrBlockOrNodeTestWithFilters hasNodeSetFilters
		ifTrue: [
			2 to: aNodeSet size do: [:i |
				((aNodeSet at: i) %%~ aStringOrBlockOrNodeTestWithFilters)
					addAllIfNotPresentTo: copy]]
		ifFalse: [| nodeTestBlock |
			nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asNodeTestBlock.
			2 to: aNodeSet size do: [:i |
				(aNodeSet at: i)
					ancestorOrSelfAxisSelect: nodeTestBlock
					ifNotPresentInto: copy]].
	^ copy.
]

{ #category : #converting }
XPathSortOrder >> asReversedSortOrder [
	self subclassResponsibility
]

{ #category : #enumerating }
XPathSortOrder >> attributeAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	| copy |

	aNodeSet isEmpty
		ifTrue: [^ aNodeSet copyEmpty].

	copy := aNodeSet first @ aStringOrBlockOrNodeTestWithFilters.
	aStringOrBlockOrNodeTestWithFilters hasNodeSetFilters
		ifTrue: [
			2 to: aNodeSet size do: [:i |
				((aNodeSet at: i) @ aStringOrBlockOrNodeTestWithFilters)
					addAllTo: copy]]
		ifFalse: [| nodeTestBlock |
			nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asNodeTestBlock.
			2 to: aNodeSet size do: [:i |
				(aNodeSet at: i)
					attributeAxisSelect: nodeTestBlock
					into: copy]].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> childAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	| copy |

	aNodeSet isEmpty
		ifTrue: [^ aNodeSet copyEmpty].

	copy := aNodeSet first / aStringOrBlockOrNodeTestWithFilters.
	aStringOrBlockOrNodeTestWithFilters hasNodeSetFilters
		ifTrue: [
			2 to: aNodeSet size do: [:i |
				((aNodeSet at: i) / aStringOrBlockOrNodeTestWithFilters)
					addAllTo: copy]]
		ifFalse: [| nodeTestBlock |
			nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asNodeTestBlock.
			2 to: aNodeSet size do: [:i |
				(aNodeSet at: i)
					childAxisSelect: nodeTestBlock
					into: copy]].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> descendantAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	| copy |

	aNodeSet isEmpty
		ifTrue: [^ aNodeSet copyEmpty].

	copy := aNodeSet first // aStringOrBlockOrNodeTestWithFilters.
	aStringOrBlockOrNodeTestWithFilters hasNodeSetFilters
		ifTrue: [
			2 to: aNodeSet size do: [:i |
				((aNodeSet at: i) // aStringOrBlockOrNodeTestWithFilters)
					addAllIfNotPresentTo: copy]]
		ifFalse: [| nodeTestBlock |
			nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asNodeTestBlock.
			2 to: aNodeSet size do: [:i |
				(aNodeSet at: i)
					descendantAxisSelect: nodeTestBlock
					ifNotPresentInto: copy]].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> descendantOrSelfAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	| copy |

	aNodeSet isEmpty
		ifTrue: [^ aNodeSet copyEmpty].

	copy := aNodeSet first //~ aStringOrBlockOrNodeTestWithFilters.
	aStringOrBlockOrNodeTestWithFilters hasNodeSetFilters
		ifTrue: [
			2 to: aNodeSet size do: [:i |
				((aNodeSet at: i) //~ aStringOrBlockOrNodeTestWithFilters)
					addAllIfNotPresentTo: copy]]
		ifFalse: [| nodeTestBlock |
			nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asNodeTestBlock.
			2 to: aNodeSet size do: [:i |
				(aNodeSet at: i)
					descendantOrSelfAxisSelect: nodeTestBlock
					ifNotPresentInto: copy]].
	^ copy.
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
XPathSortOrder >> followingAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	| copy |

	aNodeSet isEmpty
		ifTrue: [^ aNodeSet copyEmpty].

	copy := aNodeSet first >> aStringOrBlockOrNodeTestWithFilters.
	aStringOrBlockOrNodeTestWithFilters hasNodeSetFilters
		ifTrue: [
			2 to: aNodeSet size do: [:i |
				((aNodeSet at: i) >> aStringOrBlockOrNodeTestWithFilters)
					addAllIfNotPresentTo: copy]]
		ifFalse: [| nodeTestBlock |
			nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asNodeTestBlock.
			2 to: aNodeSet size do: [:i |
				(aNodeSet at: i)
					followingAxisSelect: nodeTestBlock
					ifNotPresentInto: copy]].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> followingSiblingAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	| copy |

	aNodeSet isEmpty
		ifTrue: [^ aNodeSet copyEmpty].

	copy := aNodeSet first >>> aStringOrBlockOrNodeTestWithFilters.
	aStringOrBlockOrNodeTestWithFilters hasNodeSetFilters
		ifTrue: [
			2 to: aNodeSet size do: [:i |
				((aNodeSet at: i) >>> aStringOrBlockOrNodeTestWithFilters)
					addAllIfNotPresentTo: copy]]
		ifFalse: [| nodeTestBlock |
			nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asNodeTestBlock.
			2 to: aNodeSet size do: [:i |
				(aNodeSet at: i)
					followingSiblingAxisSelect: nodeTestBlock
					ifNotPresentInto: copy]].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> namespaceAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	| copy |

	aNodeSet isEmpty
		ifTrue: [^ aNodeSet copyEmpty].

	copy := aNodeSet first @@ aStringOrBlockOrNodeTestWithFilters.
	aStringOrBlockOrNodeTestWithFilters hasNodeSetFilters
		ifTrue: [
			2 to: aNodeSet size do: [:i |
				((aNodeSet at: i) @@ aStringOrBlockOrNodeTestWithFilters)
					addAllTo: copy]]
		ifFalse: [| nodeTestBlock |
			nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asNodeTestBlock.
			2 to: aNodeSet size do: [:i |
				(aNodeSet at: i)
					namespaceAxisSelect: nodeTestBlock
					into: copy]].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> parentAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	| copy nodeTestBlock |

	copy := aNodeSet copyEmpty.
	aNodeSet isEmpty
		ifTrue: [^ copy].

	nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asNodeTestBlock.
	1 to: aNodeSet size do: [:i |
		(aNodeSet at: i)
			parentAxisSelect: nodeTestBlock
			ifNotPresentInto: copy].
	^ copy filterEachInSeparateContextWithAll:
		aStringOrBlockOrNodeTestWithFilters asNodeSetFilters.
]

{ #category : #enumerating }
XPathSortOrder >> precedingAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	| copy |

	aNodeSet isEmpty
		ifTrue: [^ aNodeSet copyEmpty].

	copy := aNodeSet first << aStringOrBlockOrNodeTestWithFilters.
	aStringOrBlockOrNodeTestWithFilters hasNodeSetFilters
		ifTrue: [
			2 to: aNodeSet size do: [:i |
				((aNodeSet at: i) << aStringOrBlockOrNodeTestWithFilters)
					addAllIfNotPresentTo: copy]]
		ifFalse: [| nodeTestBlock |
			nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asNodeTestBlock.
			2 to: aNodeSet size do: [:i |
				(aNodeSet at: i)
					precedingAxisSelect: nodeTestBlock
					ifNotPresentInto: copy]].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> precedingSiblingAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	| copy |

	aNodeSet isEmpty
		ifTrue: [^ aNodeSet copyEmpty].

	copy := aNodeSet first <<< aStringOrBlockOrNodeTestWithFilters.
	aStringOrBlockOrNodeTestWithFilters hasNodeSetFilters
		ifTrue: [
			2 to: aNodeSet size do: [:i |
				((aNodeSet at: i) <<< aStringOrBlockOrNodeTestWithFilters)
					addAllIfNotPresentTo: copy]]
		ifFalse: [| nodeTestBlock |
			nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asNodeTestBlock.
			2 to: aNodeSet size do: [:i |
				(aNodeSet at: i)
					precedingSiblingAxisSelect: nodeTestBlock
					ifNotPresentInto: copy]].
	^ copy.
]

{ #category : #enumerating }
XPathSortOrder >> selfAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	| copy nodeTestBlock |

	copy := aNodeSet copyEmpty.
	aNodeSet isEmpty
		ifTrue: [^ copy].

	nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asNodeTestBlock.
	1 to: aNodeSet size do: [:i |
		(aNodeSet at: i)
			selfAxisSelect: nodeTestBlock
			into: copy].
	^ copy filterEachInSeparateContextWithAll:
		aStringOrBlockOrNodeTestWithFilters asNodeSetFilters.
]
