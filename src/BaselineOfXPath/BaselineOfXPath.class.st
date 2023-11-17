"
Baseline for XPath library for Pharo (see https://github.com/pharo-contributions/XML-XPath)
"
Class {
	#name : #BaselineOfXPath,
	#superclass : #BaselineOf,
	#category : #BaselineOfXPath
}

{ #category : #baseline }
BaselineOfXPath >> baselineOf: spec [

	<baseline>
	spec for: #common do: [
		self xmlParserOn: spec.

		"Packages"
		spec
			package: 'XPath-Core' with: [ spec requires: #( 'XMLParser' ) ];
			package: 'XPath-Tests'
			with: [ spec requires: #( 'XMLParser Tests' 'XPath-Core' ) ];
			package: 'XPath-Inspector'
			with: [ spec requires: #( 'XMLParser Tools' 'XPath-Core' ) ].

		"Core group"
		spec group: 'Core' with: #( 'XPath-Core' ).

		"Tools group"
		spec group: 'Tools' with: #( 'XPath-Inspector' ).
		spec for: #( #'pharo8.x' #'pharo7.x' #'pharo6.x' ) do: [
			spec
				package: 'XPath-GTExtensions'
				with: [ spec requires: #( 'XMLParser Tools' 'XPath-Core' ) ];
				group: 'Tools' with: #( 'XPath-GTExtensions' ) ].

		"Other groups"
		spec
			group: 'Tests' with: #( 'XPath-Tests' );
			group: 'all' with: #( 'Tools' 'Tests' );
			group: 'default' with: #( 'all' ) ]
]

{ #category : #baseline }
BaselineOfXPath >> xmlParserOn: spec [

	spec baseline: 'XMLParser' with: [
		spec
			loads: #( 'Core' );
			repository: 'github://pharo-contributions/XML-XMLParser:v3.6.1/src' ].

	spec
		project: 'XMLParser Tests'
		copyFrom: 'XMLParser'
		with: [ spec loads: #( 'Tests' ) ];
		project: 'XMLParser Tools'
		copyFrom: 'XMLParser'
		with: [ spec loads: #( 'Tools' ) ]
]
