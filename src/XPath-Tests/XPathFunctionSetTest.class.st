Class {
	#name : #XPathFunctionSetTest,
	#superclass : #TestCase,
	#instVars : [
		'functions',
		'disjointFunctions'
	],
	#category : #'XPath-Tests'
}

{ #category : #accessing }
XPathFunctionSetTest >> absentFunction [
	^ XPathStringFunction
]

{ #category : #asserting }
XPathFunctionSetTest >> assertSet: aFirstSet equals: aSecondSet [
	self
		assert: aFirstSet = aSecondSet;
		assert: aSecondSet = aFirstSet
]

{ #category : #asserting }
XPathFunctionSetTest >> denySet: aFirstSet equals: aSecondSet [
	self
		deny: aFirstSet = aSecondSet;
		deny: aFirstSet == aSecondSet;
		deny: aSecondSet = aFirstSet;
		deny: aSecondSet == aFirstSet
]

{ #category : #accessing }
XPathFunctionSetTest >> disjointFunctions [
	disjointFunctions ifNil: [
		(disjointFunctions := OrderedCollection new)
			addLast: XPathSubstringFunction;
			addLast: XPathSubstringBeforeFunction;
			addLast: XPathSubstringAfterFunction.
		disjointFunctions := disjointFunctions asArray].
	^ disjointFunctions copy.
]

{ #category : #accessing }
XPathFunctionSetTest >> emptySet [
	^ self setClass new
]

{ #category : #accessing }
XPathFunctionSetTest >> functions [
	functions ifNil: [
		(functions := OrderedCollection new)
			addLast: XPathTrueFunction;
			addLast: XPathFalseFunction;
			addLast: XPathNotFunction.
		functions := functions asArray].
	^ functions copy.
]

{ #category : #accessing }
XPathFunctionSetTest >> setClass [
	^ XPathFunctionSet
]

{ #category : #accessing }
XPathFunctionSetTest >> setWithDisjointFunctions [
	^ self setClass newFrom: self disjointFunctions
]

{ #category : #accessing }
XPathFunctionSetTest >> setWithFunctions [
	^ self setClass newFrom: self functions
]

{ #category : #asserting }
XPathFunctionSetTest >> should: aBlock add: aFirstObject and: aSecondObject equaling: anExpectedSum [
	| firstCopy secondCopy sum |

	firstCopy := aFirstObject asFunctionSet copy.
	secondCopy := aSecondObject asFunctionSet copy.
	sum := aBlock value.
	self
		assert: sum = anExpectedSum;
		deny: sum == aFirstObject;
		deny: sum == aSecondObject;
		assert: firstCopy = aFirstObject asFunctionSet;
		assert: secondCopy = aSecondObject asFunctionSet.
]

{ #category : #asserting }
XPathFunctionSetTest >> should: aBlock subtract: aFirstObject from: aSecondObject equaling: anExpectedDifference [
	| firstCopy secondCopy difference |

	firstCopy := aFirstObject asFunctionSet copy.
	secondCopy := aSecondObject asFunctionSet copy.
	difference := aBlock value.
	self
		assert: difference = anExpectedDifference;
		deny: difference == aFirstObject;
		deny: difference == aSecondObject;
		assert: firstCopy = aFirstObject asFunctionSet;
		assert: secondCopy = aSecondObject asFunctionSet.
]

{ #category : #tests }
XPathFunctionSetTest >> testAdd [
	| set |

	set := self emptySet.
	self functions do: [:each |
		self
			assert: (set add: each) == each;
			assert: (set includes: each)].
	self
		assert: set = self setWithFunctions;
		assert: (self functions allSatisfy: [:each | (set add: each) == each]);
		assert: set = self setWithFunctions.
]

{ #category : #tests }
XPathFunctionSetTest >> testAsFunctionSet [
	| set function |

	set := self setClass new.
	self assert: set asFunctionSet == set.

	function := self functions anyOne.
	set := function asFunctionSet.
	self assert: set = (self setClass with: function).
	
]

{ #category : #tests }
XPathFunctionSetTest >> testDo [
	| enumerated |

	enumerated := OrderedCollection new.
	self emptySet do: [:each | enumerated addLast: each].
	self assert: enumerated size = 0.

	self setWithFunctions do: [:each | enumerated addLast: each].
	self
		assert: enumerated size = self functions size;
		assert: (self functions allSatisfy: [:each | enumerated includes: each]).
]

{ #category : #tests }
XPathFunctionSetTest >> testEquals [
	| set |

	set := self emptySet.
	self
		assertSet: set equals: self emptySet;
		denySet: set equals: self setWithFunctions;
		denySet: set equals: self setWithDisjointFunctions.

	set := self setWithFunctions.
	self
		assertSet: set equals: self setWithFunctions;
		denySet: set equals: self setWithDisjointFunctions.

	set := self setWithDisjointFunctions.
	self assertSet: set equals: self setWithDisjointFunctions.
]

{ #category : #tests }
XPathFunctionSetTest >> testFunctionNamed [
	| set |

	set := self setWithFunctions.
	self functions do: [:each |
		self assert: (set functionNamed: each functionName) == each].
	self
		should: [set functionNamed: self absentFunction functionName]
		raise: Error.
]

{ #category : #tests }
XPathFunctionSetTest >> testFunctionNamedIfAbsent [
	| set |

	set := self setWithFunctions.
	self functions do: [:each |
		self assert:
			(set
				functionNamed: each functionName
				ifAbsent: [self absentFunction]) == each].
	self assert:
		(set
			functionNamed: self absentFunction functionName
			ifAbsent: [self absentFunction]) == self absentFunction.
]

{ #category : #tests }
XPathFunctionSetTest >> testIncludes [
	| set |

	set := self emptySet.
	self deny: (self functions anySatisfy: [:each | set includes: each]).

	set := self setWithFunctions.
	self assert: (self functions allSatisfy: [:each | set includes: each]).
	self deny: (self disjointFunctions anySatisfy: [:each | set includes: each]).

	set := self setWithDisjointFunctions.
	self assert: (self disjointFunctions allSatisfy: [:each | set includes: each]).
]

{ #category : #tests }
XPathFunctionSetTest >> testIncludesFunctionNamed [
	| set |

	set := self emptySet.
	self functions do: [:each |
		self deny: (set includesFunctionNamed: each functionName)].

	set := self setWithFunctions.
	self functions do: [:each |
		self assert: (set includesFunctionNamed: each functionName)].
	self disjointFunctions do: [:each |
		self deny: (set includesFunctionNamed: each functionName)].

	set := self setWithDisjointFunctions.
	self disjointFunctions do: [:each |
		self assert: (set includesFunctionNamed: each functionName)].
]

{ #category : #tests }
XPathFunctionSetTest >> testMinusFunction [
	| set |

	set := self setWithFunctions.
	self functions do: [:each |
		self
			should: [set - each]
			subtract: each
			from: set
			equaling: (self setClass newFrom: (self functions copyWithout: each))].

	self disjointFunctions do: [:each |
		self
			should: [set - each]
			subtract: each
			from: set
			equaling: self setWithFunctions].

	self assert:
		(self functions first - self functions second) =
			(self setClass with: self functions first).
	self assert:
		(self functions first - self functions first) =
			self emptySet.
]

{ #category : #tests }
XPathFunctionSetTest >> testMinusSet [
	| firstSet secondSet |

	firstSet := self setWithFunctions.
	secondSet := self emptySet.
	self
		should: [firstSet - secondSet]
		subtract: secondSet
		from: firstSet
		equaling: self setWithFunctions.

	secondSet := self setWithDisjointFunctions.
	self
		should: [firstSet - secondSet]
		subtract: secondSet
		from: firstSet
		equaling: self setWithFunctions.
	self
		should: [firstSet - firstSet]
		subtract: firstSet
		from: firstSet
		equaling: self emptySet.
]

{ #category : #tests }
XPathFunctionSetTest >> testPlusFunction [
	| set |

	set := self setWithFunctions.
	self functions do: [:each |
		self
			should: [set + each]
			add: each
			and: set
			equaling: self setWithFunctions].

	set := self setWithFunctions.
	self disjointFunctions do: [:each |
		self
			should: [set + each]
			add: each
			and: set
			equaling: (self setClass newFrom: (self functions copyWith: each))].

	self assert:
		(self functions first + self functions second) =
			(self setClass
				with: self functions first
				with: self functions second).

	self assert:
		(self functions first + self functions first) =
			(self setClass with: self functions first).
]

{ #category : #tests }
XPathFunctionSetTest >> testPlusSet [
	| firstSet secondSet |

	firstSet := self setWithFunctions.
	secondSet := self emptySet.
	self
		should: [firstSet + secondSet]
		add: firstSet
		and: secondSet
		equaling: self setWithFunctions.
	self
		should: [firstSet + firstSet]
		add: firstSet
		and: firstSet
		equaling: self setWithFunctions.

	secondSet := self setWithDisjointFunctions.
	self
		should: [firstSet + secondSet]
		add: firstSet
		and: secondSet
		equaling:
			(self setClass newFrom:
				self setWithDisjointFunctions, self setWithFunctions).
]

{ #category : #tests }
XPathFunctionSetTest >> testPostCopy [
	| set copy |

	set := self setWithFunctions.
	copy := set copy.
	self
		assert: set = copy;
		assert: set functionsByName = copy functionsByName;
		deny: set functionsByName == copy functionsByName.
]

{ #category : #tests }
XPathFunctionSetTest >> testRemoveIfAbsent [
	| set |

	set := self setWithFunctions.
	self functions do: [:each |
		self assert:
			(set
				remove: each
				ifAbsent: [self absentFunction]) == each.
		self
			assert:
				(set
					remove: each
					ifAbsent: [self absentFunction]) == self absentFunction.
		self deny: (set includes: each).
		self
			should: [set remove: each]
			raise: Error].
	self assert: set isEmpty.
]
