Class {
	#name : #XPathTest,
	#superclass : #TestCase,
	#instVars : [
		'document'
	],
	#category : #'XPath-Tests'
}

{ #category : #accessing }
XPathTest >> addressBookXML [
	^'<addressbook>
  <person employee-number="A0000" family-name="Gates" first-name="Bob">
    <contact-info><!--Confidential--></contact-info>
    <address city="Los Angeles" number="1239" state="CA" street="Pine Rd."/>
    <job-info employee-type="Full-Time" is-manager="no" job-description="Manager"/>
    <manager employee-number="A0000"/>
  </person>
  <person employee-number="A7000" family-name="Brown"
    first-name="Robert" middle-initial="L.">
    <contact-info>
      <email address="robb@iro.ibm.com"/>
      <home-phone number="03-3987873"/>
    </contact-info>
    <address city="New York" number="344" state="NY" street="118 St."/>
    <job-info employee-type="Full-Time" is-manager="yes" job-description="Group Leader"/>
    <manager employee-number="A0000"/>
  </person>
  <person employee-number="A7890" family-name="DePaiva"
    first-name="Kassie" middle-initial="W.">
    <contact-info><!-- Kassie''s agent phone: 03-987654 --></contact-info>
    <address city="Los Angeles" number="1234" state="CA" street="Pine Rd."/>
    <job-info employee-type="Full-Time" is-manager="no" job-description="Actor"/>
    <manager employee-number="A0000"/>
    <misc-info>One of the most talented actresses on Daytime. Kassie
      plays the devious and beautiful Blair Cramer on ABC&apos;s
      &quot;One Life To Live.&quot;</misc-info>
  </person>
  <person employee-number="A7987" family-name="Smith" first-name="Joe">
    <contact-info>
      <email address="joes@iro.ibm.com"/>
      <mobile-phone number="888-7657765"/>
      <home-phone number="03-8767898"/>
      <home-phone number="03-8767871"/>
    </contact-info>
    <address city="New York" number="12789" state="NY" street="W. 15th Ave."/>
    <job-info employee-type="Part-Time" is-manager="no" job-description="Hacker"/>
    <manager employee-number="A7000"/>
  </person>
</addressbook>
'
]

{ #category : #accessing }
XPathTest >> setUp [
	document :=
		(XMLDOMParser on: self addressBookXML)
			preservesCommentNodes: true;
			parseDocument
]

{ #category : #testing }
XPathTest >> testAncestor [
	self assert:
		(XPath for: '//ancestor::node()' in: document) =
			(document allNodesSelect: [:each | each hasChildren]) reversed
]

{ #category : #testing }
XPathTest >> testAncestorOrSelf [
	self assert:
		(XPath
			for: '//node() [ count( child::node() ) = 0]'
			in: document) = (document allNodesSelect: [:each | each hasChildren not]).
	self assert:
		(XPath
			for: '//node( )[count(child::node( ))=0]/ancestor-or-self::node( )'
			in: document) = document allNodes reversed
]

{ #category : #testing }
XPathTest >> testAttribute [
	| results |

	results :=
		XPath
			for: 'addressbook/person/address/@city'
			in: document.
	self assert: results size = 4.
	results do: [:each |
		self
			assert: each class == XMLAttribute;
			assert: each name = 'city'].
	self assert:
		(results collect: [:each | each value]) asArray =
			#('Los Angeles' 'New York' 'Los Angeles' 'New York').
]

{ #category : #testing }
XPathTest >> testCommentNodeTest [
	| comments |

	comments := document xPath: '//comment()'.
	self
		assert: comments size = 2;
		assert: comments = (document allNodesSelect: [:each | each isComment]).
]

{ #category : #testing }
XPathTest >> testConcatFunction [
	self
		assert: (XPath for: 'concat("one", "two")' in: nil) = 'onetwo';
		assert: (XPath for: 'concat("one", "two", true())' in: nil) = 'onetwotrue'.
	self
		should: [XPath for: 'concat("one")' in: nil]
		raise: XPathArgumentNumberException.
]

{ #category : #testing }
XPathTest >> testCountFunction [
	self assert:
		(XPath for: 'count(addressbook/person)' in: document) =
			(document allElementsNamed: 'person') size.
	self assert:
		(XPath for: 'addressbook/person[count(@*) >= 4]' in: document) =
			((document allElementsNamed: 'person') copyFrom: 2 to: 3).
	self
		should: [XPath for: 'count()' in: nil]
		raise: XPathArgumentNumberException.
	self
		should: [XPath for: 'count(1)' in: nil]
		raise: XPathTypeException.
]

{ #category : #testing }
XPathTest >> testDescendant [
	| path results |
	path := XPath for: '//address/@city'.
	results := path in: document.
	self assert: results size = 4 & (results size > 0).
	self assert: (results at: 1) value = 'Los Angeles'.

]

{ #category : #testing }
XPathTest >> testDescendantOrSelf [
	self
		assert: (XPath for: '//.' in: document) = document allNodes;
		assert: (XPath for: '//./node()' in: document) = document allNodes allButFirst;
		assert: (XPath for: '//~node()' in: document) = document allNodes;
		assert: (XPath for: '// self :: node()' in: document) = document allNodes;
		assert: (XPath for: '/ descendant-or-self ::node()' in: document) = document allNodes;
		assert: (XPath for: '//*' in: document) = document allElements
]

{ #category : #testing }
XPathTest >> testDot [
	| path results |
	path := XPath for: 'addressbook/person/address/./@city'.
	results := path in: document.
	self assert: results size = 4 & (results size > 0).
	self assert: (results at: 1) value = 'Los Angeles'.

]

{ #category : #testing }
XPathTest >> testDotDot [
	| path results |
	path := XPath for: 'addressbook/person/address/../address/@city'.
	results := path in: document.
	self assert: results size = 4 & (results size > 0).
	self assert: (results at: 1) value = 'Los Angeles'.

]

{ #category : #testing }
XPathTest >> testDotDotTooHigh [
	| path results |
	path := XPath for: 'person/address/../../../address/@city'.
	results := path in: document.
	self assert: (results size = 0).
]

{ #category : #testing }
XPathTest >> testFollowingSibling [
	| siblings |

	siblings := (document allElementsNamed: 'person') allButFirst.
	self assert:
		(XPath
			for: 'addressbook/person/following-sibling::node()'
			in: document) = siblings.

	siblings := XMLNodeList new.
	document allElementsNamed: 'person' do: [:each |
		each nodes allButFirstDo: [:node |
			siblings addLast:node]].
	self assert:
		(XPath
			for: 'addressbook/person/node()/following-sibling::node()'
			in: document) = siblings.

	siblings := document allNodesSelect: [:each |
		each hasParent
			and: [each previousNode notNil]].
	self assert:
		(XPath
			for: '//following-sibling::node()'
			in: document) = siblings.
]

{ #category : #testing }
XPathTest >> testLangFunction [
	| element |

	(element := XMLElement named: 'test')
		attributeAt: 'xml:lang' put: 'en-us'.
	self
		assert: ('lang("En")' asXPath in: element);
		assert: ('lang("en-US")' asXPath in: element);
		deny: ('lang("en-UK")' asXPath in: element);
		deny: ('lang("DE")' asXPath in: element).

	element attributeAt: 'xml:lang' put: 'En'.
	self
		assert: ('lang("En")' asXPath in: element);
		deny: ('lang("en-US")' asXPath in: element);
		deny: ('lang("en-UK")' asXPath in: element);
		deny: ('lang("DE")' asXPath in: element).
]

{ #category : #testing }
XPathTest >> testLastFunction [
	| path |

	path := XPath for: 'addressbook/person[last()]'.
	self assert:
		(path in: document) =
			((document allElementsNamed: 'person') allButFirst: 3).
]

{ #category : #testing }
XPathTest >> testLocalNameFunction [
	self assert:
		(XPath
			for: 'local-name(addressbook/person[1]/*[last()]/preceding::*)'
			in: document) = 'contact-info'.
	self assert:
		(XPath
			for: 'local-name(addressbook/absent)'
			in: document) isEmpty.
	self assert:
		(XPath
			for: 'local-name(//comment())'
			in: document) isEmpty.
	self assert:
		(XPath
			for: 'local-name()'
			in: document root) = 'addressbook'.
]

{ #category : #testing }
XPathTest >> testLogicalOperators [
	self
		deny: '0 or 0 or 0' asXPath evaluate;
		assert: '0 or 0 or 1' asXPath evaluate;
		deny: '1 and 1 and 0' asXPath evaluate;
		assert: '1 and 1 and 2' asXPath evaluate
]

{ #category : #testing }
XPathTest >> testNamespace [
	self assert:
		(document xPath: '//namespace::*') =
			(document allElementsCollect: [:each |
				XPathNamespaceNode withXMLNamespaceOnElement: each]).
]

{ #category : #testing }
XPathTest >> testNormalizeSpaceFunction [
	self assert:
		'normalize-space("
		    one		  
		    two
		    three
		")' asXPath evaluate = 'one two three'.
	self assert: 'normalize-space(" 	")' asXPath evaluate isEmpty.
]

{ #category : #testing }
XPathTest >> testOneLevel [
	| path results |
	path := XPath for: 'addressbook/person'.
	results := path in: document.
	self assert: (results size = 4).
]

{ #category : #testing }
XPathTest >> testPosition [
	self assert:
		(XPath
			for: ' position() '
			in: (document allElementsNamed: 'person') last) = 4.
]

{ #category : #testing }
XPathTest >> testPositionFunction [
	(document allElementsNamed: 'person')
		withIndexDo: [:each :i |
			self assert: (XPath for: ' position() ' in: each) = i]
]

{ #category : #testing }
XPathTest >> testPrecedence [
	self
		assert: (XPath for: '1 + 2 * 3 + 4 div 2' in: nil) rounded = 9;
		assert: (XPath for: '(1 + 2) * (3 + 4) mod 5' in: nil) rounded = 1.
]

{ #category : #testing }
XPathTest >> testReverseAxis [
	| results |

	results :=
		XPath
			for: 'addressbook/person[4]/preceding-sibling::node()'
			in: document.
	self assert: results = document root nodes allButLast reversed.

	results :=
		XPath
			for: 'addressbook/person[4]/preceding-sibling::node()/manager'
			in: document.
	self assert:
		results =
			(document root nodes allButLast
				collect: [:each | each elementAt: 'manager']).
]

{ #category : #testing }
XPathTest >> testSorting [
	| allNodes nodeSet reversedNodesNodeSet |

	allNodes := document allNodes.
	nodeSet := XPathNodeSet newFrom: allNodes.
	self
		assert: nodeSet sorted = allNodes;
		assert: nodeSet reverseSorted = allNodes reversed;
		assert: nodeSet sorted reversed sorted = allNodes;
		assert: nodeSet reverseSorted reversed reverseSorted = allNodes reversed.

	reversedNodesNodeSet := XPathNodeSet newFrom: allNodes reversed.
	self	
		assert: reversedNodesNodeSet sorted = allNodes;
		assert: reversedNodesNodeSet reverseSorted = allNodes reversed;
		assert: reversedNodesNodeSet sorted reversed sorted = allNodes;
		assert: reversedNodesNodeSet reverseSorted reversed reverseSorted = allNodes reversed.
]

{ #category : #testing }
XPathTest >> testStartsWithFunction [
	self
		assert: 'starts-with("onetwothree", "one")' asXPath evaluate;
		deny: 'starts-with("onetwothree", "ONE")' asXPath evaluate;
		assert: 'starts-with("123", 1)' asXPath evaluate
]

{ #category : #testing }
XPathTest >> testSubstringAfterFunction [
	self
		assert: 'substring-after("onetwothree", "one")' asXPath evaluate = 'twothree';
		assert: 'substring-after("onetwothree", ''two'')' asXPath evaluate = 'three';
		assert: 'substring-after("onetwothree", "three")' asXPath evaluate isEmpty;
		assert: 'substring-after("onetwothree", "four")' asXPath evaluate isEmpty
]

{ #category : #testing }
XPathTest >> testSubstringBeforeFunction [
	self
		assert: 'substring-before("onetwothree", "one")' asXPath evaluate isEmpty;
		assert: 'substring-before("onetwothree", ''two'')' asXPath evaluate = 'one';
		assert: 'substring-before("onetwothree", "three")' asXPath evaluate = 'onetwo';
		assert: 'substring-before("onetwothree", "four")' asXPath evaluate isEmpty
]

{ #category : #testing }
XPathTest >> testSubstringFunction [
	self
		assert: 'substring("onetwothree", 4, 3)' asXPath evaluate = 'two';
		assert: 'substring("onetwothree", 4)' asXPath evaluate = 'twothree';
		assert: 'substring("onetwothree", -3, 2)' asXPath evaluate = 'on';
		assert: 'substring("onetwothree", 12, 2)' asXPath evaluate isEmpty;
		assert: 'substring("", 0, 1)' asXPath evaluate isEmpty;
		assert: 'substring("", 0)' asXPath evaluate isEmpty
]

{ #category : #testing }
XPathTest >> testThreeLevel [
	| path results |
	path := XPath for: '*/person/contact-info/email'.
	results := path in: document.
	self assert: (results size = 2).
]

{ #category : #testing }
XPathTest >> testTopLevel [
	| path results elem |
	path := XPath for: 'addressbook'.
	results := path in: document.
	
	self assert: results size = 1.
	
	elem := results first.
	self assert: elem isElement.
	self assert: elem name = 'addressbook'.
	self assert: elem elements size = 4.
	self assert: elem elements first isElement.
	self assert: elem elements first name = 'person'.
	self assert: elem elements last name = 'person'.	
]

{ #category : #testing }
XPathTest >> testTranslateFunction [
	self
		assert: 'translate("onetwothree", "oe", "O")' asXPath evaluate = 'OntwOthr';
		assert: 'translate("onetwothree", "oe", "OEN")' asXPath evaluate = 'OnEtwOthrEE';
		assert: 'translate("onetwothree", "z", "x")' asXPath evaluate = 'onetwothree'
]

{ #category : #testing }
XPathTest >> testTwoLevel [
	| path results |
	path := XPath for: '/*/person/address'.
	results := path in: document.
	self assert: (results size = 4).
]

{ #category : #testing }
XPathTest >> testUndeclaredFunctions [
	self
		should: [XPath for: 'undeclared()/addressbook' in: document]
		raise: XPathUndeclaredFunctionException.
	self
		should: [XPath for: 'addressbook[undeclared()]' in: document]
		raise: XPathUndeclaredFunctionException.
]

{ #category : #testing }
XPathTest >> testUndeclaredVariables [
	self
		should: [XPath for: '$undeclared/addressbook' in: document]
		raise: XPathUndeclaredVariableException.
	self
		should: [XPath for: 'addressbook[$undeclared]' in: document]
		raise: XPathUndeclaredVariableException.
]

{ #category : #testing }
XPathTest >> testUnion [
	self assert:
		(XPath
			for:
				'addressbook/person[position() = 1 or position() = 4] |
				(addressbook/person[4]/preceding-sibling::*[position() < 4])'
			in: document) = (document allElementsNamed: 'person')
]

{ #category : #testing }
XPathTest >> testVariables [
	| path context results |

	path := XPath for: '$doc/addressbook/person[.//address[@city=$city]]'.
	(context := XPathContext new)
		variableAt: 'doc' put: document;
		variableAt: 'city' ifAbsentPut: ['Los Angeles'].
	results := path in: nil context: context.
	self
		assert: results size = 2;
		assert:
			results =
				((document allElementsNamed: 'person') select: [:each |
					((each elementAt: 'address') attributeAt: 'city') = 'Los Angeles']).
]

{ #category : #testing }
XPathTest >> testWildcard [
	| path results |

	path := XPath for: 'addressbook/*'.
	results := path in: document.
	self
		assert: results size = 4;
		assert: results = (document allElementsNamed: 'person')
]

{ #category : #testing }
XPathTest >> testWildcardDescendant [
	| path results |

	path := XPath for: '//*'.
	results := path in: document.
	self
		assert: (results size = 28);
		assert: results = document descendentElements
]

{ #category : #testing }
XPathTest >> testWildcardDescendantAttribute [
	| path results |
	path := XPath for: '//*/@city'.
	results := path in: document.
	self
		assert: results size = 4;
		assert:
			results =
				((document allElementsSelect: [:each |
					each includesAttribute: 'city'])
					collect: [:each | each attributeNodeAt: 'city']).
]

{ #category : #testing }
XPathTest >> testWildcardDescendantAttributeValue [
	| path results |
	path := XPath for: ' // * [ @ city = "Los Angeles" ] '.
	results := path in: document.
	self
		assert: results size = 2;
		assert:
			results =
				(document allElementsSelect: [:each |
					(each isNamed: 'address')
						and: [(each attributeAt: 'city') = 'Los Angeles']]).

]
