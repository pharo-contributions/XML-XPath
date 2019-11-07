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
	spec
		for: #common
		do: [
			
			self 
				xmlParserOn: spec;	
				xmlWriterOn: spec.
			
			"Packages"
			spec 
				package: 'XPath-Core' with: [ spec requires: #('XMLParser') ];
				package: 'XPath-GTExtensions' with: [ spec requires: #('XMLWriter' 'XPath-Core') ];
				package: 'XPath-Tests' with: [ spec requires: #('XMLParser Tests' ) ].
			
			"Groups"
			spec
				group: 'Core' with: #('XPath-Core');
				group: 'Tools' with: #('XMLParser Tools' 'XPath-GTExtensions'); 
				group: 'Tests' with: #('XPath-Tests');	
				group: 'all' with: #('Core' 'Tools' 'Tests');
				group: 'default' with: #('all')	
	]
]

{ #category : #baseline }
BaselineOfXPath >> xmlParserOn: spec [

	spec
		baseline: 'XMLParser'
      with: [ 
			spec
				loads: #('Core');
				repository: 'github://pharo-contributions/XML-XMLParser:3.5.x/src' ]. 
				
	spec 
		project: 'XMLParser Tests' copyFrom: 'XMLParser' with: [ spec loads: #('Tests') ]; 	
		project: 'XMLParser Tools' copyFrom: 'XMLParser' with: [ spec loads: #('Tools') ] 
]

{ #category : #baseline }
BaselineOfXPath >> xmlWriterOn: spec [

	spec
		baseline: 'XMLWriter'
      with: [ 
			spec
				loads: #('Core');
				repository: 'github://pharo-contributions/XML-XMLWriter:2.8.x/src' ]. 
				
	spec 
		project: 'XMLWriter Tests' copyFrom: 'XMLWriter' with: [ spec loads: #('Tests') ]; 	
		project: 'XMLWriter Tools' copyFrom: 'XMLWriter' with: [ spec loads: #('Tools') ] 
]
