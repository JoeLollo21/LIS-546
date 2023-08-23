<!-- Designing an XML Schema -->
<!-- Schema Chosen: Poem -->

<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns="http://purl.oclc.org/dsdl/schematron" >
	<!-- XML Namespace Chosen: TEI (Text Encoding Initiative) -->
	<ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>
	
	<!-- Rule 1: Flags any line element without a line break. -->
	<pattern>
		<rule context="tei:l">
			<assert test="tei:lb">Every l element must contain an lb element.</assert>
		</rule>
	</pattern>	

	<!-- Rule 2: Flags the line number attribute in a divider if it does not begin with the string "poem." -->
	<pattern>
		<rule context="tei:div/@n">
			<assert test="starts-with(.,'poem')">Attributes must begin with 'poem'.</assert>
		</rule>
	</pattern>

	<!-- Rule 3: Line numbers must contain 4 digits. Flags any line numbers that does not contain 4 digits. i.e.: n="0001" is correct, n="1", n="01", and n="001" are incorrect. -->
	<pattern>
		<rule context="tei:l/@n">
			<assert test="matches(.,'\d\d\d\d+')">Line numbers (@n attributes) must have at least 4 digits.</assert>
		</rule>
	</pattern>

	<!-- Rule 4: Flags divider types if they do not contain "sonnet" or "limerick." -->
	<pattern>
		<rule context="tei:div/@type">
			<assert test=".='sonnet' or .='limerick'">The @type attribute on a div element must have either 'sonnet' or 'limerick' as its value.</assert>
		</rule>
	</pattern>

	<!-- Rule 5: Flags revisions or changes when they have no content. -->
	<pattern>
		<rule context="tei:revisionDesc/tei:change">
			<assert test="string-length()ne 0">Every change element in a RevisionDesc section must contain some text content.</assert>
		</rule>
	</pattern>

	<!-- Rule 6: Write a rule to check that each line in a poem is immediately followed by a line break. -->
	<pattern>
		<rule context="tei:l">
			<assert test="tei:lb">Every l element must contain an lb element within it.</assert>
			<assert test="*[1]='tei:lb'">The first and only child of each l element should be an lb.</assert>
		</rule>
	</pattern>

</sch:schema>
