Class {
	#name : #XPathTest,
	#superclass : #TestCase,
	#instVars : [
		'xml',
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
	"Need this for VW parser"
	| parser |
	xml := self addressBookXML.
	"This is for the basic XML parser (what's it called again?)"
	document := XMLDOMParser parseDocumentFrom: xml readStream.
	"This is for the ported VW parser
	parser := VWXMLXMLParser on: XMLTokenizer addressBookXML readStream.
	parser validate: false.
	parser scanDocument.
	document := parser documentNode root"
]

{ #category : #testing }
XPathTest >> testAttribute [
	| path results |
	path := XPath for: 'person/address/@city'.
	results := path in: document.
	self assert: results size = 4 & (results size > 0).
	self assert: (results at: 1)
			= 'Los Angeles'
]

{ #category : #testing }
XPathTest >> testCount [
	| path results |
	path := XPath for: 'count(person)'.
	results := path in: document.
	self assert: results size = 1.
	self assert: ((results at: 1) = 4).
]

{ #category : #testing }
XPathTest >> testDescendant [
	| path results |
	path := XPath for: '//address/@city'.
	results := path in: document.
	self assert: results size = 4 & (results size > 0).
	self assert: (results at: 1)
			= 'Los Angeles'.

]

{ #category : #testing }
XPathTest >> testDot [
	| path results |
	path := XPath for: 'person/address/./@city'.
	results := path in: document.
	self assert: results size = 4 & (results size > 0).
	self assert: (results at: 1)
			= 'Los Angeles'.

]

{ #category : #testing }
XPathTest >> testDotDot [
	| path results |
	path := XPath for: 'person/address/../address/@city'.
	results := path in: document.
	self assert: results size = 4 & (results size > 0).
	self assert: (results at: 1)
			= 'Los Angeles'.

]

{ #category : #testing }
XPathTest >> testDotDotTooHigh [
	| path results |
	path := XPath for: 'person/address/../../../address/@city'.
	results := path in: document.
	self assert: (results size = 0).
]

{ #category : #testing }
XPathTest >> testLast [
	| path results |
	path := XPath for: 'person/last()'.
	results := path in: document.
	self assert: (results size = 4).
]

{ #category : #testing }
XPathTest >> testOneLevel [
	| path results |
	path := XPath for: 'person'.
	results := path in: document.
	self assert: (results size = 4).
]

{ #category : #testing }
XPathTest >> testThreeLevel [
	| path results |
	path := XPath for: 'person/contact-info/email'.
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
XPathTest >> testTwoLevel [
	| path results |
	path := XPath for: 'person/address'.
	results := path in: document.
	self assert: (results size = 4).
]

{ #category : #testing }
XPathTest >> testWildcard [
	| path results |
	path := XPath for: '/*'.
	results := path in: document.
	self assert: (results size = 4).
]

{ #category : #testing }
XPathTest >> testWildcardDescendant [
	| path results |
	path := XPath for: '//*'.
	results := path in: document.
	self assert: (results size = 27).
]

{ #category : #testing }
XPathTest >> testWildcardDescendantAttribute [
	| path results |
	path := XPath for: '//*/@city'.
	results := path in: document.
	self assert: results size = 4 & (results size > 0).
	self assert: (results at: 1)
			= 'Los Angeles'.

]
