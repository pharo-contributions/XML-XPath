Class {
	#name : #XPathTest,
	#superclass : #TestCase,
	#instVars : [
		'document',
		'namespacedDocument'
	],
	#category : #'XPath-Tests'
}

{ #category : #running }
XPathTest >> setUp [
	document :=
		(XMLDOMParser on: XMLParserTest addressBookXML)
			preservesCommentNodes: true;
			parseDocument.
	namespacedDocument := 
		(XMLDOMParser on: XMLDOMParserTest addressBookNamespacePrefixedXML)
			preservesCommentNodes: true;
			parseDocument.
]

{ #category : #tests }
XPathTest >> testAbbreviatedSteps [
	| result |

	result := XPathNodeSet with: document.
	self
		assert: (document xPath: '.') = result;
		assert: (document xPath: './.') = result;
		assert: (document xPath: './..') isEmpty;
		assert: (document xPath: '..') isEmpty;
		assert: (document xPath: '../..') isEmpty;
		assert: (document xPath: '/.') = result;
		assert: (document xPath: '/./.') = result;
		assert: (document xPath: '/./..') isEmpty;
		assert: (document xPath: '/..') isEmpty;
		assert: (document xPath: '/../..') isEmpty.

	result := document allElementsNamed: 'person'.
	self
		assert: (document xPath: './addressbook/./person/.') = result;
		assert: (document xPath: '././addressbook/././person/./.') = result;
		assert: (document xPath: './addressbook/../addressbook/person/../person') = result;
		assert: (document xPath: './addressbook/./../addressbook/./person/./../person') = result.
	self
		should: [document xPath: '.[true()]']
		raise: XPathSyntaxException.
	self
		should: [document xPath: '..[true()]']
		raise: XPathSyntaxException.
]

{ #category : #tests }
XPathTest >> testAbsoluteLocationPaths [
	document allNodesDo: [:each |
		self
			assert: (XPath for: '/' in: each) = (XMLNodeList with: document);
			assert: (XPath for: '/*' in: each) = (XMLNodeList with: document root);
			assert: (XPath for: '/self::node()' in: each) = (XMLNodeList with: document);
			assert: (XPath for: '/addressbook/person' in: each) = (document allElementsNamed: 'person')]
]

{ #category : #tests }
XPathTest >> testAddFunction [
	| functionSet context |

	functionSet := XPathFunctionSet default copyWithout: XPathCeilingFunction.
	self
		should: [
			XPath
				for: 'ceiling()'
				in: nil
				context: (XPathContext functions: functionSet)]
		raise: XPathUndeclaredFunctionException.

	(context := XPathContext functions: functionSet)
		addFunction: XPathCeilingFunction.
	self
		assert: (context includesFunction: XPathCeilingFunction);
		deny: (functionSet includes: XPathCeilingFunction);
		assert: (XPath for: 'ceiling(1.9)' in: nil context: context) = 2.
]

{ #category : #tests }
XPathTest >> testAncestorAxis [
	| ancestors |

	ancestors := (document allNodesSelect: [:each | each hasChildren]) reversed.
	self assert: (XPath for: '//ancestor::node()' in: document) = ancestors.

	ancestors := ancestors select: [:ancestor |
		ancestor nodes anySatisfy: [:each | each hasChildren]].
	self assert:
		(XPath for: '//ancestor::node()/ancestor::node()' in: document) = ancestors.

	ancestors := (document allElementsNamed: 'person') reversed.
	ancestors addAll: ancestors last ancestorNodes.
	self assert:
		(XPath for: '*/person/node()/ancestor::node()' in: document) = ancestors.
]

{ #category : #tests }
XPathTest >> testAncestorOrSelfAxis [
	| nodes |

	nodes := document allNodesSelect: [:each | each hasChildren not].
	self assert:
		(XPath
			for: '//node() [ count( child::node() ) = 0]'
			in: document) = nodes.
	
	nodes := document allNodes reversed.
	self assert:
		(XPath
			for: '//node( )[count(child::node( ))=0]/ancestor-or-self::node( )'
			in: document) = nodes.

	nodes := (document allElementsNamed: 'person') allButLast reversed.
	nodes first ancestorNodesDo: [:each | nodes addLast: each].
	self assert:
		(XPath
			for: '//person[last()]/preceding-sibling::person/ancestor-or-self::node()'
			in: document) = nodes.

	nodes removeAll.
	(document allElementsNamed: 'person') reverseDo: [:each |
		nodes
			addAll: each nodes reversed;
			add: each].
	nodes addAll: nodes last ancestorNodes.
	self assert:
		(XPath for: '*/person/node()/ancestor-or-self::node()' in: document) = nodes.
]

{ #category : #tests }
XPathTest >> testAsXPath [
	| path |

	path := '/addressbook' asXPath.
	self
		assert: (path isKindOf: XPath);
		assert: (document xPath: path) = (XPathNodeSet with: document root);
		assert: path asXPath == path.
]

{ #category : #tests }
XPathTest >> testAttributeAxis [
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

	"attribute nodes don't have attributes"
	self assert: 
		(XPath
			for: 'addressbook/person/address/@city/@city'
			in: document) isEmpty.
]

{ #category : #tests }
XPathTest >> testAttributeNameTest [
	| results |

	results :=
		document xPath:
			'addressbook/person/attribute::node()/self::attribute(employee-number)'.
	self
		assert: results size = 4;
		assert:
			results =
				((document allElementsNamed: 'person') collect: [:each |
					each attributeNodeAt: 'employee-number']).

	results :=
		document xPath:
			'addressbook/person/attribute::node()/self::attribute(absent)'.
	self assert: results isEmpty.
]

{ #category : #tests }
XPathTest >> testAttributeTypeTest [
	| results |

	results := XMLNodeList new.
	document allNodesDo: [:each |
		each isElement
			ifTrue: [results addAll: each attributeNodes]
			ifFalse: [
				each isStringNode
					ifTrue: [results addLast: each]]].
	self assert: (document xPath: '//attribute::* | //text()') = results.
	self assert:
		(document xPath: '(//attribute::* | //text())/ self :: attribute()') =
			(results select: [:each | each isAttribute]).
]

{ #category : #tests }
XPathTest >> testChildAxis [
	| nodes |

	nodes := document allElementsNamed: 'person'.
	self assert:
		(XPath
			for: 'child::addressbook/child::person'
			in: document) = nodes.

	nodes removeAll.
	document allElementsNamed: 'person' do: [:each | nodes addAll: each nodes].
	self assert:
		(XPath
			for: '/addressbook/person/node()'
			in: document) = nodes.

	nodes := (document allElementsNamed: 'person') allButLast.
	nodes last nodesDo: [:each | nodes addAll: each nodes].
	nodes addLast: (document allElementsNamed: 'person') last.
	self assert:
		(XPath
			for: '(/addressbook | //person[3]/*)/node()'
			in: document) = nodes.
]

{ #category : #tests }
XPathTest >> testCommentTypeTest [
	| comments |

	comments := document xPath: '//comment()'.
	self
		assert: comments size = 2;
		assert: comments = (document allNodesSelect: [:each | each isComment]);
		assert: (document xPath: '//comment()/self::comment()') = comments;
		assert: (document xPath: '//comment()/comment()') isEmpty.
]

{ #category : #tests }
XPathTest >> testConcatFunction [
	self
		assert: (XPath for: 'concat("one", "two")' in: nil) = 'onetwo';
		assert: (XPath for: 'concat("one", "two", true())' in: nil) = 'onetwotrue'.
	self
		should: [XPath for: 'concat("one")' in: nil]
		raise: XPathArgumentNumberException.
]

{ #category : #tests }
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

{ #category : #tests }
XPathTest >> testDescendantAxis [
	| path results |

	path := XPath for: '//address/@city'.
	results := path in: document.
	self assert: results size = 4 & (results size > 0).
	self assert: (results at: 1) value = 'Los Angeles'.

	path := XPath for: 'addressbook/person//address'.
	self assert: (path in: document) = (document allElementsNamed: 'address').

	path := XPath for: 'addressbook/person//address//absent'.
	self assert: (path in: document) isEmpty.

	path := XPath for: 'addressbook/person//*'.
	self assert:
		(path in: document) =
			(document root descendentElementsSelect: [:each | (each isNamed: 'person') not]).

	path := XPath for: 'addressbook/person//*/descendant::*'.
	self assert:
		(path in: document) =
			(document root descendentElementsSelect: [:each |
				((each isNamed: 'person')
					or: [each parent isNamed: 'person']) not]).

	path := XPath for: 'addressbook/person[last()]/preceding-sibling::person/descendant::*'.
	self assert:
		(path in: document) =
			(document root descendentElementsSelect: [:each |
				((each isNamed: 'person')
					or: [each ancestorElements includes: document root lastElement]) not]).

	path := XPath for: 'addressbook/descendant::comment()'.
	self assert: (path in: document) = (document allNodesSelect: [:each | each isComment]).

	path := XPath for: 'addressbook/descendant::comment()/descendant::node()'.
	self assert: (path in: document) isEmpty.
]

{ #category : #tests }
XPathTest >> testDescendantOrSelfAxis [
	self
		assert: (XPath for: '//.' in: document) = document allNodes;
		assert: (XPath for: '//./node()' in: document) = document allNodes allButFirst;
		assert: (XPath for: '//~node()' in: document) = document allNodes;
		assert: (XPath for: '// self :: node()' in: document) = document allNodes;
		assert: (XPath for: '/ descendant-or-self ::node()' in: document) = document allNodes;
		assert: (XPath for: '//*' in: document) = document allElements;
		assert:
			(XPath for: '//comment()/descendant-or-self::comment()' in: document) =
				(document allNodesSelect: [:each | each isComment]).

	self assert:
		(XPath for: 'addressbook/person/descendant-or-self::element()' in: document) =
			document root descendentElements.
	self assert:
		(XPath for: 'addressbook/person/descendant-or-self::address' in: document) =
			(document allElementsNamed: 'address').
	self assert:
		(XPath for: 'addressbook/person[last()]/preceding-sibling::person/descendant-or-self::*' in: document) =
			(document root descendentElements copyWithoutAll: document root lastElement allElements).
	self assert:
		(XPath for: 'addressbook/person/contact-info/comment()/descendant-or-self::node()' in: document) =
			(document allNodesSelect: [:each | each isComment]).
]

{ #category : #tests }
XPathTest >> testDot [
	| path results |

	path := XPath for: 'addressbook/person/address/./@city'.
	results := path in: document.
	self assert: results size = 4 & (results size > 0).
	self assert: (results at: 1) value = 'Los Angeles'.

]

{ #category : #tests }
XPathTest >> testDotDot [
	| path results |
	path := XPath for: 'addressbook/person/address/../address/@city'.
	results := path in: document.
	self assert: results size = 4 & (results size > 0).
	self assert: (results at: 1) value = 'Los Angeles'.

]

{ #category : #tests }
XPathTest >> testDotDotTooHigh [
	| path results |
	path := XPath for: 'person/address/../../../address/@city'.
	results := path in: document.
	self assert: (results size = 0).
]

{ #category : #tests }
XPathTest >> testDoubleWildcard [
	self assert:
		(XPath for: 'addressbook/*:*' in: document) =
			(document allElementsNamed: 'person').
	self assert:
		(XPath for: 'book:addressbook/*:*' in: namespacedDocument) =
			(namespacedDocument allElementsNamed: 'person').
	self assert:
		(XPath
			for: '*:*/*:*'
			in: namespacedDocument
			context: (XPathContext new declarePrefix: 'two' uri: 'personNS')) =
				(namespacedDocument allElementsNamed: 'person').
]

{ #category : #tests }
XPathTest >> testElementDoubleWildcard [
	self assert:
		(XPath for: 'addressbook/element(*:*)' in: document) =
			(document allElementsNamed: 'person').
	self assert:
		(XPath for: 'book:addressbook/element(*:*)' in: namespacedDocument) =
			(namespacedDocument allElementsNamed: 'person').
	self assert:
		(XPath
			for: 'element(*:*)/element(*:*)'
			in: namespacedDocument
			context: (XPathContext new declarePrefix: 'two' uri: 'personNS')) =
				(namespacedDocument allElementsNamed: 'person').
]

{ #category : #tests }
XPathTest >> testElementExpandedNameTest [
	| persons |

	persons := namespacedDocument allElementsNamed: 'person'.
	self assert:
		(namespacedDocument xPath:
			'element( Q{bookNS}addressbook ) / element( Q{personNS}person )') = persons.
	self assert: (namespacedDocument xPath: 'element(Q{undeclared}addressbook)') isEmpty.
	self
		should: [namespacedDocument xPath: 'element(Q{bookNS} addressbook)']
		raise: XPathSyntaxException.
	self
		should: [namespacedDocument xPath: 'element(Q {bookNS}addressbook)']
		raise: XPathSyntaxException.
]

{ #category : #tests }
XPathTest >> testElementExpandedNameWildcardTest [
	| persons |

	persons := namespacedDocument allElementsNamed: 'person'.
	self assert:
		(namespacedDocument xPath:
			'element( Q{bookNS}* ) / element( Q{personNS}* )') = persons.
	self assert: (namespacedDocument xPath: 'element(Q{undeclared}*)') isEmpty.
	self
		should: [namespacedDocument xPath: 'element(Q{bookNS} *)']
		raise: XPathSyntaxException.
	self
		should: [namespacedDocument xPath: 'element(Q {bookNS}*)']
		raise: XPathSyntaxException.
]

{ #category : #tests }
XPathTest >> testElementLocalNameWildcardTest [
	| persons mappings |

	persons := namespacedDocument allElementsNamed: 'person'.
	mappings := 
		Array
			with: 'one' -> 'bookNS'
			with: 'two' -> 'personNS'.
	self
		assert: (namespacedDocument xPath: 'element(book:*)/element(ps:*)') = persons;
		assert: (namespacedDocument xPath: 'element(book:*)/element(undeclared:*)') isEmpty.
	self assert:
		(XPath
			for: 'element(one:*)/element(two:*)'
			in: namespacedDocument
			context: (XPathContext namespaces: mappings)) = persons.
	self assert:
		(XPath
			for: 'element(one:*)/element(one:*)'
			in: namespacedDocument
			context: (XPathContext namespaces: mappings)) isEmpty.
	self
		should: [
			(XPath
				for: 'element(undeclared:*)'
				in: namespacedDocument
				context: (XPathContext namespaces: mappings))]
		raise: XPathUndeclaredPrefixException.
]

{ #category : #tests }
XPathTest >> testElementNameTest [
	self assert:
		(document xPath: 'element(addressbook)/element(person)') =
			(document allElementsNamed: 'person').
	self assert:
		(namespacedDocument xPath:
			'element(addressbook)/element(person)') isEmpty.
]

{ #category : #tests }
XPathTest >> testElementPrefixWildcardTest [
	| persons |

	persons := namespacedDocument allElementsNamed: 'person'.
	self
		assert: (namespacedDocument xPath: 'element(*:addressbook)/element(*:person)') = persons;
		assert: (namespacedDocument xPath: 'element(*:addressbook)/element(*:contaxt-info)') isEmpty.
	self assert:
		(XPath
			for: 'element(one:addressbook)/element(*:person)'
			in: namespacedDocument
			context: (XPathContext new declarePrefix: 'one' uri: 'bookNS')) = persons.
	self assert:
		(XPath
			for: 'element(one:addressbook)/element(*:contact-info)'
			in: namespacedDocument
			context: (XPathContext new declarePrefix: 'one' uri: 'bookNS')) isEmpty.
]

{ #category : #tests }
XPathTest >> testElementQualfiedNameTest [
	| persons mappings |

	persons := namespacedDocument allElementsNamed: 'person'.
	mappings := 
		Array
			with: 'one' -> 'bookNS'
			with: 'two' -> 'personNS'.
	self assert:
		(namespacedDocument xPath:
			'element(book:addressbook)/element(ps:person)') = persons.
	self assert:
		(namespacedDocument xPath:
			'element(book:addressbook)/element(undeclared:person)') isEmpty.
	self assert:
		(XPath
			for: 'element(one:addressbook)/element(two:person)'
			in: namespacedDocument
			context: (XPathContext namespaces: mappings)) = persons.
	self assert:
		(XPath
			for: 'element(one:addressbook)/element(one:person)'
			in: namespacedDocument
			context: (XPathContext namespaces: mappings)) isEmpty.
	self
		should: [
			(XPath
				for: 'element(undeclared:addressbook)'
				in: namespacedDocument
				context: (XPathContext namespaces: mappings))]
		raise: XPathUndeclaredPrefixException.
]

{ #category : #tests }
XPathTest >> testElementTypeTest [
	self
		assert: (document xPath: '//element()') = document allElements;
		assert: (document xPath: '//node()/self::element()') = document allElements
]

{ #category : #tests }
XPathTest >> testExpandedNameTest [
	| persons |

	persons := namespacedDocument allElementsNamed: 'person'.
	self
		assert: (namespacedDocument xPath: 'Q{bookNS}addressbook/Q{personNS}person') = persons;
		assert: (namespacedDocument xPath: 'Q{undeclared}addressbook') isEmpty.
	self
		should: [namespacedDocument xPath: 'Q{bookNS} addressbook']
		raise: XPathSyntaxException.
	self
		should: [namespacedDocument xPath: 'Q {bookNS}addressbook']
		raise: XPathSyntaxException.
]

{ #category : #tests }
XPathTest >> testFalseFunction [
	self deny: 'false()' asXPath evaluate.
	self
		should: ['false(1)' asXPath evaluate]
		raise: XPathArgumentNumberException.
]

{ #category : #tests }
XPathTest >> testFileterExpressionLocationPath [
	self assert:
		(document xPath: '(./addressbook/*)[position() <= 3 and position() > 1]') =
			((document allElementsNamed: 'person') copyFrom: 2 to: 3).
	self assert:
		(document xPath: '(addressbook/*)[true()] / address') =
			(document allElementsNamed: 'address').
	self assert:
		(document xPath: '(addressbook)[true()] // email') =
			(document allElementsNamed: 'email').
]

{ #category : #tests }
XPathTest >> testFollowingAxis [
	| persons following |

	persons := document allElementsNamed: 'person'.
	following := XMLNodeList new.
	persons allButFirst do: [:person |
		person allNodesDo: [:each | following addLast: each]].
	self assert:
		(XPath
			for: 'addressbook/person/following::node()'
			in: document) = following.

	following removeAll.
	persons do: [:person |
		 person nodes allButFirst do: [:node |
			node allNodesDo: [:each | following addLast: each]]].
	self assert:
		(XPath
			for: 'addressbook/person/node()/following::node()'
			in: document) = following.

	following removeAll.
	persons first descendentNodesDo: [:each |
		each previousNode
			ifNotNil: [following addLast: each]].
	persons allButFirst do: [:person |
		person allNodesDo: [:each | following addLast: each]].
	self assert:
		(XPath
			for: '//following::node()'
			in: document) = following.

	following removeAll.
	persons allButFirst do: [:person |
		person allNodesDo: [:each | following addLast:each]].
	self assert:
		(XPath
			for: '(//person[1]|//person[3]/node()[1])/following::node()'
			in: document) = following.
	self assert:
		(XPath
			for: '(//person[1]|//person[last()])/following::node()'
			in: document) = following.
]

{ #category : #tests }
XPathTest >> testFollowingSiblingAxis [
	| persons siblings |

	persons := document allElementsNamed: 'person'.
	siblings := persons allButFirst.
	self assert:
		(XPath
			for: 'addressbook/person/following-sibling::person'
			in: document) = siblings.

	siblings := XMLNodeList new.
	persons do: [:each | siblings addAll: each nodes allButFirst].
	self assert:
		(XPath
			for: 'addressbook/person/node()/following-sibling::node()'
			in: document) = siblings.

	siblings := persons first descendentNodesSelect: [:each | each previousNode notNil].
	siblings addAll: persons allButFirst.
	self assert:
		(XPath
			for: 'addressbook/person[1]//following-sibling::node()'
			in: document) = siblings.

	siblings := document allNodesSelect: [:each |
		each hasParent
			and: [each previousNode notNil]].
	self assert:
		(XPath
			for: '//following-sibling::node()'
			in: document) = siblings.

	siblings := persons copyFrom: 2 to: 3.
	siblings
		addAll: persons third nodes allButFirst;
		addLast: persons last.
	self assert:
		(XPath
			for: '(//person[1]|//person[3]/node()[1])/following-sibling::node()'
			in: document) = siblings.
]

{ #category : #tests }
XPathTest >> testFunctions [
	| functionSet |

	functionSet := XPathFunctionSet default.
	self
		assert: XPathContext new functions = functionSet;
		deny: XPathContext new functions == functionSet;
		assert: (XPathContext functions: functionSet) functions == functionSet;
		assert: (XPathContext new functions: functionSet) functions == functionSet.
]

{ #category : #tests }
XPathTest >> testIDFunction [
	| xmlWithIds documentWithIds idElements |

	xmlWithIds :=
		'<!DOCTYPE one [
			<!ELEMENT one ANY>
			<!ATTLIST one id ID #REQUIRED>
			<!ELEMENT two ANY>
			<!ATTLIST two id2 ID #IMPLIED>
			<!ELEMENT three ANY>
			<!ATTLIST three
				id ID #REQUIRED
				id3 CDATA #IMPLIED>
			<!ELEMENT four ANY>
			<!ATTLIST four id4 ID #REQUIRED>
			<!ELEMENT five ANY>
			<!ATTLIST five id CDATA #IMPLIED>
			<!ELEMENT six ANY>
			<!ATTLIST six id2 CDATA #IMPLIED>
			<!ELEMENT seven ANY>
			<!ATTLIST seven id4 CDATA #IMPLIED>
		]>
		<one id="first"><two/><three id="third" id3="non-id"><four id4="fourth">
			<five id="non-id">first</five>
			<six id2="non-id">third</six>
			<seven id4="non=id">non-id</seven>
		</four></three></one>'.
	documentWithIds :=
		XMLDOMParser
			parse: xmlWithIds
			usingNamespaces: true
			validation: true.

	idElements :=
		documentWithIds allElements select: [:each |
				each isNamedAny: #('one' 'three')].
	self
		assert: (documentWithIds xPath: 'id("  first  third  non-id  ")') = idElements;
		assert: (documentWithIds xPath: 'id("first third non-id")') = idElements;
		assert: (documentWithIds xPath: 'id(//*)') = idElements.
]

{ #category : #tests }
XPathTest >> testInvalidAbbreviatedLocationPath [
	self
		should: ['/ /one' asXPath compile]
		raise: XPathSyntaxException.
	self
		should: ['one/ /two' asXPath compile]
		raise: XPathSyntaxException.
	self
		should: ['//' asXPath compile]
		raise: XPathSyntaxException.
	self
		should: ['//one/' asXPath compile]
		raise: XPathSyntaxException.
]

{ #category : #tests }
XPathTest >> testInvalidNumberTokenizing [
	self
		should: ['. 1' asXPath evaluate]
		raise: XPathSyntaxException.
	self
		should: ['1 .' asXPath evaluate]
		raise: XPathSyntaxException.
	self
		should: ['.1.2' asXPath evaluate]
		raise: XPathSyntaxException.
	self
		should: ['1.2.' asXPath evaluate]
		raise: XPathSyntaxException.
]

{ #category : #tests }
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

{ #category : #tests }
XPathTest >> testLastFunction [
	| path elements |

	path := XPath for: 'last()'.
	self assert: (path in: document) = 1.

	path := XPath for: 'last()'.
	elements := document allElementsNamed: 'person'.
	elements do: [:each | self assert: (path in: each) = 1].

	path := XPath for: 'addressbook/person[last()]'.
	self assert:
		(path in: document) =
			(elements allButFirst: elements size - 1).
			
	path := XPath for: 'addressbook//node()[last()]'.
	self assert:
		(path in: document) =
			(XMLNodeList with: document allNodes last).

	self
		should: ['last(0)' asXPath evaluate]
		raise: XPathException.
]

{ #category : #tests }
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

{ #category : #tests }
XPathTest >> testLocalNameWildcardTest [
	| persons mappings |

	persons := namespacedDocument allElementsNamed: 'person'.
	mappings := 
		Array
			with: 'one' -> 'bookNS'
			with: 'two' -> 'personNS'.
	self
		assert: (namespacedDocument xPath: 'book:*/ps:*') = persons;
		assert: (namespacedDocument xPath: 'book:*/undeclared:*') isEmpty.
	self assert:
		(XPath
			for: 'one:*/two:*'
			in: namespacedDocument
			context: (XPathContext namespaces: mappings)) = persons.
	self assert:
		(XPath
			for: 'one:*/one:*'
			in: namespacedDocument
			context: (XPathContext namespaces: mappings)) isEmpty.
	self
		should: [
			(XPath
				for: 'undeclared:*'
				in: namespacedDocument
				context: (XPathContext namespaces: mappings))]
		raise: XPathUndeclaredPrefixException.
]

{ #category : #tests }
XPathTest >> testLogicalOperators [
	self
		deny: '0 or 0 or 0' asXPath evaluate;
		assert: '0 or 0 or 1' asXPath evaluate;
		deny: '1 and 1 and 0' asXPath evaluate;
		assert: '1 and 1 and 2' asXPath evaluate
]

{ #category : #tests }
XPathTest >> testNameFunction [
	| element |

	(element := XMLElement named: 'test')
		addNode: (XMLElement named: 'test-two');
		addNode: 'test-three' asXMLString.
	self
		assert: (XPath for: 'name()' in: element) = 'test';
		assert: (XPath for: 'name(//.)' in: element) = 'test'.

	element name: 'test' namespaceURI: 'defaultNS'.
	self assert: (XPath for: 'name()' in: element) = 'test'.
	self assert:
		(XPath
			for: 'name()'
			in: element
			context:
				(XPathContext new
					declarePrefix: 'one'
					uri: 'defaultNS')) = 'test'.

	element name: 'prefix:test' namespaceURI: 'prefixNS'.
	self assert: (XPath for: 'name()' in: element) = 'prefix:test'.
	self assert:
		(XPath
			for: 'name()'
			in: element
			context:
				(XPathContext new
					declarePrefix: 'two'
					uri: 'prefixNS')) = 'two:test'.

	self assert: (XPath for: 'name(//text())' in: element) isEmpty.
]

{ #category : #tests }
XPathTest >> testNamespaceAxis [
	| nodes |

	nodes := XPathNodeSet new.
	namespacedDocument allElementsDo: [:each |
		nodes
			add: (XPathNamespaceNode withXMLNamespaceOnElement: each);
			add: (XPathNamespaceNode element: each name: '' uri: 'defaultNS');
			add: (XPathNamespaceNode element: each name: 'book' uri: 'bookNS');
			add: (XPathNamespaceNode element: each name: 'ps' uri: 'personNS')].
	self
		assert: nodes size = (namespacedDocument allElements size * 4);
		assert: (namespacedDocument xPath: '//namespace::*') = nodes;
		assert:
			(namespacedDocument xPath: '//namespace::book') =
				(nodes select: [:each | each name ='book']).

	"namespace nodes can't be prefixed or namespaced themselves:"
	self
		assert: (namespacedDocument xPath: '//namespace::book:*') isEmpty;
		assert: (namespacedDocument xPath: '//namespace::book/namespace::book') isEmpty.

	nodes :=
		document allElementsCollect: [:each |
				XPathNamespaceNode withXMLNamespaceOnElement: each].
	self assert: (document xPath: '//namespace::*') = nodes.
]

{ #category : #tests }
XPathTest >> testNamespaceNameTest [
	self assert:
		(document xPath: '//namespace::namespace( xml )') =
			(document allElements collect: [:each | each namespaceNodes first]).
	self assert: (document xPath: '//namespace::namespace( undeclared )') isEmpty.
]

{ #category : #tests }
XPathTest >> testNamespaceTypeTest [
	| results |

	results := XMLNodeList new.
	namespacedDocument allNodesDo: [:each |
		each isElement
			ifTrue: [results addAll: each namespaceNodes]
			ifFalse: [
				each isStringNode
					ifTrue: [results addLast: each]]].
	self assert:
		(namespacedDocument xPath: '//namespace::node() | //text()') = results.
	self assert:
		(namespacedDocument xPath: '(//namespace::node() | //text())/ self :: namespace()') =
			(results select: [:each | each isNamespace]).
]

{ #category : #tests }
XPathTest >> testNamespaceURIFunction [
	self
		assert: (document xPath: 'namespace-uri(/*)') isEmpty;
		assert: (document root xPath: 'namespace-uri()') isEmpty;
		assert: (document xPath: 'namespace-uri(/*/*)') isEmpty;
		assert: (namespacedDocument xPath: 'namespace-uri(/*)') = 'bookNS';
		assert: (namespacedDocument root xPath: 'namespace-uri()') = 'bookNS';
		assert: (namespacedDocument xPath: 'namespace-uri(/*/*)') = 'personNS'
]

{ #category : #tests }
XPathTest >> testNestedFunctionCalls [
	self
		assert: 'number(ceiling(3.5) + floor(1.5))' asXPath evaluate = 5;
		assert: 'contains(concat(concat("one", "two"), string("three")), "two")' asXPath evaluate
]

{ #category : #tests }
XPathTest >> testNodeSetAndBooleanComparing [
	self assert:
		('<list><a>not-empty</a></list>' parseXML xPath:
			'list/b < true()
				and list/b <= true()
				and list/a > false()
				and list/a >= false()
				and false() < list/a
				and true() <= list/a
				and true() > list/b
				and false() >= list/b
				and not(list/b < false())
				and not(list/a <= false())
				and not(list/b > true())
				and not(list/b >= true())
				and not(true() < list/a)
				and not(true() <= list/b)
				and not(true() > list/a)
				and not(false() >= list/a)')
]

{ #category : #tests }
XPathTest >> testNodeSetAndNonNodeSetEquality [
	self assert:
		('<list><a>1</a><a>two</a></list>' parseXML xPath:
			'list/a = 1.0
				and 1.0 = list/a
				and not(list/a = 2.0)
				and not(2.0 = list/a)
				and list/a = "two"
				and "two" = list/a
				and not(list/a = "one")
				and not("one" = list/a)
				and list/a = true()
				and true() = list/a
				and not(list/absent = true())
				and not(true() = list/absent)')
]

{ #category : #tests }
XPathTest >> testNodeSetAndNonNodeSetInequality [
	self assert:
		('<list><a>1</a><b>two</b></list>' parseXML xPath:
			'list/a != 2.0
				and 2.0 != list/a
				and not(list/a != 1.0)
				and not(1.0 != list/a)
				and list/b != "one"
				and "one" != list/b
				and not(list/b != "two")
				and not("two" != list/b)
				and list/a != false()
				and false() != list/a
				and list/absent != true()
				and true() != list/absent')
]

{ #category : #tests }
XPathTest >> testNodeSetAndNumberComparing [
	self assert:
		('<list><a>1</a><a>2</a></list>' parseXML xPath:
			'list/a < 2
				and list/a <= 1
				and list/a > 1
				and list/a >= 2
				and 1 < list/a
				and 2 <= list/a
				and 2 > list/a
				and 2 >= list/a
				and not(list/a < 1)
				and not(list/a <= 0)
				and not(list/a > 3)
				and not(list/a >= 3)
				and not(3 < list/a)
				and not(3 <= list/a)
				and not(0 > list/a)
				and not(0 >= list/a)')
]

{ #category : #tests }
XPathTest >> testNodeSetComparing [
	self assert:
		('<list>
			<a>1</a><a>2</a><a>3</a>
			<b>0</b>
			<c>4</c>
		</list>' parseXML xPath:
			'list/a < list/a
				and list/a <= list/a
				and list/a > list/a
				and list/a >= list/a
				and list/b < list/a
				and list/b <= list/a
				and not(list/b > list/a)
				and not(list/b >= list/a)
				and not(list/c < list/a)
				and not(list/c <= list/a)
				and list/c > list/a
				and list/c >= list/a')
]

{ #category : #tests }
XPathTest >> testNodeSetEquality [
	self assert:
		('<list>
			<a>one</a><a>two</a><a>three</a>
			<b>four</b>
		</list>' parseXML xPath:
			'list/a = list/a
				and list/a != list/a
				and not(list/b = list/a)
				and list/b != list/a
				and not(list/absent = list/a)
				and not(list/absent = list/absent)
				and not(list/absent != list/a)
				and not(list/absent != list/absent)')
]

{ #category : #tests }
XPathTest >> testNormalizeSpaceFunction [
	self assert:
		'normalize-space("
		    one		  
		    two
		    three
		")' asXPath evaluate = 'one two three'.
	self assert: 'normalize-space(" 	")' asXPath evaluate isEmpty.
]

{ #category : #tests }
XPathTest >> testNotFunction [
	self	
		deny: 'not(true())' asXPath evaluate;
		assert: 'not(false())' asXPath evaluate;
		deny: 'not(1) or not("1")' asXPath evaluate;
		assert: 'not(0) and not("")' asXPath evaluate;
		deny: (document xPath: 'not(/node())');
		assert: (document xPath: 'not(/text())').
	self
		should: ['not()' asXPath evaluate]
		raise: XPathArgumentNumberException.
]

{ #category : #tests }
XPathTest >> testNumberTokenizing [
	self
		assert: ' 1 ' asXPath evaluate = 1;
		assert: ' 12 ' asXPath evaluate = 12;
		assert: ' 1.5 ' asXPath evaluate = 1.5;
		assert: ' 12.5 ' asXPath evaluate = 12.5;
		assert: ' -1 ' asXPath evaluate = -1;
		assert: ' -12 ' asXPath evaluate = -12;
		assert: ' -1.5 ' asXPath evaluate = -1.5;
		assert: ' -12.5 ' asXPath evaluate = -12.5;
		assert: ' .1 ' asXPath evaluate = 0.1;
		assert: ' .12 ' asXPath evaluate = 0.12;
		assert: ' -.1 ' asXPath evaluate = -0.1;
		assert: ' -.12 ' asXPath evaluate = -0.12
]

{ #category : #tests }
XPathTest >> testOneLevel [
	| path results |
	path := XPath for: 'addressbook/person'.
	results := path in: document.
	self assert: (results size = 4).
]

{ #category : #tests }
XPathTest >> testParentAxis [
	self assert:
		(XPath
			for: '//parent::*'
			in: document) = (document allElementsSelect: [:each | each hasChildren]).

	self assert:
		(XPath
			for: 'addressbook/person/parent::*'
			in: document) = (XMLNodeList with: document root).

	self assert:
		(XPath
			for: 'addressbook/person/node()/parent::*'
			in: document) = (document allElementsNamed: 'person').

	self assert:
		(XPath
			for: 'addressbook/person/attribute::node()/parent::node()'
			in: document) = (document allElementsNamed: 'person').
]

{ #category : #tests }
XPathTest >> testPositionFunction [
	self assert:
		(XPath
			for: ' position( ) '
			in: document) = 1.

	(document allElementsNamed: 'person') do: [:each |
		self assert: (XPath for: ' position() ' in: each) = 1].

	(document allElementsNamed: 'person')
		withIndexDo: [:each :i |
			self assert:
				(XPath
					for: 'addressbook/person[position() = ', i printString, ']'
					in: document) = (XMLNodeList with: each).
			self assert:
				(XPath
					for: 'addressbook/person[ ', i printString, ' ]'
					in: document) = (XMLNodeList with: each)].

	self
		should: ['position(0)' asXPath evaluate]
		raise: XPathException.
]

{ #category : #tests }
XPathTest >> testPrecedence [
	self
		assert: (XPath for: '1 + 2 * 3 + 4 div 2' in: nil) rounded = 9;
		assert: (XPath for: '(1 + 2) * (3 + 4) mod 5' in: nil) rounded = 1.
]

{ #category : #tests }
XPathTest >> testPrecedingAxis [
	| persons preceding |

	persons := document allElementsNamed: 'person'.
	preceding := XMLNodeList new.
	persons allButLast reverseDo: [:person |
		person allNodesReverseDo: [:each | preceding addLast: each]].
	self assert:
		(XPath
			for: 'addressbook/person/preceding::node()'
			in: document) = preceding.

	preceding removeAll.
	persons reverseDo: [:person |
		 person nodes allButLast reverseDo: [:node |
			node allNodesReverseDo: [:each | preceding addLast: each]]].
	self assert:
		(XPath
			for: 'addressbook/person/node()/preceding::node()'
			in: document) = preceding.

	preceding removeAll.
	persons last descendentNodes allButLast reverseDo: [:each |
		preceding addLast: each].
	persons allButLast reverseDo: [:person |
		person allNodesReverseDo: [:each | preceding addLast: each]].
	self assert:
		(XPath
			for: '//preceding::node()'
			in: document) = preceding.

	preceding removeAll.
	persons allButLast do: [:person |
		person allNodesDo: [:each | preceding addLast: each]].
	preceding := preceding reversed.
	self assert:
		(XPath
			for: '(//person[last()]|//person[2]/node()[last()])/preceding::node()'
			in: document) = preceding.
	self assert:
		(XPath
			for: '(//person[last()]|//person[1])/preceding::node()'
			in: document) = preceding.
]

{ #category : #tests }
XPathTest >> testPrecedingSiblingAxis [
	| persons siblings |

	persons := document allElementsNamed: 'person'.
	siblings := document root nodes allButLast reversed.
	self assert:
		(XPath
			for: 'addressbook/person[4]/preceding-sibling::node()'
			in: document) = siblings.

	siblings := 
		document root nodes allButLast collect: [:each |
			each elementAt: 'manager'].
	self assert:
		(XPath
			for: 'addressbook/person[4]/preceding-sibling::node()/manager'
			in: document) = siblings.

	siblings := (document allElementsNamed: 'person') allButLast.
	persons last
		descendentNodesDo: [:each |
			each nextNode
				ifNotNil: [siblings addLast: each]].
	siblings := siblings reversed.
	self assert:
		(XPath
			for: 'addressbook/person[4]//preceding-sibling::node()'
			in: document) = siblings.

	siblings :=
		(document allNodesSelect: [:each |
			each hasParent
				and: [each nextNode notNil]]) reversed.
	self assert:
		(XPath
			for: '//preceding-sibling::node()'
			in: document) = siblings.

	siblings := persons copyFrom: 1 to: 2.
	siblings
		addAll: persons second nodes allButLast;
		addLast: persons third.
	siblings := siblings reversed.
	self assert:
		(XPath
			for: '(//person[last()]|//person[2]/node()[last()])/preceding-sibling::node()'
			in: document) = siblings.
]

{ #category : #tests }
XPathTest >> testPrefixWildcardTest [
	| persons |

	persons := namespacedDocument allElementsNamed: 'person'.
	self
		assert: (namespacedDocument xPath: '*:addressbook/*:person') = persons;
		assert: (namespacedDocument xPath: '*:addressbook/*:contaxt-info') isEmpty.
	self assert:
		(XPath
			for: 'one:addressbook/*:person'
			in: namespacedDocument
			context: (XPathContext new declarePrefix: 'one' uri: 'bookNS')) = persons.
	self assert:
		(XPath
			for: 'one:addressbook/*:contact-info'
			in: namespacedDocument
			context: (XPathContext new declarePrefix: 'one' uri: 'bookNS')) isEmpty.
]

{ #category : #tests }
XPathTest >> testProcessingInstructionTypeTest [
	| xml |

	xml := '<root>before<?one two?><?three four?>after</root>' parseXML.
	self assert:
		(xml xPath: '// processing-instruction ()') =
			(xml root nodes copyFrom: 2 to: 3).
	self assert:
		(xml xPath: '// processing-instruction ( "three" )') =
			(xml root nodes copyFrom: 3 to: 3).
	self assert:
		(xml xPath: '// processing-instruction ( one )') =
			(xml root nodes copyFrom: 2 to: 2).
]

{ #category : #tests }
XPathTest >> testQualfiedNameTest [
	| persons mappings |

	persons := namespacedDocument allElementsNamed: 'person'.
	mappings := 
		Array
			with: 'one' -> 'bookNS'
			with: 'two' -> 'personNS'.
	self
		assert: (namespacedDocument xPath: 'book:addressbook/ps:person') = persons;
		assert: (namespacedDocument xPath: 'book:addressbook/undeclared:person') isEmpty.
	self assert:
		(XPath
			for: 'one:addressbook/two:person'
			in: namespacedDocument
			context: (XPathContext namespaces: mappings)) = persons.
	self assert:
		(XPath
			for: 'one:addressbook/one:person'
			in: namespacedDocument
			context: (XPathContext namespaces: mappings)) isEmpty.
	self
		should: [
			(XPath
				for: 'undeclared:addressbook'
				in: namespacedDocument
				context: (XPathContext namespaces: mappings))]
		raise: XPathUndeclaredPrefixException.
]

{ #category : #tests }
XPathTest >> testReverseForwardAxisCombination [
	| nodes |

	nodes := XPathNodeSet new.
	(document allElementsNamed: 'person') allButLast do: [:person |
		person descendentNodesDo: [:each |
			nodes addLast: each]].
	self assert:
		(XPath for: '*/person[last()]/preceding::node()/node()' in: document) =
			nodes.
]

{ #category : #tests }
XPathTest >> testSelfAxis [
	self assert:
		(XPath
			for: ' / self::node() '
			in: document) = (XMLNodeList with: document).
	self assert:
		(XPath
			for: ' /*/person/self::*'
			in: document) = (document allElementsNamed: 'person').
	self assert:
		(XPath
			for: ' /*/person/node()/self::node()'
			in: document) =
				(document allNodesSelect: [:each |
					each hasParent
						and: [each parent isElementNamed: 'person']]).
	self assert: 
		(XPath
			for: ' //person[1]/attribute::node()/. '
			in: document) = (document findElementNamed: 'person') attributeNodes.
	self assert: 
		(XPath
			for: ' //person[1]/attribute::node()/self::* '
			in: document) isEmpty.
]

{ #category : #tests }
XPathTest >> testSorting [
	| allNodes |

	allNodes := document allNodes.
	(Array
		with: (XPathNodeSet newFrom: allNodes)
		with: (XPathNodeSet newFrom: allNodes reversed))
		do: [:nodeSet |
			self
				assert: nodeSet sorted = allNodes;
				assert: nodeSet sorted reversed sorted = allNodes].
]

{ #category : #tests }
XPathTest >> testStartsWithFunction [
	self
		assert: 'starts-with("onetwothree", "one")' asXPath evaluate;
		deny: 'starts-with("onetwothree", "ONE")' asXPath evaluate;
		assert: 'starts-with("123", 1)' asXPath evaluate
]

{ #category : #tests }
XPathTest >> testStringLengthFunction [
	self
		assert: 'string-length("test")' asXPath evaluate = 4;
		assert: 'string-length(false())' asXPath evaluate = 5;
		assert: ('string-length()' asXPath in: 'string-value' asXMLString) = 12
]

{ #category : #tests }
XPathTest >> testSubstringAfterFunction [
	self
		assert: 'substring-after("onetwothree", "one")' asXPath evaluate = 'twothree';
		assert: 'substring-after("onetwothree", ''two'')' asXPath evaluate = 'three';
		assert: 'substring-after("onetwothree", "three")' asXPath evaluate isEmpty;
		assert: 'substring-after("onetwothree", "four")' asXPath evaluate isEmpty
]

{ #category : #tests }
XPathTest >> testSubstringBeforeFunction [
	self
		assert: 'substring-before("onetwothree", "one")' asXPath evaluate isEmpty;
		assert: 'substring-before("onetwothree", ''two'')' asXPath evaluate = 'one';
		assert: 'substring-before("onetwothree", "three")' asXPath evaluate = 'onetwo';
		assert: 'substring-before("onetwothree", "four")' asXPath evaluate isEmpty
]

{ #category : #tests }
XPathTest >> testSubstringFunction [
	self
		assert: 'substring("onetwothree", 4, 3)' asXPath evaluate = 'two';
		assert: 'substring("onetwothree", 4)' asXPath evaluate = 'twothree';
		assert: 'substring("onetwothree", -3, 2)' asXPath evaluate = 'on';
		assert: 'substring("onetwothree", 12, 2)' asXPath evaluate isEmpty;
		assert: 'substring("", 0, 1)' asXPath evaluate isEmpty;
		assert: 'substring("", 0)' asXPath evaluate isEmpty
]

{ #category : #tests }
XPathTest >> testSumFunction [
	self assert:
		('<nums><one>1</one><two>2</two><three>3</three></nums>' parseXML
			xPath: 'sum(/nums/*)') = 6.
	self
		should: ['sum()' asXPath evaluate]
		raise: XPathArgumentNumberException.
]

{ #category : #tests }
XPathTest >> testTextTypeTest [
	self assert:
		(document xPath: ' //text( ) ') =
			(document allNodesSelect: [:each | each isStringNode]).
	self assert:
		(document xPath: '//text()/self::text()') =
			(document allNodesSelect: [:each | each isStringNode]).
	self assert: (document xPath: ' //text()/text()') isEmpty.
]

{ #category : #tests }
XPathTest >> testThreeLevel [
	| path results |
	path := XPath for: '*/person/contact-info/email'.
	results := path in: document.
	self assert: (results size = 2).
]

{ #category : #tests }
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

{ #category : #tests }
XPathTest >> testTranslateFunction [
	self
		assert: 'translate("onetwothree", "oe", "O")' asXPath evaluate = 'OntwOthr';
		assert: 'translate("onetwothree", "oe", "OEN")' asXPath evaluate = 'OnEtwOthrEE';
		assert: 'translate("onetwothree", "z", "x")' asXPath evaluate = 'onetwothree'
]

{ #category : #tests }
XPathTest >> testTrueFunction [
	self assert: 'true()' asXPath evaluate.
	self
		should: ['true(1)' asXPath evaluate]
		raise: XPathArgumentNumberException.
]

{ #category : #tests }
XPathTest >> testTwoLevel [
	| path results |
	path := XPath for: '/*/person/address'.
	results := path in: document.
	self assert: (results size = 4).
]

{ #category : #tests }
XPathTest >> testUndeclaredFunctions [
	self
		should: [XPath for: 'undeclared()/addressbook' in: document]
		raise: XPathUndeclaredFunctionException.
	self
		should: [XPath for: 'addressbook[undeclared()]' in: document]
		raise: XPathUndeclaredFunctionException.
]

{ #category : #tests }
XPathTest >> testUndeclaredVariables [
	self
		should: [XPath for: '$undeclared/addressbook' in: document]
		raise: XPathUndeclaredVariableException.
	self
		should: [XPath for: 'addressbook[$undeclared]' in: document]
		raise: XPathUndeclaredVariableException.
]

{ #category : #tests }
XPathTest >> testUnion [
	| union |

	union := document allElementsNamed: 'person'.
	self assert:
		(XPath
			for:
				'addressbook/person[position() = 1 or position() = 4] |
				(addressbook/person[4]/ preceding-sibling::* [position() < 4])'
			in: document) = union.

	union removeAll.
	document allElementsNamed: 'person' do: [:each |
		union
			addLast: each;
			addAll: each namespaceNodes;
			addAll: each attributeNodes;
			addAll: each elements].
	self assert:
		(XPath
			for: 'addressbook/person/@* | */person/@@* | addressbook/person | */person/*'
			in: document) = union.

	union removeAll.
	(document allElementsNamed: 'person') first
		namespaceNodesDo: [:each | union addLast: each];
		attributeNodesDo: [:each | union addLast: each];
		nodesDo: [:each | union addLast: each].
	self assert:
		(XPath
			for: 'addressbook/person[1]/node() | */person[1]/@* | addressbook/person[1]/@@*'
			in: document) = union.
]

{ #category : #tests }
XPathTest >> testVariables [
	| context result |

	(context := XPathContext new)
		variableAt: 'doc' put: document;
		variableAt: 'pos' ifAbsentPut: [4].
	result :=
		(XPath for: '$doc/addressbook/person[position() != $pos]')
			in: nil
			context: context.
	self assert: result = (document allElementsNamed: 'person') allButLast.

	context :=
		XPathContext variables:
			(Dictionary
				with: 'doc' -> document
				with: 'city' -> 'Los Angeles').
	result :=
		(XPath for: '($doc)/addressbook/person[.//address[@city=$city]]')
			in: nil
			context: context.
	self
		assert: result size = 2;
		assert:
			result =
				((document allElementsNamed: 'person') select: [:each |
					((each elementAt: 'address') attributeAt: 'city') = 'Los Angeles']).
]

{ #category : #tests }
XPathTest >> testWildcard [
	| path results |

	path := XPath for: 'addressbook/*'.
	results := path in: document.
	self
		assert: results size = 4;
		assert: results = (document allElementsNamed: 'person')
]

{ #category : #tests }
XPathTest >> testWildcardDescendant [
	| path results |

	path := XPath for: '//*'.
	results := path in: document.
	self
		assert: (results size = 28);
		assert: results = document descendentElements
]

{ #category : #tests }
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

{ #category : #tests }
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
