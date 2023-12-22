# XML-XPath

[![Build Status](https://travis-ci.org/pharo-contributions/XML-XPath.svg?branch=master)](https://travis-ci.org/pharo-contributions/XML-XPath) [![Coverage Status](https://coveralls.io/repos/github/pharo-contributions/XML-XPath/badge.svg?branch=master)](https://coveralls.io/github/pharo-contributions/XML-XPath?branch=master)


[![Unit Tests](https://github.com/pharo-contributions/XML-XPath/workflows/Build/badge.svg?branch=master)](https://github.com/pharo-contributions/XML-XPath/actions?query=workflow%3ABuild)
[![Coverage Status](https://codecov.io/github/pharo-contributions/XML-XPath/coverage.svg?branch=master)](https://codecov.io/gh/pharo-contributions/XML-XPath/branch/master)


An XPath library for [Pharo](http://www.pharo.org) leveraging the XML parsing capabilities of [XMLParser](https://github.com/pharo-contributions/XML-XMLParser). Supports XPath 1.0 syntax with extensions.

## Installation

```Smalltalk
Metacello new
	baseline: 'XPath';
	repository: 'github://pharo-contributions/XML-XPath/src';
	load.
```

## Usage

A simple example on how to use the XPath class:

```Smalltalk
doc := XMLDOMParser parse: aStream.
path := XPath for: 'entry/content/@src'.
urls := path in: doc.
```

This will look for each 'src' attribute of each 'content' node of all 'entry' nodes in the document.

## LICENSE
[MIT License](LICENSE)

## History
This project was migrated from [http://smalltalkhub.com/#!/~PharoExtras/XPath](http://smalltalkhub.com/#!/~PharoExtras/XPath)
