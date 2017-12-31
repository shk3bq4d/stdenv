
#element minoccurs The default values for minOccurs and maxOccurs are 1. Thus:


# nillable
<!-- nothing -->
<myElement attr1='true'>some content</myElement>
<myElement/>
<myElement xsi:nil='true'/>


<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema"
    elementFormDefault="qualified" targetNamespace="foobar"
    xmlns:f="foobar">
    <xs:element name="inspection">
        <xs:complexType>
            <xs:sequence minOccurs="1" maxOccurs="unbounded">
                <xs:element ref="f:input" />
            </xs:sequence>
        </xs:complexType>
    </xs:element>
    <xs:element name="input">
        <xs:complexType>
            <xs:simpleContent>
                <xs:extension base="xs:integer">
                    <!--other attributes-->
                    <xs:attribute name="row" use="optional" type="xs:integer" />


XML duration example
P1D
PT10H5S
PT6000M
PT12000M
PT360000S
PT720000S
P5Y11M
P2M4DT10M5.23S

"P1D"
PT10H5S
PT6000M
PT12000M
PT360000S
PT720000S
P5Y11M
P2M4DT10M5.23S
